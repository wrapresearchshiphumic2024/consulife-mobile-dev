import 'package:get/get.dart';

import '../controllers/profile_pycholog_controller.dart';

class ProfilePychologBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePychologController>(
      () => ProfilePychologController(),
    );
  }
}
