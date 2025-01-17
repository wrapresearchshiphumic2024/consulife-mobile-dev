import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controllers/detail_completed_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class DetailCompletedView extends GetView<DetailCompletedController> {
  const DetailCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Patient Detail',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Obx(() {
            if (controller.appointmentDetail.value != null &&
                controller.appointmentDetail.value!.status == 'ongoing') {
              return IconButton(
                icon: const Icon(Icons.videocam, color: primaryColor),
                onPressed: controller.joinMeet,
              );
            } else {
              return Container();
            }
          }),
          // IconButton(
          //   icon: const Icon(Icons.videocam, color: primaryColor),
          //   onPressed: controller.joinMeet,
          // )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
              color: Colors.black,
              size: 50,
            ),
          );
        }
        return Column(
          children: [
            _buildProfileSection(),
            _buildTabNavigation(),
            Expanded(child: _buildTabContent())
          ],
        );
      }),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.person,
              size: 50,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            '${controller.appointmentDetail.value!.user.firstname} ${controller.appointmentDetail.value!.user.lastname}',
            style: const TextStyle(
              fontSize: 22.0,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            decoration: BoxDecoration(
              color:
                  _getStatusColor(controller.appointmentDetail.value!.status),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              '${controller.appointmentDetail.value!.status.capitalizeFirst!} Appointment',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
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

  Widget _buildPatientCard() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: carddetail,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            const Text(
              "Patient Detail",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Name: ${controller.appointmentDetail.value!.user.firstname} ${controller.appointmentDetail.value!.user.lastname}",
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Gender: ${controller.appointmentDetail.value!.user.gender}",
              style: const TextStyle(fontSize: 16, color: textColor),
            ),
            const SizedBox(height: 5),
            Text(
              "Email: ${controller.appointmentDetail.value!.user.email}",
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Phone: ${controller.appointmentDetail.value!.user.phoneNumber}",
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Appointment: ${formatDate(controller.appointmentDetail.value!.date)}, ${controller.appointmentDetail.value!.startTime}",
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.appointmentDetail.value!.status == 'ongoing') {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.done(Get.context!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Done',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              } else if (controller.appointmentDetail.value!.status ==
                      'waiting' ||
                  controller.appointmentDetail.value!.status == 'ongoing') {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.cancel(Get.context!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabButton('Overview', 0),
          _buildTabButton('Chat Room', 1),
          _buildTabButton('Review Concern', 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.selectedTabIndex.value == index
                        ? textColor
                        : texttrans,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: controller.selectedTabIndex.value == index
                      ? label.length * 6.0 / 2
                      : 0.0,
                  height: 3.0,
                  color: controller.selectedTabIndex.value == index
                      ? textColor
                      : Colors.transparent,
                  margin: const EdgeInsets.only(top: 5.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(
      () {
        if (controller.selectedTabIndex.value == 0) {
          return _buildOverviewTab();
        } else if (controller.selectedTabIndex.value == 1) {
          return _buildChatRoomTab();
        } else {
          return _buildReviewConcernTab();
        }
      },
    );
  }

  Widget _buildOverviewTab() {
    return CustomRefreshIndicator(
      onRefresh: () =>
          controller.fetchAppointmentDetails(Get.arguments.toString()),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildPatientCard(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "AI Analysis Result",
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    controller.changeTab(2);
                  },
                  child: const Text(
                    "See Review Concern",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.w100),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Last analyzed: ${formatDate(controller.appointmentDetail.value?.aiAnalyzer?.createdAt.toString() ?? '')}",
            style: const TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.asset(
                  'assets/icons/stress.svg',
                  semanticsLabel: 'Stress Icon',
                  height: 60,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Probability of Stress",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${controller.appointmentDetail.value?.aiAnalyzer?.stress}%",
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.asset(
                  'assets/icons/ansiety.svg',
                  semanticsLabel: 'Anxiety Icon',
                  height: 67,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Probability of Anxiety",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${controller.appointmentDetail.value?.aiAnalyzer?.anxiety}%",
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SvgPicture.asset(
                  'assets/icons/depresi.svg',
                  semanticsLabel: 'Depression Icon',
                  height: 60,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Probability of Depression",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${controller.appointmentDetail.value?.aiAnalyzer?.depression}%",
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatRoomTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingCustom();
      }

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: const Color(0xffF5F5F7),
        ),
        builder: (context, widget) {
          return StreamChat(
            client: controller.client,
            child: widget,
          );
        },
        home: Obx(() {
          return controller.isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.progressiveDots(
                    color: Colors.black,
                    size: 50,
                  ),
                )
              : StreamChannel(
                  showLoading: true,
                  loadingBuilder: (context) => const LoadingCustom(),
                  channel: controller.channel,
                  child: ChannelPage(),
                );
        }),
      );
    });
  }

  Widget _buildReviewConcernTab() {
    return ListView.builder(
      itemCount: controller.aiAnalysisHistory.value?.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16.0),
          color: carddetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDate(
                      controller.aiAnalysisHistory.value?[index].createdAt ??
                          ''), // Hanya tahun-bulan-tanggal
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.aiAnalysisHistory.value?[index].complaint ?? '',
                  style: const TextStyle(fontSize: 16, color: textColor),
                ),
                const Divider(color: textColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Probability of Stress: ${controller.aiAnalysisHistory.value?[index].stress}%",
                            style: const TextStyle(color: textColor)),
                        Text(
                            "Probability of Anxiety: ${controller.aiAnalysisHistory.value?[index].anxiety}%",
                            style: const TextStyle(color: textColor)),
                        Text(
                            "Probability of Depression:  ${controller.aiAnalysisHistory.value?[index].depression}%",
                            style: const TextStyle(color: textColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChannelPage extends StatelessWidget {
  final DetailCompletedController controller = Get.find();
  ChannelPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Expanded(
            child: StreamMessageListView(),
          ),
          Obx(() {
            if (controller.appointmentDetail.value!.status == 'ongoing') {
              return const StreamMessageInput();
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
