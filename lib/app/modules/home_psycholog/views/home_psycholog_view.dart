import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/appointment_card.dart';
import 'package:consulin_mobile_dev/widgets/ui/column_chart.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

import '../controllers/home_psycholog_controller.dart';

class HomePsychologView extends GetView<HomePsychologController> {
  const HomePsychologView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const LoadingCustom()
              : CustomRefreshIndicator(
                  onRefresh: () async {
                    await controller.getConsultationDataPsychologist();
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
                                    "Hi,${" ${controller.profilePychologController.profile.value.firstname} ${controller.profilePychologController.profile.value.lastname}"}",
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
                                    Get.toNamed(Routes.NOTIFICATION);
                                  },
                                  icon: const Icon(Icons.notifications)),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Your Summary",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: StatsCard(
                                  title: "Total Consultation",
                                  value: controller.consultationDataPsychologst
                                      .value.totalConsultation
                                      .toString(),
                                  subTitle: "Consultation",
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: StatsCard(
                                  title: "Today Session",
                                  value: controller.consultationDataPsychologst
                                      .value.todayOngoingConsultation
                                      .toString(),
                                  subTitle: "Session",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Monthly Consultations",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 320, child: ColumnChart()),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Upcoming Appointment",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.UPCOMING_APPOINTMENT);
                                  },
                                  child: const Text(
                                    "See More",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: controller.consultationDataPsychologst.value
                                    .consultations.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No upcoming appointments',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: controller
                                        .consultationDataPsychologst
                                        .value
                                        .consultations
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return AppointmentCard(
                                        isPatient: false,
                                        isVertical: false,
                                        id: controller
                                            .consultationDataPsychologst
                                            .value
                                            .consultations[index]
                                            .id
                                            .toString(),
                                        status: controller
                                            .consultationDataPsychologst
                                            .value
                                            .consultations[index]
                                            .status,
                                        name:
                                            "${controller.consultationDataPsychologst.value.consultations[index].user.firstname} ${controller.consultationDataPsychologst.value.consultations[index].user.lastname}",
                                        time:
                                            "${formatDate(controller.consultationDataPsychologst.value.consultations[index].date)}, ${controller.consultationDataPsychologst.value.consultations[index].startTime}",
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
                                "Appointment History",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.PSIKOLOG_HISTORY);
                                  },
                                  child: const Text(
                                    "See More",
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          controller.appointmentHistory.isEmpty
                              ? const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'No appointment history',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount:
                                      controller.appointmentHistory.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return AppointmentCard(
                                      isPatient: false,
                                      isVertical: true,
                                      id: controller
                                          .appointmentHistory[index].id
                                          .toString(),
                                      status: controller
                                          .appointmentHistory[index].status,
                                      name:
                                          "${controller.appointmentHistory[index].user.firstname} ${controller.appointmentHistory[index].user.lastname}",
                                      time:
                                          "${formatDate(controller.appointmentHistory[index].date)}, ${controller.appointmentHistory[index].startTime}",
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                ),
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
