import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/modules/psycholog/controllers/psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiAnalyzerPasienController extends GetxController {
  // Variabel untuk TextController dan status tombol
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final isLoading = false.obs;

// Data hasil analisis
  final stressProbability = 0.0.obs;
  final anxietyProbability = 0.0.obs;
  final depressionProbability = 0.0.obs;

  // Fungsi untuk mengambil riwayat analisis
  final aiHistory = <AiAnalyzer>[].obs;
  // Mengakses LandingPatientController
  final PsychologController psychologController =
      Get.find<PsychologController>();

  // Fungsi untuk mengambil analisis terbaru
  Future<void> fetchLatestAiAnalyzer() async {
    try {
      isLoading.value = true;
      final latest = await PatientService().getLatestHistoryAiAnalyzer();
      if (latest != null) {
        stressProbability.value = latest.stress;
        anxietyProbability.value = latest.anxiety;
        depressionProbability.value = latest.depression;
        textController.text = latest.complaint;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch the latest AI analysis');
    } finally {
      isLoading.value = false;
    }
  }

  void analyze() async {
    if (formKey.currentState!.validate()) {
      // Ambil data dari form atau TextController untuk analisis
      LoadingDialog.show(Get.context!);
      isLoading.value = true;
      Map<String, String> data = {
        'text': textController.text,
      };

      try {
        // Panggil fungsi aiAnalyzer dari PatientService
        await PatientService().aiAnalyzer(data);

        // Update hasil analisis jika sukses
        await fetchLatestAiAnalyzer();
        if (!psychologController.patientHasAIAnalysis.value) {
          await psychologController.fetchPsychologists();
        }

        ToastHelper.show(
          message: "AI analysis successful",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        ToastHelper.show(
          message: e.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } finally {
        LoadingDialog.hide(Get.context!);
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchLatestAiAnalyzer(); // Fetch riwayat saat controller diinisialisasi
  }
}
