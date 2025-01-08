import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';
import 'package:get/get.dart';

class PsikologHistoryController extends GetxController {
  // Observable for appointment history
  var appointmentHistory = <Appointment>[].obs;
  final isLoading = false.obs;
  // Method to fetch appointment history
  Future<void> getAppointmentHistory() async {
    try {
      isLoading.value = true;
      // Fetch appointment history
      List<Appointment> appointments =
          await PsychologstService().getAppointmentHistory();
      print(appointments);
      // Limit to the first 5 appointments
      appointmentHistory.value = appointments.toList();
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching appointment history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAppointmentHistory();
  }
}
