import 'package:consulin_mobile_dev/app/modules/ProfilePycholog/views/profile_pycholog_view.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/controllers/home_psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/views/home_psycholog_view.dart';
import 'package:consulin_mobile_dev/app/modules/manage_schedule/controllers/manage_schedule_controller.dart';
import 'package:consulin_mobile_dev/app/modules/manage_schedule/views/manage_schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPsychologController extends GetxController {
  // Rx variable for selected index
  final selectedIndex = 0.obs;

  // Sample list of body view widgets
  @override
  void onInit() {
    super.onInit();
    Get.put(HomePsychologController());
    Get.put(ManageScheduleController());
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> bodyView = <Widget>[
    const HomePsychologView(),
    const ManageScheduleView(),
    const Text('Index 2: Camera', style: optionStyle),
    ProfilePychologView()
  ];

  // Tab labels
  final List<String> labels = ['Home', 'Schedule', 'Chat', "Profile"];

  // Function to handle tab item selection
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Widget tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 300),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffDDE7F9),
            ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ikon tetap di tengah
          child,
          // Menggunakan AnimatedSwitcher untuk animasi label
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSelected
                ? SizedBox(
                    key: ValueKey<String>(label), // Kunci untuk animasi
                    height: 20, // Tinggi untuk menjaga posisi
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                : SizedBox(
                    key: ValueKey<String>(''), // Kunci untuk animasi
                    height: 0, // Tinggi 0 saat tidak aktif
                  ),
          ),
        ],
      ),
    );
  }
}
