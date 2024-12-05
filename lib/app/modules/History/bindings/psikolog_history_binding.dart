import 'package:get/get.dart';

import '../controllers/psikolog_history_controller.dart';

class PsikologHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsikologHistoryController>(
      () => PsikologHistoryController(),
    );
  }
}
