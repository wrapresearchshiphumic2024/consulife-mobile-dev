import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/api/auth/AuthService.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool showPassword = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      LoadingDialog.show(Get.context!);

      try {
        isLoading.value = true;
        final role =
            await signInService(emailController.text, passwordController.text);
        LoadingDialog.hide(Get.context!);

        role == "patient"
            ? Get.offAndToNamed(Routes.LANDING_PASIEN)
            : Get.offAndToNamed(Routes.LANDING_PSYCHOLOG);

        ToastHelper.show(
          message: "Signin Successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (e) {
        LoadingDialog.hide(Get.context!);
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          gravity: ToastGravity.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<String> signInService(String email, String password) async {
    try {
      final role = await AuthService().login(
        emailController.text,
        passwordController.text,
      );

      return role;
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
