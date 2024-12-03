import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/analyzer_history_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class AnalyzerHistoryPasienView extends GetView<AnalyzerHistoryPasienController> {
  const AnalyzerHistoryPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('AI Analyzer History',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnalyzeResultSection(
                title: 'Latest Analyze Result',
                appointmentDate: controller.latestAnalyzerResultDate,
                description: controller.latestAnalyzerResult,
                stressProbability: controller.stressProbability,
                anxietyProbability: controller.anxietyProbability,
                depressionProbability: controller.depressionProbability,
              ),
              const SizedBox(height: 16),
              _buildAnalyzeResultSection(
                title: 'Earlier Scan Result',
                appointmentDate: controller.earlierScanResultDate,
                description: controller.earlierScanResult,
                stressProbability: controller.stressProbability,
                anxietyProbability: controller.anxietyProbability,
                depressionProbability: controller.depressionProbability,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyzeResultSection({
    required String title,
    required DateTime appointmentDate,
    required String description,
    required double stressProbability,
    required double anxietyProbability,
    required double depressionProbability,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
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
                  "${appointmentDate.toLocal().toString().substring(0, 10)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Probability of Stress: ${stressProbability}%",
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          "Probability of Anxiety: ${anxietyProbability}%",
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          "Probability of Depression:  ${depressionProbability}%",
                          style: TextStyle(color: textColor),
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
