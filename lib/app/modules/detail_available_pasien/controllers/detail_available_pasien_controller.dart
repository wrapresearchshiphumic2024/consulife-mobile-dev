import 'dart:convert';
import 'package:consulin_mobile_dev/app/models/user.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class DetailAvailablePasienController extends GetxController {
  final detailPsychologist = User(id: '', firstname: '', lastname: '').obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final selectedTime2 = <Map<String, String>>[].obs;
  final RxBool isCalendarVisible = false.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    String? uuid = Get.arguments;
    if (uuid != null) {
      getDetailPsychologistPatient(uuid);
    } else {
      print('No arguments passed');
    }
  }

  void onSelectedTime(List<Map<String, String>> value) {
    selectedTime2.value = value;
  }

  List<int> mapDaysToIndices(List<String> days) {
    return days
        .map((day) {
          switch (day.toLowerCase()) {
            case "sunday":
              return DateTime.sunday;
            case "monday":
              return DateTime.monday;
            case "tuesday":
              return DateTime.tuesday;
            case "wednesday":
              return DateTime.wednesday;
            case "thursday":
              return DateTime.thursday;
            case "friday":
              return DateTime.friday;
            case "saturday":
              return DateTime.saturday;
            default:
              return -1;
          }
        })
        .where((index) => index >= 0)
        .toList();
  }

  Future<void> getDetailPsychologistPatient(String uuid) async {
    try {
      isLoading(true);
      final response =
          await PatientService().getDetailPsychologistPatient(uuid);
      detailPsychologist.value = response;
    } catch (e) {
      print(e);
      showToast('An error occurred while fetching data',
          backgroundColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  Future<String> createChannel(String patientId, String psychologistId) async {
    final url = Uri.parse(
        'https://consulife-frontend-website.vercel.app/api/create-channel');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'patient_id': patientId,
        'psychologist_id': psychologistId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['channel_id'];
    } else {
      throw Exception('Failed to create channel: ${response.body}');
    }
  }

  void toggleCalendar() {
    isCalendarVisible.value = !isCalendarVisible.value;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    focusedDay.value = date;
    isCalendarVisible.value = false;
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  void showToast(String message, {Color backgroundColor = Colors.green}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void bookAppointment(BuildContext context) async {
    if (selectedDate.value != null && selectedTime2.isNotEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Appointment Confirmation',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to make an appointment for this schedule?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final psychologistId = detailPsychologist.value.id;

                    // Format date and time
                    final dateStr =
                        DateFormat('yyyy-MM-dd').format(selectedDate.value!);
                    final startTime = selectedTime2[0]["start"]!;
                    final endTime = selectedTime2[0]["end"]!;

                    final formData = {
                      "date": dateStr,
                      "start_time": startTime,
                      "end_time": endTime,
                    };

                    try {
                      // Create channel
                      final patientId =
                          StorageService.getToken("user_id").toString();
                      final channelId =
                          await createChannel(patientId, psychologistId);

                      // Add channel_id to form data
                      formData["channel_id"] = channelId;

                      // Send appointment data
                      final response = await PatientService()
                          .addAppointment(psychologistId, formData);

                      // Check if the appointment was successfully added
                      if (response['status'] == 'success') {
                        Fluttertoast.showToast(
                          msg: "Successfully scheduled",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: successColor,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                        Get.offAllNamed(Routes.LANDING_PASIEN);
                      } else {
                        Fluttertoast.showToast(
                          msg: response['message'] ??
                              'Failed to add appointment',
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg:
                            'An error occurred while scheduling the appointment',
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }

                    Get.back(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: successColor,
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Yes, Book',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: warningColor,
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Please select a date and time',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
