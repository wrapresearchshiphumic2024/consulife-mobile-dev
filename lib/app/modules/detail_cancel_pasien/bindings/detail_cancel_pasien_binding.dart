import 'package:get/get.dart';

import '../controllers/detail_cancel_pasien_controller.dart';

class DetailCancelPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCancelPasienController>(
      () => DetailCancelPasienController(),
    );
  }
}
