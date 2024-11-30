import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PsiResetPassController extends GetxController {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final isPasswordReset = false.obs;
  @override
  void onInit() {
    super.onInit();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void resetPassword() {
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isPasswordReset.value = true;

    Future.delayed(const Duration(seconds: 3), () {
      isPasswordReset.value = false;
    });
  }
}
