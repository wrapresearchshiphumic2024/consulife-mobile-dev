import 'package:get/get.dart';

import '../controllers/detail_chat_patient_controller.dart';

class DetailChatPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailChatPatientController>(
      () => DetailChatPatientController(),
    );
  }
}
