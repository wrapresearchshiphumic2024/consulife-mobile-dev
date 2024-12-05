import 'package:get/get.dart';

import '../controllers/psikolog_pro_det_controller.dart';

class PsikologProDetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsikologProDetController>(
      () => PsikologProDetController(),
    );
  }
}
