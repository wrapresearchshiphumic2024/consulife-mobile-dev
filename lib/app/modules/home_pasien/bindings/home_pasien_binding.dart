import 'package:get/get.dart';

import '../controllers/home_pasien_controller.dart';

class HomePasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePasienController>(
      () => HomePasienController(),
    );
  }
}
