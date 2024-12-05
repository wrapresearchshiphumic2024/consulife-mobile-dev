import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/landing_pasien_controller.dart';

class LandingPasienView extends GetView<LandingPasienController> {
  const LandingPasienView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = [
      SvgPicture.asset(
        'assets/icons/home.svg',
        semanticsLabel: 'Red dash paths',
      ),
      SvgPicture.asset(
        'assets/icons/psycho.svg',
        semanticsLabel: 'Red dash paths',
      ),
      SvgPicture.asset(
        'assets/icons/AIButton.svg',
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
                      .spaceAround,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
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