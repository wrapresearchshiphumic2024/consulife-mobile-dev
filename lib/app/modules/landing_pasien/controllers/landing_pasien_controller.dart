import 'package:get/get.dart';
import 'package:consulin_mobile_dev/app/modules/Profile/views/profile_pycholog_view.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/controllers/home_psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/views/home_psycholog_view.dart';
import 'package:consulin_mobile_dev/app/modules/manage_schedule/controllers/manage_schedule_controller.dart';
import 'package:consulin_mobile_dev/app/modules/manage_schedule/views/manage_schedule_view.dart';
import 'package:flutter/material.dart';

class LandingPasienController extends GetxController {
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.put(HomePsychologController());
    Get.put(ManageScheduleController());
  }

  final List<Widget> bodyView = <Widget>[
    const HomePsychologView(),
    const ManageScheduleView(),
    const ManageScheduleView(),
    const Text('Index 2: Camera'),
    const ProfilePychologView()
  ];

  final List<String> labels = ['Home', 'Schedule','Ai', 'Chat', 'Profile'];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Widget tabItem

      (Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

