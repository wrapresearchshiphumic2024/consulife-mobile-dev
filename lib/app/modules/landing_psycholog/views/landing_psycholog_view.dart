import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/landing_psycholog_controller.dart';

class LandingPsychologView extends GetView<LandingPsychologController> {
  const LandingPsychologView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Icons for the bottom navigation
    List<Widget> _icons = [
      SvgPicture.asset(
        'assets/icons/home.svg',
        semanticsLabel: 'Red dash paths',
      ),
      SvgPicture.asset(
        'assets/icons/schedule.svg',
        semanticsLabel: 'Red dash paths',
      ),
      SvgPicture.asset(
        'assets/icons/chat.svg',
        semanticsLabel: 'Red dash paths',
      ),
      SvgPicture.asset(
        'assets/icons/profile.svg',
        semanticsLabel: 'Red dash paths',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Center(
            child: controller.bodyView[controller.selectedIndex.value],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, // Center the icons horizontally
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center the icons vertically
                  children: List.generate(
                    controller.bodyView.length,
                    (index) => GestureDetector(
                      onTap: () => controller.onItemTapped(index),
                      child: controller.tabItem(
                        _icons[index],
                        controller.labels[index],
                        isSelected: index == controller.selectedIndex.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
