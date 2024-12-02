import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/landing_pasien_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LandingPasienView extends GetView<LandingPasienController> {
  const LandingPasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Icons for the bottom navigation
    List<Widget> _icons = [
      SvgPicture.asset('assets/icons/home.svg'),
      SvgPicture.asset('assets/icons/schedule.svg'),
      SvgPicture.asset('assets/icons/chat.svg'),
      SvgPicture.asset('assets/icons/chat.svg'),
      SvgPicture.asset('assets/icons/profile.svg'),
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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        );
      }),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          onPressed: () => controller.onItemTapped(2),
          child: SvgPicture.asset(
            'assets/icons/chat.svg',
            color: controller.selectedIndex.value == 2 ? Colors.white : null,
          ),
          backgroundColor:
          controller.selectedIndex.value == 2 ? Colors.blue : Colors.white,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

