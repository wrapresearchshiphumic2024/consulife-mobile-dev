import 'package:get/get.dart';

import '../controllers/ai_analyzer_pasien_controller.dart';

class AiAnalyzerPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiAnalyzerPasienController>(
      () => AiAnalyzerPasienController(),
    );
  }
}
