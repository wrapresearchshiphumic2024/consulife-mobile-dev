import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_completed_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
const double defaultPadding = 16.0;

class DetailCompletedPasienView
    extends GetView<DetailCompletedPasienController> {
  const DetailCompletedPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Psychologist Detail',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const LoadingCustom()
            : CustomRefreshIndicator(
                onRefresh: () async {
                  await controller.fetchAppointmentDetails(Get.arguments);
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(defaultPadding),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.appointmentDetail.value!.user.firstname.capitalizeFirst} ${controller.appointmentDetail.value!.user.lastname.capitalizeFirst}',
                                style: const TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    controller
                                        .appointmentDetail.value!.user.email
                                        .toString(),
                                    style: const TextStyle(color: textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.work_outline_rounded,
                                      size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    controller.appointmentDetail.value!.user
                                        .psychologist!.workExperience
                                        .toString(),
                                    style: const TextStyle(color: textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  controller.appointmentDetail.value!.user
                                              .gender
                                              .toString() ==
                                          "Male"
                                      ? const Icon(Icons.male, size: 16.0)
                                      : const Icon(Icons.female, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    controller
                                        .appointmentDetail.value!.user.gender
                                        .toString(),
                                    style: const TextStyle(color: textColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Specialties:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Menampilkan spesialisasi secara dinamis menggunakan Wrap
                      Obx(() {
                        List<String>? specializations = controller
                            .appointmentDetail
                            .value
                            ?.user
                            .psychologist
                            ?.specialization;

                        if (specializations == null ||
                            specializations.isEmpty) {
                          return const Center(
                              child: Text('No specializations available'));
                        }

                        return Wrap(
                          spacing: 2.0, // Jarak horizontal antar kartu
                          runSpacing: 2.0, // Jarak vertical antar baris
                          alignment: WrapAlignment.start,
                          children: specializations.map((specialization) {
                            return Card(
                              color: carddetail,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  specialization,
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                      const SizedBox(height: 16.0),
                      Card(
                        color: _getStatusColor(controller
                            .appointmentDetail.value!.status
                            .toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              controller.appointmentDetail.value!.status
                                  .capitalizeFirst
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Card(
                        color: carddetail,
                        margin: EdgeInsets.zero,
                        child: SizedBox(
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Appointment Information',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Date: ${formatDate(controller.appointmentDetail.value!.date)}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Time: ${controller.appointmentDetail.value!.startTime} - ${controller.appointmentDetail.value!.endTime}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Status: ${controller.appointmentDetail.value!.status.capitalizeFirst}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Duration: ${controller.appointmentDetail.value!.duration}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Card(
                        color: carddetail,
                        margin: EdgeInsets.zero,
                        child: Container(
                          width: width, // Mengatur lebar menjadi full width
                          padding: const EdgeInsets.all(
                              16.0), // Padding di dalam Card
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                controller.appointmentDetail.value!.note
                                    .toString(),
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller.appointmentDetail.value!.status.toString() ==
                              'ongoing'
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Card(
                              color: carddetail,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL_CHAT_PATIENT,
                                    arguments: controller.appointmentDetail.value!.channelId.toString(),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/chat_pasien.svg',
                                        color: textColor,
                                        height: 32.0,
                                        width: 32.0,
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Text(
                                          'Message your Psychologist',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Card(
                              color: carddetail,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: InkWell(
                                onTap: () { // Tetap menggunakan onTap
                                  // Aksi untuk "Online therapy session"
                                },
                                borderRadius: BorderRadius.circular(12.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/video.svg',
                                        color: textColor,
                                        height: 22.0,
                                        width: 32.0,
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Text(
                                          'Online therapy session',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : const SizedBox(),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return textColor;
    }
  }
}
