import 'package:get/get.dart';

import '../controllers/psikolog_per_info_controller.dart';

class PsikologPerInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsikologPerInfoController>(
      () => PsikologPerInfoController(),
    );
  }
}
