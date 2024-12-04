import 'package:get/get.dart';

import '../controllers/notification_pasien_controller.dart';

class NotificationPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationPasienController>(
      () => NotificationPasienController(),
    );
  }
}
