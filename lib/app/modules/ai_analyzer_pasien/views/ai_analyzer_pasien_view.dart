import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import '../controllers/ai_analyzer_pasien_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class AiAnalyzerPasienView extends GetView<AiAnalyzerPasienController> {
  const AiAnalyzerPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Container(
                        width: 210,
                        height: 50,
                        decoration: BoxDecoration(
                          color: carddetail,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              alignment:
                                  controller.currentLanguage.value == 'English'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.changeLanguage('English'),
                                    child: Center(
                                      child: Text(
                                        'English',
                                        style: TextStyle(
                                          color: controller
                                                      .currentLanguage.value ==
                                                  'English'
                                              ? textColor
                                              : textColor.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.changeLanguage('Indonesian'),
                                    child: Center(
                                      child: Text(
                                        'Indonesian',
                                        style: TextStyle(
                                          color: controller
                                                      .currentLanguage.value ==
                                                  'Indonesian'
                                              ? textColor
                                              : textColor.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  color: carddetail,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              controller.translate('title'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: textColor,
                              ),
                            )),
                        const SizedBox(height: 16),
                        Obx(() => TextField(
                              controller: controller.textController,
                              maxLines: 20,
                              minLines: 15,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: controller.translate('hint_text'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                controller.validateInput();
                              },
                              scrollPadding: const EdgeInsets.all(16.0),
                              scrollPhysics: const BouncingScrollPhysics(),
                            )),
                        const SizedBox(height: 16),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: controller.isAnalyzeEnabled.value
                                      ? controller.analyze
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.isAnalyzeEnabled.value
                                            ? textColor
                                            : unactiv,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                  child: Text(
                                    controller.translate('analyze_button'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: controller.clearInput,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.isAnalyzeEnabled.value
                                            ? warningColor
                                            : unactivcancel,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                  child: Text(
                                    controller.translate('cancel_button'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 150),
                        Obx(
                          () => controller.isResultAvailable.value
                              ? Column(
                                  children: [
                                    PieChart(
                                      dataMap: controller.getChartData(),
                                      animationDuration:
                                          const Duration(milliseconds: 800),
                                      chartLegendSpacing: 40,
                                      chartRadius:
                                          MediaQuery.of(context).size.width /
                                              2.2,
                                      colorList: const [
                                        Colors.blue,
                                        Colors.red,
                                        Colors.orange,
                                      ],
                                      initialAngleInDegree: 0,
                                      chartType: ChartType.disc,
                                      legendOptions: const LegendOptions(
                                        showLegendsInRow: false,
                                        legendPosition: LegendPosition.bottom,
                                        showLegends: true,
                                        legendTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValueBackground:
                                            false, // Menghilangkan background putih
                                        showChartValues: true,
                                        showChartValuesInPercentage: true,
                                        showChartValuesOutside: false,
                                        chartValueStyle: TextStyle(
                                            color: Colors
                                                .black), // Opsional: mengatur warna teks
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    const Divider(), // Menambahkan garis horizontal

                                    Text(
                                      '${controller.translate('stress_probability')}: ${controller.stressProbability}%',
                                    ),
                                    Text(
                                      '${controller.translate('anxiety_probability')}: ${controller.anxietyProbability}%',
                                    ),
                                    Text(
                                      '${controller.translate('depression_probability')}: ${controller.depressionProbability}%',
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      'Last analyzed: ${controller.lastAnalyzed}',
                                    ),
                                  ],
                                )
                              : Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      controller
                                          .translate('result_placeholder'),
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomElevatedButton(
                      primaryColor: primaryColor,
                      onPressed: () {
                        Get.toNamed(Routes.ANALYZER_HISTORY_PASIEN);
                      },
                      buttonText: "Analyzer History",
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
