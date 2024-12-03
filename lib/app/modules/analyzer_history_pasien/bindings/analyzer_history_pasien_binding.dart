import 'package:get/get.dart';

import '../controllers/analyzer_history_pasien_controller.dart';

class AnalyzerHistoryPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyzerHistoryPasienController>(
      () => AnalyzerHistoryPasienController(),
    );
  }
}
