import 'package:consulin_mobile_dev/app/models/user.dart';
import 'package:consulin_mobile_dev/app/modules/landing_pasien/controllers/landing_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PsychologController extends GetxController {
  // Observable properties
  final isLoading = false.obs;
  final psychologists = <User>[].obs;
  final patientHasAIAnalysis = false.obs;
  final name = TextEditingController();
  final gender = ''.obs;
  // Mengakses LandingPatientController
  final LandingPasienController landingPatientController =
      Get.find<LandingPasienController>();

  // Fungsi untuk mengambil data psikolog
  Future<void> fetchPsychologists({
    String name = "",
    String gender = "",
  }) async {
    try {
      isLoading(true); // Menandai proses sedang berjalan
      final response = await PatientService().getPsychologistData(
        name: name,
        gender: gender,
      );

      // Memperbarui nilai observable
      patientHasAIAnalysis.value = response.patientHasAIAnalysis;
      psychologists.value = response.psychologists;
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to fetch psychologists: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false); // Menandai proses selesai
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPsychologists(name: name.text, gender: gender.value);
  }
}
