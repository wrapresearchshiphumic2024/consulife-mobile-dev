import 'package:get/get.dart';

class ManageScheduleController extends GetxController {
  //TODO: Implement ManageScheduleController

  final isOpenAppointment = false.obs;
  final selectedDays = <String>[].obs;
  final selectedTime = <Map<String, String>>[].obs;
  void onSelectedDay(List<String> value) {
    selectedDays.value = value;
  }

  void onChanged(bool value) {
    isOpenAppointment.value = value;
  }

  void onSelectedTime(List<Map<String, String>> value) {
    selectedTime.value = value;
  }
}
