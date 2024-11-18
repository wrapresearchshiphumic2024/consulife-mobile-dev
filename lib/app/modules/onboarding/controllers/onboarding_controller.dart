import 'package:consulin_mobile_dev/app/models/onboard.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  var pageIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  final List<OnBoard> data = [
    OnBoard(
      image: "assets/images/Onboarding.png",
      title: "AI Analyzer for Mental Health",
      description:
          "Receive instant feedback your stress, anxiety and depression with our AI Analyzer",
    ),
    OnBoard(
      image: "assets/images/Onboarding3.png",
      title: "Consult with Psychologists",
      description:
          "Consult with professionals anytime through chat or video sessions, free of charge",
    ),
    OnBoard(
      image: "assets/images/Onboarding2.png",
      title: "Collaborate with Psychologists",
      description:
          "As a psychologist, collaborate with your peers to provide the best care for patients",
    ),
    OnBoard(
      image: "assets/images/Onboarding4.png",
      title: "Free and Accessible for All",
      description:
          "Get mental health support without any cost. We're here to help, always",
    ),
  ];

  void onSlideChange(int index) {
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageIndex.value == data.length - 1) {
      Get.offNamed(Routes.ONBOARDING2);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void prevPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
