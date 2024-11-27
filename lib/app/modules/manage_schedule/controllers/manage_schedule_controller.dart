import 'package:get/get.dart';

class ManageScheduleController extends GetxController {
  //TODO: Implement ManageScheduleController

  final isOpenAppointment = false.obs;
  void onChanged(bool value) {
    isOpenAppointment.value = value;
  }
}
