import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class DetailAvailablePasienController extends GetxController {
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final RxString selectedTime = ''.obs;
  final RxBool isCalendarVisible = false.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;

  final RxList<String> availableTimes = [
    '10.00-11.00',
    '11.00-12.00',
    '13.00-14.00',
    '14.00-15.00',
    '15.00-16.00',
    '16.00-17.00',
  ].obs;

  bool get canBookAppointment =>
      selectedDate.value != null && selectedTime.isNotEmpty;

  void toggleCalendar() {
    isCalendarVisible.value = !isCalendarVisible.value;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    focusedDay.value = date;
    isCalendarVisible.value = false;
  }

  void selectTime(String time) {
    selectedTime.value = time;
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

  void BookAppointment(BuildContext context) {
    if (selectedDate.value != null && selectedTime.isNotEmpty) {
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
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(Routes.LANDING_PASIEN);
                    Fluttertoast.showToast(
                      msg: "Successfully scheduled",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: successColor,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: successColor,
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Yes, Book', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: warningColor,
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(color: Colors.white)),
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