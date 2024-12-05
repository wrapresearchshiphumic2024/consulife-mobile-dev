import 'package:get/get.dart';

import '../controllers/detail_ongoing_controller.dart';

class DetailOngoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailOngoingController>(
      () => DetailOngoingController(),
    );
  }
}
