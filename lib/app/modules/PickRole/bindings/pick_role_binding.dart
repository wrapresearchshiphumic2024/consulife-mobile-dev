import 'package:get/get.dart';

import '../controllers/pick_role_controller.dart';

class PickRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickRoleController>(
      () => PickRoleController(),
    );
  }
}
