import 'package:get/get.dart';

import '../controllers/upcoming_appointmet_pasien_controller.dart';

class UpcomingAppointmetPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingAppointmetPasienController>(
      () => UpcomingAppointmetPasienController(),
    );
  }
}
