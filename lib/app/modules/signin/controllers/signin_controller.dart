import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool showPassword = false.obs;

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void signIn() {
    if (formKey.currentState!.validate()) {
      ToastHelper.show(
        message: "Signin Successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
      );
      Get.offAllNamed(Routes.LANDING_PSYCHOLOG);
    }
  }
}
