import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/psychologst/PsychologstService.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpcomingAppointmentController extends GetxController {
  // Observable for consultation data
  var consultationDataPsychologst = ConsultationDataPsychologist(
    consultations: [],
    totalWeeklyConsultation: 0,
    totalConsultation: 0,
    todayOngoingConsultation: 0,
  ).obs;
  final isLoading = false.obs;
  // Method to fetch consultation data
  Future<void> getConsultationDataPsychologist() async {
    try {
      isLoading.value = true;
      // Fetch consultation data
      ConsultationDataPsychologist data =
          await PsychologstService().getConsultationDataPsychologist();

      // Update the observable with the fetched data
      consultationDataPsychologst.value = data;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching consultation data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getConsultationDataPsychologist();
  }
}
