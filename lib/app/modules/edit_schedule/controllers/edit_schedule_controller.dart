import 'package:consulin_mobile_dev/app/modules/manage_schedule/controllers/manage_schedule_controller.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';

class EditScheduleController extends GetxController {
  final selectedDays = <String>[].obs;
  final selectedTime = <Map<String, String>>[].obs;
  final isLoading = false.obs;
  final isLoadingButton = false.obs;
  final ManageScheduleController manageScheduleController =
      Get.find<ManageScheduleController>();

  void onSelectedDay(List<String> value) {
    selectedDays.value = value;
    print(selectedDays);
  }

  void onSelectedTime(List<Map<String, String>> value) {
    selectedTime.value = value;
  }

  // Method to fetch the schedule
  Future<void> getSchedule() async {
    try {
      isLoading.value = true;
      Schedule schedule = await PsychologstService().getSchedule();

      selectedDays.value =
          schedule.days.map((day) => capitalize(day.day)).toList();
      selectedTime.value = schedule.days.expand((day) {
        return day.times.map((time) => {
              'start': time.start,
              'end': time.end,
            });
      }).toList();

      isLoading.value = false;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Method to capitalize the first letter of a string
  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // Method to update the schedule
  Future<void> updateSchedule() async {
    final data = {
      'days': selectedDays,
      'times': selectedTime,
    };

    try {
      isLoadingButton.value = true; // Set loading state
      final result = await PsychologstService().editSchedule(data);
      print(result);
      manageScheduleController.getSchedule();
      ToastHelper.show(
        message: "Signin Successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
      ); // Handle success response
      Get.back(); // Navigate back
    } catch (e) {
      print("Error updating schedule: $e"); // Handle error
    } finally {
      isLoadingButton.value = false; // Reset loading state
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getSchedule();
  }
}
