import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:consulin_mobile_dev/widgets/signup/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/second_step.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  var selectedGender = 'Male'.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final step = 0.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  // Observable list for multi-select dropdown
  var selectedSpecializations = <String>[].obs;

  // Form steps
  var steps = <Widget>[];

  @override
  void onInit() {
    super.onInit();
    steps = [
      FirstStep(controller: this),
      SecondStep(controller: this),
    ];
  }

  // Validasi untuk setiap step
  bool validateStep() {
    return formKey.currentState?.validate() ?? false;
  }

  void goToNextStep() {
    if (validateStep()) {
      if (step.value < steps.length - 1) {
        step.value++;
      } else {
        ToastHelper.show(
          message: "Account Created",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.BOTTOM,
        );

        // Navigasi kembali jika dibutuhkan
        // Get.back();
      }
    }
  }

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  // Toggle confirm password visibility
  void changeShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }
}
