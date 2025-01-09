import 'dart:convert';
import 'package:consulin_mobile_dev/app/modules/profile_pasien/controllers/profile_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;

class DetailChatPatientController extends GetxController {
  late StreamChatClient client =
      StreamChatClient(dotenv.env["API_KEY"]!, logLevel: Level.INFO);
  late Channel channel;
  final isLoading = false.obs;

  final ProfilePasienController profilePasienController =
      Get.find<ProfilePasienController>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fetchChat();
    } else {
      print('No arguments passed');
    }
  }

  Future<void> connectUser() async {
    try {
      final userId = StorageService.getToken("user_id");
      if (userId == null) throw Exception('User ID not found in storage');

      final token = await fetchToken(
        userId,
        '${profilePasienController.profile.value.firstname} ${profilePasienController.profile.value.lastname}',
      );

      await client.connectUser(
        User(id: userId),
        token,
      );

      String? channelId = Get.arguments;
      if (channelId != null && channelId.startsWith('messaging:')) {
        channelId = channelId.substring('messaging:'.length);
      }

      if (channelId == null || channelId.isEmpty) {
        throw Exception('Invalid or missing channel ID');
      }

      channel = client.channel(
        'messaging',
        id: channelId,
      );
      await channel.watch();
    } catch (e) {
      print('Error connecting user: $e');
    }
  }

  Future<String> fetchToken(String userId, String name) async {
    final response = await http.post(
      Uri.parse('${dotenv.env["API_CHAT_URL"]}/chat-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'name': name}),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception('Error fetching token: ${error['message']}');
    }

    final data = jsonDecode(response.body);
    return data['token'];
  }

  Future<void> fetchChat() async {
    try {
      isLoading.value = true;

      await connectUser();
    } catch (e) {
      print('Error initializing chat: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
