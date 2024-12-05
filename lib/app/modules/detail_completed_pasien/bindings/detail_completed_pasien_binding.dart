import 'package:get/get.dart';

import '../controllers/detail_completed_pasien_controller.dart';

class DetailCompletedPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCompletedPasienController>(
      () => DetailCompletedPasienController(),
    );
  }
}
