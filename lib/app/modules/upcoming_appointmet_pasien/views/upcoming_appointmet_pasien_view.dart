import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/upcoming_appointmet_pasien_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class UpcomingAppointmetPasienView
    extends GetView<UpcomingAppointmetPasienController> {
  const UpcomingAppointmetPasienView({super.key});

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
            controller.appointmentData.value.upcomingAppointments;

        return controller.isLoading.value
            ? const LoadingCustom()
            : CustomRefreshIndicator(
                onRefresh: () async {
                  await controller.fetchAppointments();
                },
                child: upcomingAppointments.isEmpty
                    ? const Center(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "No Upcoming Appointments",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: upcomingAppointments.length,
                        itemBuilder: (context, index) {
                          return _buildAppointmentCard(
                              upcomingAppointments[index]);
                        },
                      ),
              );
      }),
    );
  }

  Widget _buildAppointmentCard(Appointment consultation) {
    final statusColor = _getStatusColor(consultation.status);
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_COMPLETED_PASIEN,
          arguments: consultation.id.toString()),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                '${consultation.status.capitalizeFirst!} Appointment',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${consultation.user.firstname.capitalizeFirst} ${consultation.user.lastname.capitalizeFirst}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Time: ${formatDate(consultation.date)}, ${consultation.startTime}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ongoind':
        return successColor;
      case 'waiting':
        return primaryColor;
      case 'canceled':
        return warningColor;
      default:
        return Colors.grey;
    }
  }
}
