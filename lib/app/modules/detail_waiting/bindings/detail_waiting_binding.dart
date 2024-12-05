import 'package:get/get.dart';

import '../controllers/detail_waiting_controller.dart';

class DetailWaitingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWaitingController>(
      () => DetailWaitingController(),
    );
  }
}
