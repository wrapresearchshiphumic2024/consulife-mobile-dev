import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/analyzer_history_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class AnalyzerHistoryPasienView
    extends GetView<AnalyzerHistoryPasienController> {
  const AnalyzerHistoryPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBack(),
        title: const Text(
          'AI Analyzer History',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const LoadingCustom()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomRefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchAnalyzerHistory();
                  },
                  child: ListView.builder(
                    itemCount: controller.analyzerHistory.length,
                    itemBuilder: (context, index) {
                      var analyzeResult = controller.analyzerHistory[index];
                      return _buildAnalyzeResultSection(
                        appointmentDate: analyzeResult.createdAt,
                        description: analyzeResult.complaint,
                        stressProbability: analyzeResult.stress,
                        anxietyProbability: analyzeResult.anxiety,
                        depressionProbability: analyzeResult.depression,
                      );
                    },
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildAnalyzeResultSection({
    required String appointmentDate,
    required String description,
    required double stressProbability,
    required double anxietyProbability,
    required double depressionProbability,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16.0),
          color: carddetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDate(appointmentDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: textColor),
                ),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Probability of Stress: $stressProbability%",
                          style: const TextStyle(color: textColor),
                        ),
                        Text(
                          "Probability of Anxiety: $anxietyProbability%",
                          style: const TextStyle(color: textColor),
                        ),
                        Text(
                          "Probability of Depression:  $depressionProbability%",
                          style: const TextStyle(color: textColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
