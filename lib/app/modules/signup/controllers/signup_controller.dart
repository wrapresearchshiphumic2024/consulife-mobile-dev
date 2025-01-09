import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/api/auth/AuthService.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';

import 'package:consulin_mobile_dev/widgets/signup/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/second_step.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Key untuk form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Input controllers
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // Observable state variables
  var selectedGender = 'Male'.obs;
  final step = 0.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;
  var selectedSpecializations = <String>[].obs; // Untuk multi-select dropdown

  // Step widgets
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

  // Navigasi ke step berikutnya
  void goToNextStep() async {
    if (validateStep()) {
      if (step.value < steps.length - 1) {
        step.value++;
      } else {
        // Proses registrasi di langkah terakhir
        await registerUser();
      }
    }
  }

  // Fungsi untuk toggle visibilitas password
  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  // Toggle visibilitas confirm password
  void changeShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  // Fungsi untuk melakukan registrasi
  Future<void> registerUser() async {
    try {
      // Kumpulkan data dari form
      final formData = {
        'firstname': firstname.text,
        'lastname': lastname.text,
        'email': email.text,
        'password': password.text,
        'confirm_password': confirmPassword.text,
        'phone_number': phoneNumber.text,
        'gender': selectedGender.value,
        'specializations': selectedSpecializations,
      };

      // Panggil fungsi register dari AuthService
      final response = await AuthService().register(formData);

      if (response['success'] != null) {
        ToastHelper.show(
          message: "Account Created Successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.BOTTOM,
        );
        Get.offAllNamed(Routes.SIGNIN); // Kembali ke halaman sebelumnya
      } else if (response['errors'] != null) {
        ToastHelper.show(
          message: response['errors'].toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      ToastHelper.show(
        message: "Registration failed: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
