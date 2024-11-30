import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_ongoing_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailOngoingView extends GetView<DetailOngoingController> {
  const DetailOngoingView({super.key});

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
        title: const Text('Patient Detail',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.grey),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProfileSection(),
          _buildTabNavigation(),
          Expanded(child: _buildTabContent())
        ],
      ),
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
          SizedBox(height: 16.0),
          Text(
            controller.patientName ?? 'John Doe',
            style: TextStyle(
              fontSize: 22.0,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              'Ongoing Appointment',
              style: TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              "Patient Detail",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Name: ${controller.patientName}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Gender: ${controller.patientGender}",
              style: TextStyle(
                fontSize: 16,
                color: textColor
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Email: ${controller.patientEmail}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Phone: ${controller.patientPhone}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Appointment: ${controller.appointmentDate.toLocal().toString().substring(0, 16)}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.done(Get.context!);
                    },
                    child: Text('Done', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {controller.cancel(Get.context!);},
                    child: Text('Cancel', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
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
            padding: EdgeInsets.symmetric(vertical: 10.0),
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
                  duration: Duration(milliseconds: 300),
                  width: controller.selectedTabIndex.value == index
                      ? label.length * 6.0 / 2
                      : 0.0,
                  height: 3.0,
                  color: controller.selectedTabIndex.value == index
                      ? textColor
                      : Colors.transparent,
                  margin: EdgeInsets.only(top: 5.0),
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
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildPatientCard(),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
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
        SizedBox(height: 8),
        Text(
          "Last analyzed: 01 Oct, 2024",
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
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
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Probability of Stress",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${controller.stressProbability}%",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
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
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Probability of Anxiety",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${controller.anxietyProbability}%",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
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
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Probability of Depression",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${controller.depressionProbability}%",
                  style: TextStyle(
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
    );
  }

  Widget _buildChatRoomTab() {
    return Center(
      child: Text("Chat Room (Coming Soon)", style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildReviewConcernTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [

        Text(
          "Latest Analyze Result",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16.0),
          color: carddetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "${controller.appointmentDate.toLocal().toString().substring(0, 10)}", // Hanya tahun-bulan-tanggal
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "I often feel overwhelmed with my daily tasks, and I struggle to find motivation. I have trouble sleeping and frequently feel anxious about upcoming deadlines. Additionally, I sometimes feel sad without any specific reason, making it difficult to enjoy things I once liked.",
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                Divider(color: textColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Probability of Stress: ${controller.stressProbability}%", style: TextStyle(color: textColor)),
                    Text("Probability of Anxiety: ${controller.anxietyProbability}%", style: TextStyle(color: textColor)),
                    Text("Probability of Depression:  ${controller.depressionProbability}%", style: TextStyle(color: textColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Text(
          "Earlier Scan Result",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 16.0),
          color: carddetail,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.appointmentDate.toLocal().toString().substring(0, 10)}",  // Ganti dengan tanggal yang sesuai
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "I often feel overwhelmed with my daily tasks, and I struggle to find motivation. I have trouble sleeping and frequently feel anxious about upcoming deadlines. Additionally, I sometimes feel sad without any specific reason, making it difficult to enjoy things I once liked.",
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                Divider(color: textColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Probability of Stress: ${controller.stressProbability}%", style: TextStyle(color: textColor)),
                        Text("Probability of Anxiety: ${controller.anxietyProbability}%", style: TextStyle(color: textColor)),
                        Text("Probability of Depression:  ${controller.depressionProbability}%", style: TextStyle(color: textColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
