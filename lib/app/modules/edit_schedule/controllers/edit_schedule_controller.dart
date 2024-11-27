import 'package:get/get.dart';

class EditScheduleController extends GetxController {
  //TODO: Implement EditScheduleController

  final selectedDays = <String>[].obs;
  final selectedTime = <Map<String, String>>[].obs;
  void onSelectedDay(List<String> value) {
    selectedDays.value = value;
  }

  void onSelectedTime(List<Map<String, String>> value) {
    selectedTime.value = value;
  }
}
