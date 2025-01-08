import 'package:consulin_mobile_dev/app/modules/chat_patient/controllers/chat_patient_controller.dart';
import 'package:consulin_mobile_dev/app/modules/chat_patient/views/chat_patient_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:consulin_mobile_dev/app/modules/home_pasien/controllers/home_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/modules/home_pasien/views/home_pasien_view.dart';
import 'package:consulin_mobile_dev/app/modules/psycholog/controllers/psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/modules/psycholog/views/psycholog_view.dart';
import 'package:consulin_mobile_dev/app/modules/profile_pasien/controllers/profile_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/modules/profile_pasien/views/profile_pasien_view.dart';
import 'package:consulin_mobile_dev/app/modules/ai_analyzer_pasien/controllers/ai_analyzer_pasien_controller.dart';
import 'package:consulin_mobile_dev/app/modules/ai_analyzer_pasien/views/ai_analyzer_pasien_view.dart';

class LandingPasienController extends GetxController {
  final selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => ProfilePasienController());
    Get.lazyPut(() => HomePasienController());
    Get.lazyPut(() => PsychologController());
    Get.lazyPut(() => ChatPatientController());
    Get.lazyPut(() => AiAnalyzerPasienController());
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> bodyView = <Widget>[
    const HomePasienView(),
    const PsychologView(),
    const AiAnalyzerPasienView(),
    const ChatPatientView(),
    const ProfilePasienView(),
  ];

  final List<String> labels = ['Home', 'Psyc', 'AI', 'Chat', "Profile"];

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
          child,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSelected
                ? SizedBox(
                    key: ValueKey<String>(label),
                    height: 20,
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                : const SizedBox(
                    key: ValueKey<String>(''),
                    height: 0,
                  ),
          ),
        ],
      ),
    );
  }
}
