import 'package:get/get.dart';

import '../controllers/detail_available_pasien_controller.dart';

class DetailAvailablePasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAvailablePasienController>(
      () => DetailAvailablePasienController(),
    );
  }
}
