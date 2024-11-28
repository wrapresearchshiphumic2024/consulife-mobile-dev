import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/psikolog_history_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';

class PsikologHistoryView extends GetView<PsikologHistoryController> {
  const PsikologHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(),
        title: const Text(
          'Appointment History',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.appointmentHistory.length,
          itemBuilder: (context, index) {
            final appointment = controller.appointmentHistory[index];
            final statusColor = appointment['status'] == 'Canceled Consultation'
                ? warningColor
                : primaryColor;

            return GestureDetector(
              onTap: () {
                // if (appointment['status'] == 'Canceled Consultation') {
                //   Get.toNamed(
                //     Routes.canceledDetail,
                //     arguments: {'appointment': appointment},
                //   );
                // } else if (appointment['status'] == 'Completed Consultation') {
                //   Get.toNamed(
                //     Routes.completedDetail,
                //     arguments: {'appointment': appointment},
                //   );
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          appointment['status'] ?? '',
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
                            "Name: ${appointment['name']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Time: ${appointment['time']}",
                            style: const TextStyle(fontSize: 14),
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
      ),
    );
  }
}
