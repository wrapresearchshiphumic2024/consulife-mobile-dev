import 'package:get/get.dart';

import '../controllers/upcoming_appointment_controller.dart';

class UpcomingAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingAppointmentController>(
      () => UpcomingAppointmentController(),
    );
  }
}
