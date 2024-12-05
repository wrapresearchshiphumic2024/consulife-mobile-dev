import 'package:get/get.dart';

import '../controllers/landing_pasien_controller.dart';

class LandingPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPasienController>(
      () => LandingPasienController(),
    );
  }
}
