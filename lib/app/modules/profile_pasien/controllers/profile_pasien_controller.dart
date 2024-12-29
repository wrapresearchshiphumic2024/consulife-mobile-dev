import 'package:consulin_mobile_dev/app/models/user.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:consulin_mobile_dev/app/utils/storage_service.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class ProfilePasienController extends GetxController {
  final profile = User(id: '', firstname: '', lastname: '').obs;
  final isLoading = false.obs;
  // Method to fetch the psychologist's profile
  Future<void> fetchPsychologistProfile() async {
    try {
      isLoading.value = true;
      User fetchedProfile = await PatientService().getPatientProfile();
      profile.value = fetchedProfile;
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPsychologistProfile();
  }

  void cancel(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Confirm Sign Out?',
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
              'Are you sure you want to exit this account? Once signed out, you will need to log in again to access your account.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                StorageService.clearToken("auth_token");
                StorageService.clearToken("role");
                Get.offAllNamed(Routes.SIGNIN);
                Fluttertoast.showToast(
                  msg: "Logged out successfully",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Yes, Logout',
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
                side: const BorderSide(color: primaryColor),
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
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
