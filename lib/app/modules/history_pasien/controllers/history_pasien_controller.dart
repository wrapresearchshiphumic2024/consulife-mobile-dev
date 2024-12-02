import 'package:get/get.dart';
import 'package:get/get.dart';

class HistoryPasienController extends GetxController {
  final appointmentHistory = [
    {
      "status": "Canceled Consultation",
      "name": "Michael Brown",
      "time": "14 Nov 2024, 10:00",
      "color": "warningColor",
    },
    {
      "status": "Completed Consultation",
      "name": "Sarah Davis",
      "time": "18 Nov 2024, 15:00",
      "color": "primaryColor",
    },
    {
      "status": "Canceled Consultation",
      "name": "William Garcia",
      "time": "18 Nov 2024, 10:00",
      "color": "warningColor",
    },
    {
      "status": "Canceled Consultation",
      "name": "David Lee",
      "time": "16 Nov 2024, 13:00",
      "color": "warningColor",
    },
    {
      "status": "Completed Consultation",
      "name": "Laura Martinez",
      "time": "22 Oct 2024, 14:00",
      "color": "primaryColor",
    },
  ].obs;

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
}

