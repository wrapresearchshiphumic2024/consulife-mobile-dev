import 'package:consulin_mobile_dev/widgets/ui/appointment_card.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../controllers/home_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';

class HomePasienView extends GetView<HomePasienController> {
  const HomePasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const LoadingCustom()
              : CustomRefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchAppointments();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, ${controller.profilePasienController.profile.value.firstname} ${controller.profilePasienController.profile.value.lastname}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        "Welcome to ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "Consulife",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.NOTIFICATION_PASIEN);
                                  },
                                  icon:
                                      const Icon(Icons.notifications_outlined)),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Analysis Results",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 16),
                          ),
                          Card(
                            color: carddetail,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Obx(
                                          () => PieChart(
                                            dataMap: {
                                              "Probability of Stress":
                                                  controller.probabilityOfStress
                                                      .value,
                                              "Probability of Anxiety":
                                                  controller
                                                      .probabilityOfAnxiety
                                                      .value,
                                              'Probability of Depression':
                                                  controller
                                                      .probabilityOfDepression
                                                      .value,
                                            },
                                            animationDuration: const Duration(
                                                milliseconds: 800),
                                            chartLegendSpacing: 32.0,
                                            chartRadius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            colorList: const [
                                              Color(0xfffd9b08),
                                              Color(0xff47af65),
                                              Color(0xffed3c76),
                                            ],
                                            initialAngleInDegree: 0,
                                            chartType: ChartType.disc,
                                            ringStrokeWidth: 32,
                                            legendOptions: const LegendOptions(
                                              showLegendsInRow: false,
                                              legendPosition:
                                                  LegendPosition.bottom,
                                              showLegends: true,
                                            ),
                                            chartValuesOptions:
                                                const ChartValuesOptions(
                                              showChartValueBackground: false,
                                              showChartValues: true,
                                              showChartValuesInPercentage: true,
                                              chartValueStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  // ElevatedButton di bagian kanan bawah
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            Routes.ANALYZER_HISTORY_PASIEN);
                                      },
                                      child: const Text(
                                        'Analyzer History',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Upcoming Appointments",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(
                                        Routes.UPCOMING_APPOINTMET_PASIEN);
                                  },
                                  child: const Text(
                                    "See More",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ],
                          ),
                          controller.appointmentData.value.upcomingAppointments
                                  .isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No upcoming appointments',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 100,
                                  child: ListView.separated(
                                    itemCount: controller.appointmentData.value
                                        .upcomingAppointments.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return AppointmentCard(
                                        isPatient: true,
                                        isVertical: false,
                                        id: controller.appointmentData.value
                                            .upcomingAppointments[index].id
                                            .toString(),
                                        status: controller.appointmentData.value
                                            .upcomingAppointments[index].status,
                                        name:
                                            '${controller.appointmentData.value.upcomingAppointments[index].user.firstname.capitalize} ${controller.appointmentData.value.upcomingAppointments[index].user.lastname.capitalize}',
                                        time:
                                            "${formatDate(controller.appointmentData.value.upcomingAppointments[index].date)}, ${controller.appointmentData.value.upcomingAppointments[index].startTime}",
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                  ),
                                ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Upcoming History",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.HISTORY_PASIEN);
                                  },
                                  child: const Text(
                                    "See More",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ],
                          ),
                          controller.appointmentData.value.history.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No upcoming history',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: controller
                                      .appointmentData.value.history.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return AppointmentCard(
                                      isPatient: true,
                                      isVertical: true,
                                      id: controller.appointmentData.value
                                          .history[index].id
                                          .toString(),
                                      status: controller.appointmentData.value
                                          .history[index].status,
                                      name:
                                          '${controller.appointmentData.value.history[index].user.firstname.capitalize} ${controller.appointmentData.value.history[index].user.lastname.capitalize}',
                                      time:
                                          "${formatDate(controller.appointmentData.value.history[index].date)}, ${controller.appointmentData.value.history[index].startTime}",
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
