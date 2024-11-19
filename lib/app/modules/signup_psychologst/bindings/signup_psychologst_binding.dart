import 'package:get/get.dart';

import '../controllers/signup_psychologst_controller.dart';

class SignupPsychologstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupPsychologstController>(
      () => SignupPsychologstController(),
    );
  }
}
