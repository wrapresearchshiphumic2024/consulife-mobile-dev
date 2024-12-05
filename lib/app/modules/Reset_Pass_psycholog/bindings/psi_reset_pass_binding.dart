import 'package:get/get.dart';

import '../controllers/psi_reset_pass_controller.dart';

class PsiResetPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PsiResetPassController>(
      () => PsiResetPassController(),
    );
  }
}
