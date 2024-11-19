import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboarding2_controller.dart';

class Onboarding2View extends GetView<Onboarding2Controller> {
  const Onboarding2View({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Menjaga elemen dengan space antara
            children: [
              Center(
                child: SizedBox(
                  height: height /
                      1.7, // Menyesuaikan tinggi dengan persentase dari tinggi layar
                  child: Image.asset(
                    'assets/images/Onboarding final.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "discover and make yourself healthy".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const Text(
                      "Start your journey to better mental well-being and balanced living"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.SIGNIN);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 50)),
                      child: const Text(
                        "Sign In Now",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                  const Text(
                    "Wrap Research 2024",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
