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
        leading: ButtonBack(),
        title: const Text(
          'Upcoming Appointments',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        var upcomingAppointments = controller.upcomingAppointments;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            if (upcomingAppointments.isNotEmpty)
              _buildSection('', upcomingAppointments),
          ],
        );
      }),
    );
  }

  Widget _buildSection(String title, List<Consultation> consultations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            var consultation = consultations[index];
            final statusColor = _getStatusColor(consultation.status);

            return GestureDetector(
              onTap: () {
                if (consultation.status == 'Ongoing Consultation') {
                  Get.toNamed(Routes.DETAIL_ONGOING, arguments: consultation);
                } else if (consultation.status == 'Waiting Consultation') {
                  Get.toNamed(Routes.DETAIL_WAITING, arguments: consultation);
                } else {
                  Get.snackbar("Card Tapped", "Konsultasi: ${consultation.name}");
                }
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                            "Name: ${consultation.name}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Time: ${consultation.formattedDateWithTime}",
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
        ),
      ],
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
