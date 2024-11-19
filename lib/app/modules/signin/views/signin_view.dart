import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SigninView'),
        centerTitle: true,
      ),
      body: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.SIGNUP_PSYCHOLOGST);
        },
        child: const Text("Sign Up Now"),
      ),
    );
  }
}
