import 'package:get/get.dart';

import '../controllers/complated_detail_pasien_controller.dart';

class ComplatedDetailPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplatedDetailPasienController>(
      () => ComplatedDetailPasienController(),
    );
  }
}
