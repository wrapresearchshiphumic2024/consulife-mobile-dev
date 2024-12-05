import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class DetailOngoingController extends GetxController {

  var selectedTabIndex = 0.obs;

  final String patientName = "John Doe";
  final String patientGender = "Male";
  final String patientEmail = "johndoe@example.com";
  final String patientPhone = "+1234567890";
  final DateTime appointmentDate = DateTime.now().add(Duration(hours: 2));
  final String aiAnalysisResult = "AI has detected high stress levels.";
  final double stressProbability = 85.0;
  final double anxietyProbability = 70.0;
  final double depressionProbability = 50.0;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Consultation Completed",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: successColor,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                );
                Future.delayed(Duration(seconds: 1), () {
                  Get.back();
                  Get.offAllNamed('');
                });
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

  void cancel(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
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
        content: Column(
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
            TextField(
              controller: reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Reason',
                hintText: '',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Consultation Cancelled",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: warningColor,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                );
                Future.delayed(Duration(seconds: 1), () {
                  Get.back();
                  Get.offAllNamed('');
                });
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
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }


}
