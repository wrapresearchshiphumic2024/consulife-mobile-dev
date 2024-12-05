import 'package:get/get.dart';

import '../controllers/history_pasien_controller.dart';

class HistoryPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPasienController>(
      () => HistoryPasienController(),
    );
  }
}
