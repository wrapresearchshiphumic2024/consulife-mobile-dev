import 'package:get/get.dart';

import '../controllers/detail_cancel_controller.dart';

class DetailCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCancelController>(
      () => DetailCancelController(),
    );
  }
}
