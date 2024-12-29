import 'package:consulin_mobile_dev/app/models/patient/info-patient.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:get/get.dart';

class HistoryPasienController extends GetxController {
  var appointmentData = AppointmentPatient(
    upcomingAppointments: [],
    history: [],
  ).obs;
  final isLoading = false.obs;
  // Method to fetch appointment data
  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true; // Set loading to true
      AppointmentPatient data = await PatientService().getAppointmentPatient();
      // Fetch appointment data
      appointmentData.value.history = data.history;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching appointment data: $e');
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }
}
