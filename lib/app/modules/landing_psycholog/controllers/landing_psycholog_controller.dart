import 'package:consulin_mobile_dev/app/modules/home_psycholog/controllers/home_psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/views/home_psycholog_view.dart';
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
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> bodyView = <Widget>[
    HomePsychologView(),
    const Text('Index 1: Explore', style: optionStyle),
    const Text('Index 2: Camera', style: optionStyle),
    const Text('Index 2: Camera', style: optionStyle),
  ];

  // Tab labels
  final List<String> labels = ['Home', 'Explore', 'Camera', "coba"];

  // Function to handle tab item selection
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  // Widget to create the tab item
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
          child,
          // Animasi untuk label dengan opacity
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0, // Label akan muncul saat selected
            duration: const Duration(milliseconds: 300), // Durasi animasi
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
