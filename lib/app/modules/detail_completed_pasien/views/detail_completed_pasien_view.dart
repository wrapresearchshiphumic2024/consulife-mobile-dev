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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150',
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.appointmentDetail.value!.user.firstname.capitalizeFirst} ${controller.appointmentDetail.value!.user.lastname.capitalizeFirst}',
                                  style: const TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.email_outlined,
                                        size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        controller
                                            .appointmentDetail.value!.user.email
                                            .toString(),
                                        style:
                                            const TextStyle(color: textColor),
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .visible, // Teks akan melanjutkan ke bawah.
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.work_outline_rounded,
                                        size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        controller.appointmentDetail.value!.user
                                            .psychologist!.workExperience
                                            .toString(),
                                        style:
                                            const TextStyle(color: textColor),
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .visible, // Teks akan berpindah ke bawah jika panjang.
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    controller.appointmentDetail.value!.user
                                                .gender
                                                .toString() ==
                                            "Male"
                                        ? const Icon(Icons.male, size: 16.0)
                                        : const Icon(Icons.female, size: 16.0),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        controller.appointmentDetail.value!.user
                                            .gender
                                            .toString(),
                                        style:
                                            const TextStyle(color: textColor),
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .visible, // Menghindari teks terpotong.
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                          spacing: 8.0,
                          runSpacing: 4.0,
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
                      _buildStatusCard(),
                      const SizedBox(height: 16.0),
                      _buildAppointmentInformation(width),
                      const SizedBox(height: 16.0),
                      _buildNoteSection(width),
                      const SizedBox(height: 16.0),
                      if (controller.appointmentDetail.value!.status
                              .toString() ==
                          'ongoing')
                        _buildActionButtons(),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildStatusCard() {
    return Obx(() {
      return Card(
        color: _getStatusColor(
            controller.appointmentDetail.value!.status.toString()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              controller.appointmentDetail.value!.status.capitalizeFirst
                  .toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAppointmentInformation(double width) {
    return Card(
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
                style: const TextStyle(color: textColor, fontSize: 12),
              ),
              Text(
                'Time: ${controller.appointmentDetail.value!.startTime} - ${controller.appointmentDetail.value!.endTime}',
                style: const TextStyle(color: textColor, fontSize: 12),
              ),
              Text(
                'Status: ${controller.appointmentDetail.value!.status.capitalizeFirst}',
                style: const TextStyle(color: textColor, fontSize: 12),
              ),
              Text(
                'Duration: ${controller.appointmentDetail.value!.duration}',
                style: const TextStyle(color: textColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteSection(double width) {
    return Card(
      color: carddetail,
      margin: EdgeInsets.zero,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
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
            Obx(() {
              return Text(
                controller.appointmentDetail.value!.note.toString(),
                style: const TextStyle(color: textColor, fontSize: 12),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildActionCard(
            icon: 'assets/icons/chat_pasien.svg',
            label: 'Message your Psychologist',
            onTap: () {
              Get.toNamed(
                Routes.DETAIL_CHAT_PATIENT,
                arguments:
                    controller.appointmentDetail.value!.channelId.toString(),
              );
            },
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: _buildActionCard(
            icon: 'assets/icons/video.svg',
            label: 'Online therapy session',
            onTap: controller.joinMeet,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      color: carddetail,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: textColor,
                height: 32.0,
                width: 32.0,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
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
