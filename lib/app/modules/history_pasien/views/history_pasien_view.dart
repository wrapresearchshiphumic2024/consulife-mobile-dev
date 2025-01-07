import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_pasien_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class HistoryPasienView extends GetView<HistoryPasienController> {
  const HistoryPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBack(),
        title: const Text(
          'Appointment History',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final history = controller.appointmentData.value.history;
        return controller.isLoading.value
            ? const LoadingCustom()
            : CustomRefreshIndicator(
                onRefresh: () async {
                  await controller.fetchAppointments();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final appointment = history[index];
                    final statusColor = appointment.status == 'canceled'
                        ? warningColor
                        : primaryColor;

                    return _buildAppointmentCard(appointment, statusColor);
                  },
                ),
              );
      }),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment, Color statusColor) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_COMPLETED_PASIEN,
          arguments: appointment.id.toString()),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bagian status appointment (dijadikan kiri)
            Container(
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft, // Menjorok ke kiri
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0), // Memberi jarak dari kiri
                  child: Text(
                    '${appointment.status.capitalizeFirst!} Appointment',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                    "Name: ${appointment.user.firstname} ${appointment.user.lastname}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Time: ${formatDate(appointment.date)}, ${appointment.startTime}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
