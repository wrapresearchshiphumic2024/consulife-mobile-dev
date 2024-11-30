import 'package:get/get.dart';

import '../controllers/psikolog_cha_pass_controller.dart';

class PsikologChaPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsikologChaPassController>(
      () => PsikologChaPassController(),
    );
  }
}
