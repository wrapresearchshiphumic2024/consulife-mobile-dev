import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/utils/api/patient/PatientService.dart';
import 'package:get/get.dart';

class AnalyzerHistoryPasienController extends GetxController {
  var analyzerHistory = <AiAnalyzer>[].obs; // Observable list of AiAnalyzer
  var isLoading = true.obs; // Track loading state
  var errorMessage = ''.obs; // Store error message, if any

  @override
  void onInit() {
    super.onInit();
    fetchAnalyzerHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // Cleanup if needed
  }

  // Method to fetch AI analysis history
  Future<void> fetchAnalyzerHistory() async {
    isLoading.value = true; // Set loading to true

    try {
      // Send GET request to your API
      final history = await PatientService().getHistoryAiAnalyzer();
      print("coba");

      // Check if history is null, then use an empty list if so
      analyzerHistory.value = history ?? [];
    } catch (error) {
      print(error);
      errorMessage.value = 'Failed to load history';
    } finally {
      isLoading.value = false; // Set loading to false once done
    }
  }
}
