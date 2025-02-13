import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';

import 'package:get/get.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class DetailCompletedPasienController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;
  var appointmentDetail =
      Rx<Appointment?>(null); // Observable for appointment details

  @override
  void onInit() {
    super.onInit();
    // Mengambil argumen dari GetX
    String? appointmentId = Get.arguments;

    print(appointmentId);
    if (appointmentId != null) {
      fetchAppointmentDetails(appointmentId);
    } else {
      print('No arguments passed');
    }
  }

  Future<void> fetchAppointmentDetails(String appointmentId) async {
    try {
      isLoading.value = true;
      // Mengambil detail janji temu menggunakan PatientService
      appointmentDetail.value =
          await PatientService().getAppointmentDetailPatient(
        appointmentId,
      );
      print("coba");
    } catch (e) {
      print('Error fetching appointment details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void joinMeet() {
    var jitsiMeet = JitsiMeet();
    var options = JitsiMeetConferenceOptions(
      room: appointmentDetail.value!.user.id,
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "security-options.enabled": false
      },
    );
    jitsiMeet.join(options);
  }
}
