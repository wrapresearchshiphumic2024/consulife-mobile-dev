import 'package:get/get.dart';

class HomePsychologController extends GetxController {
  //TODO: Implement HomePsychologController

  final count = 0.obs;
  final List<Map<String, dynamic>> upcomingAppointment = [
    {"status": "Ongoing", "name": "John Rodrigo", "time": "12 Oct 2024, 10:00"},
    {"status": "Waiting", "name": "Jane Doe", "time": "13 Oct 2024, 14:00"},
    {"status": "Waiting", "name": "Sarah Smith", "time": "14 Oct 2024, 15:00"},
  ];
  final List<Map<String, dynamic>> historyAppointment = [
    {
      "status": "Canceled",
      "name": "John Rodrigo",
      "time": "12 Oct 2024, 10:00"
    },
    {"status": "Completed", "name": "Jane Doe", "time": "13 Oct 2024, 14:00"},
    {"status": "Canceled", "name": "Sarah Smith", "time": "14 Oct 2024, 15:00"},
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
