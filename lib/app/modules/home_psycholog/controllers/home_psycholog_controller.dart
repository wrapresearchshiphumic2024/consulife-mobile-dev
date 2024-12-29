import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/modules/Profile/controllers/profile_pycholog_controller.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';
import 'package:get/get.dart';

class HomePsychologController extends GetxController {
  // Observable count for incrementing
  final isLoading = false.obs;
  final ProfilePychologController profilePychologController =
      Get.find<ProfilePychologController>();

  // Observable for consultation data
  var consultationDataPsychologst = ConsultationDataPsychologist(
    consultations: [],
    totalWeeklyConsultation: 0,
    totalConsultation: 0,
    todayOngoingConsultation: 0,
  ).obs;

  // Observable for appointment history
  var appointmentHistory = <Appointment>[].obs;

  // Sample upcoming appointments

  @override
  void onInit() async {
    super.onInit();
    await getConsultationDataPsychologist();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to fetch consultation data
  Future<void> getConsultationDataPsychologist() async {
    try {
      isLoading.value = true;
      // Fetch consultation data
      ConsultationDataPsychologist data =
          await PsychologstService().getConsultationDataPsychologist();

      // Update the observable with the fetched data
      consultationDataPsychologst.value = data;

      await getAppointmentHistory();
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching consultation data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to fetch appointment history
  Future<void> getAppointmentHistory() async {
    try {
      // Fetch appointment history
      List<Appointment> appointments =
          await PsychologstService().getAppointmentHistory();
      print(appointments);
      // Limit to the first 5 appointments
      appointmentHistory.value = appointments.take(5).toList();
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching appointment history: $e');
    }
  }
}
