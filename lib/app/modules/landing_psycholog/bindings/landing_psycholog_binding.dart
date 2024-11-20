import 'package:get/get.dart';

import '../controllers/landing_psycholog_controller.dart';

class LandingPsychologBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPsychologController>(
      () => LandingPsychologController(),
    );
  }
}
