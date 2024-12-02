import 'package:get/get.dart';

import '../controllers/psycholog_controller.dart';

class PsychologBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsychologController>(
      () => PsychologController(),
    );
  }
}
