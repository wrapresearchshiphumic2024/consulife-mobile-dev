import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  var isEmailSent = false.obs;

  void submitEmail() {

    isEmailSent.value = true;


    Future.delayed(const Duration(seconds: 2), () {
      isEmailSent.value = false;
    });
  }
}
