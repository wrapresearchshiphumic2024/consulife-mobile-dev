import 'dart:convert';

import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/modules/Profile/controllers/profile_pycholog_controller.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/controllers/home_psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;

class DetailCompletedController extends GetxController {
  late StreamChatClient client;
  late Channel channel = client.channel(
    'messaging',
  ); // Declare channel without initialization here
  var selectedTabIndex = 0.obs;
  final isLoading = false.obs;
  final ProfilePychologController profilePsychologController =
      Get.find<ProfilePychologController>();

  var appointmentDetail =
      Rx<Appointment?>(null); // Observable for appointment details
  final DateTime appointmentDate = DateTime.now().add(const Duration(hours: 2));
  Rx<List<AiAnalyzer>?> aiAnalysisHistory = Rx<List<AiAnalyzer>?>(null);
  final key = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();

  final HomePsychologController homePsychologController =
      Get.find<HomePsychologController>();
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    Get.arguments != null
        ? fetchAppointmentDetails(Get.arguments.toString())
        : print('No arguments passed');
    // Initialize the StreamChatClient with the API key from environment variables
  }

  Future<void> connectUser() async {
    isLoading.value = true;
    // Check if profile is initialized

    // Fetch the user token
    final token = await fetchToken(
      StorageService.getToken("user_id").toString(),
      '${profilePsychologController.profile.value.firstname} ${profilePsychologController.profile.value.lastname}',
    );

    // Connect the user to the StreamChatClient
    await client.connectUser(
      User(id: StorageService.getToken("user_id").toString()),
      token,
    );
    // Mengambil channelId dari appointmentDetail
    String? channelId = appointmentDetail.value?.channelId;

    // Menghapus prefiks 'messaging:' jika ada
    if (channelId != null && channelId.startsWith('messaging:')) {
      channelId = channelId.substring('messaging:'.length);
    }
    // Create or get the channel
    channel = client.channel(
      'messaging',
      id: channelId,
    ); // Gunakan channelId yang sudah diubah); // Specify the channel ID
    await channel.watch(); // Watch the channel for updates
    isLoading.value = false;
  }

  Future<String> fetchToken(String userId, String name) async {
    final response = await http.post(
      Uri.parse(
          '${dotenv.env["API_CHAT_URL"]}/chat-token'), // Adjust the URL as needed
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'name': name}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch token: ${response.body}');
    }

    final data = jsonDecode(response.body);
    return data['token'];
  }

  Future<void> fetchAppointmentDetails(String appointmentId) async {
    try {
      isLoading.value = true;
      appointmentDetail.value = await PsychologstService()
          .getAppointmentDetailPsychologst(appointmentId);
      await fetchAiAnalysisHistory();
      final apiKey = dotenv.env["API_KEY"];
      if (apiKey == null) {
        throw Exception('API_KEY is not set in the environment variables');
      }
      client = StreamChatClient(apiKey, logLevel: Level.INFO);
      connectUser();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAiAnalysisHistory() async {
    try {
      // Misalnya kita menggunakan UUID pasien yang ada dalam detail janji
      String uuid = appointmentDetail.value?.user.id ?? '';

      // Ambil riwayat analisis AI dari service
      final analysisHistory =
          await PsychologstService().getAiAnalysisHistory(uuid);

      aiAnalysisHistory.value =
          analysisHistory; // Simpan hasil analisis ke dalam Rx
    } catch (e) {
      print("Error fetching AI analysis history: $e");
    }
  }

  void done(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Confirmation of Consultation Session',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to complete this session?Once the session is completed, you cannot change or cancel this action.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await doneAppointment();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: successColor,
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Yes, Complete Session',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'return',
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Future<void> doneAppointment() async {
    try {
      await PsychologstService()
          .doneAppointment(appointmentDetail.value!.id.toString());
      Fluttertoast.showToast(
        msg: "Consultation Completed",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: successColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );

      Get.back();
      fetchAppointmentDetails(Get.arguments.toString());
      homePsychologController.getConsultationDataPsychologist();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.back();
    }
  }

  Future<void> cancelAppointment() async {
    try {
      if (key.currentState!.validate()) {
        await PsychologstService().cancelAppointment(
          appointmentDetail.value!.id.toString(),
          reasonController.text,
        );
        Fluttertoast.showToast(
          msg: "Consultation Cancelled",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: warningColor,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        Get.back();
        fetchAppointmentDetails(Get.arguments.toString());
        homePsychologController.getConsultationDataPsychologist();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.back();
    }
  }

  void cancel(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Cancel Session',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to cancel this session?\n\n'
                'Please provide the reason for cancellation below:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: reasonController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Reason for cancellation',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a reason for cancellation';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await cancelAppointment();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(200, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Yes, Cancel session',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        minimumSize: const Size(200, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Return',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void joinMeet() {
    var jitsiMeet = JitsiMeet();
    var options = JitsiMeetConferenceOptions(
      room: StorageService.getToken("user_id").toString(),
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "security-options.enabled": false
      },
    );
    jitsiMeet.join(options);
  }
}
