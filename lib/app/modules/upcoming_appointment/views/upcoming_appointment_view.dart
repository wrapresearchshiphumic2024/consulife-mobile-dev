import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';

import '../controllers/upcoming_appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class UpcomingAppointmentView extends GetView<UpcomingAppointmentController> {
  const UpcomingAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBack(),
        title: const Text(
          'Upcoming Appointments',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        var upcomingAppointments =
            controller.consultationDataPsychologst.value.consultations;
        if (controller.isLoading.value) {
          return const LoadingCustom();
        }

        return CustomRefreshIndicator(
          onRefresh: () async {
            await controller.getConsultationDataPsychologist();
          },
          child: upcomingAppointments.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: upcomingAppointments.length,
                  itemBuilder: (context, index) {
                    var consultation = upcomingAppointments[index];
                    final statusColor = _getStatusColor(consultation.status);

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_COMPLETED,
                            arguments: consultation.id.toString());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  consultation.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${consultation.user.firstname} ${consultation.user.lastname}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "Time: ${formatDate(consultation.date)}, ${consultation.startTime}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10), // Separator between items
                )
              : const Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
                  ),
                ),
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ongoing Consultation':
        return successColor;
      case 'Waiting Consultation':
        return primaryColor;
      case 'Canceled Consultation':
        return warningColor;
      default:
        return Colors.grey;
    }
  }
}
