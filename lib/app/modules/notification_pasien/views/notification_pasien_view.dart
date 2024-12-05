import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class NotificationPasienView extends GetView<NotificationPasienController> {
  const NotificationPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(),
        title: const Text('Notifications',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color : textColor),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Obx(
            () {
          var todayConsultations = controller.todayConsultations;
          var yesterdayConsultations = controller.yesterdayConsultations;
          var pastWeekConsultations = controller.past30DaysConsultations
              .where((consultation) => _isThisWeek(consultation.dateTime))
              .toList();
          var pastMoreThan30DaysConsultations = controller.past30DaysConsultations
              .where((consultation) => !_isThisWeek(consultation.dateTime))
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              if (todayConsultations.isNotEmpty)
                _buildSection('Today', todayConsultations),
              if (yesterdayConsultations.isNotEmpty)
                _buildSection('Yesterday', yesterdayConsultations),
              if (pastWeekConsultations.isNotEmpty)
                _buildSection('This Week', pastWeekConsultations),
              if (pastMoreThan30DaysConsultations.isNotEmpty)
                _buildSection('More than 30 Days Ago', pastMoreThan30DaysConsultations),
            ],
          );
        },
      ),
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
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color : textColor),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: consultations.length,
          itemBuilder: (context, index) {
            var consultation = consultations[index];
            final statusColor = _getStatusColor(consultation.status);

            return GestureDetector(
              onTap: () {
                if (consultation.status == 'Ongoing Consultation') {
                  Get.toNamed(Routes.DETAIL_ONGOING_PASIEN, arguments: consultation);
                } else if (consultation.status == 'Waiting Consultation') {

                  Get.toNamed(Routes.DETAIL_WAITING_PASIEN, arguments: consultation);
                } else if (consultation.status == 'Canceled Consultation') {

                  Get.toNamed(Routes.DETAIL_CANCEL_PASIEN, arguments: consultation);
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
                          Row(
                            children: [
                              Text(
                                "Time: ${consultation.formattedDateWithTime}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
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
  bool _isThisWeek(DateTime dateTime) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 7));

    return dateTime.isAfter(startOfWeek) && dateTime.isBefore(endOfWeek);
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

