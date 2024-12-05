import 'package:get/get.dart';

import '../controllers/detail_waiting_pasien_controller.dart';

class DetailWaitingPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWaitingPasienController>(
      () => DetailWaitingPasienController(),
    );
  }
}
