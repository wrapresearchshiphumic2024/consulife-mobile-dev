import 'package:get/get.dart';

import '../controllers/detail_completed_controller.dart';

class DetailCompletedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCompletedController>(
      () => DetailCompletedController(),
    );
  }
}
