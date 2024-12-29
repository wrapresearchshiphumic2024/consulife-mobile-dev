import 'package:consulin_mobile_dev/app/models/patient/info-patient.dart';
import 'package:consulin_mobile_dev/app/modules/profile_pasien/controllers/profile_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';

import 'package:get/get.dart';

class HomePasienController extends GetxController {
  // Observable for loading state
  final isLoading = false.obs;
  final ProfilePasienController profilePasienController =
      Get.find<ProfilePasienController>();

  // Observable for appointment data
  var appointmentData = AppointmentPatient(
    upcomingAppointments: [],
    history: [],
  ).obs;

  // Observable for statistics
  var probabilityOfStress = 65.0.obs;
  var probabilityOfAnxiety = 40.0.obs;
  var probabilityOfDepression = 70.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchAppointments();
  }

  // Method to fetch appointment data
  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true; // Set loading to true
      // Fetch appointment data
      appointmentData.value = await PatientService().getAppointmentPatient();

      // Limit the data to only the first 5 upcoming and history appointments
      appointmentData.value.upcomingAppointments =
          appointmentData.value.upcomingAppointments.take(5).toList();
      appointmentData.value.history =
          appointmentData.value.history.take(5).toList();

      await fetchProbabilitiesFromAPI(); // Fetch probabilities when initializing
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching appointment data: $e');
    } finally {
      isLoading.value = false; // Set loading to false
    }
  }

  // Method to fetch probabilities
  Future<void> fetchProbabilitiesFromAPI() async {
    try {
      // Simulate an API call to fetch probabilities
      await Future.delayed(const Duration(seconds: 1));
      // Update probabilities with new values (replace with actual API call)
      updateProbabilities(70.0, 45.0, 60.0);
    } catch (e) {
      print('Error fetching probabilities: $e');
    }
  }

  // Method to update probabilities
  void updateProbabilities(double stress, double anxiety, double depression) {
    probabilityOfStress.value = stress;
    probabilityOfAnxiety.value = anxiety;
    probabilityOfDepression.value = depression;
  }

  // Method to get pie chart data
  Map<String, double> getPieChartData() {
    return {
      "Probability of Stress": probabilityOfStress.value,
      "Probability of Anxiety": probabilityOfAnxiety.value,
      "Probability of Depression": probabilityOfDepression.value,
    };
  }
}
