import 'package:get/get.dart';

import '../controllers/detail_ongoing_pasien_controller.dart';

class DetailOngoingPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOngoingPasienController>(
      () => DetailOngoingPasienController(),
    );
  }
}
