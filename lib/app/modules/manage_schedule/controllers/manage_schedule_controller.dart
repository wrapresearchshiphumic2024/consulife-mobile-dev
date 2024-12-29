import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ManageScheduleController extends GetxController {
  // Observable to track if the appointment is open
  final isOpenAppointment = false.obs;
  final isLoading = false.obs;

  // Observable list for selected days
  final selectedDays = <String>[].obs;

  // Observable list for schedule open (day and times)
  final scheduleOpen =
      <Map<String, dynamic>>[].obs; // Change to accommodate dynamic types

  // Observable list for selected times
  final selectedTime = <Map<String, String>>[].obs;

  // Method to update selected days
  void onSelectedDay(List<String> value) {
    selectedDays.value = value;
  }

  // Method to update appointment status
  void onChanged(bool value) async {
    if (isOpenAppointment.value) {
      isOpenAppointment.value = false;
      await PsychologstService().closeAppointment();
      ToastHelper.show(
        message: "Appointment Closed",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      isOpenAppointment.value = true;
      await PsychologstService().openAppointment();
      ToastHelper.show(
        message: "Appointment Opened",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // Method to update selected times
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
      scheduleOpen.value = schedule.days.map((day) {
        return {
          'day': capitalize(day.day),
          'times': day.times.map((time) {
            return {
              'start': time.start,
              'end': time.end,
            };
          }).toList(),
        };
      }).toList();

      isOpenAppointment.value = schedule.status == 'active';

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

  @override
  void onInit() async {
    super.onInit();
    await getSchedule();
  }
}
