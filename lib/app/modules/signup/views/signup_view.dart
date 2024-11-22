import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/widgets/signup/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/second_step.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return LinearProgressIndicator(
                  color: primaryColor,
                  value: (controller.step.value + 1) / controller.steps.length,
                  minHeight: 10,
                );
              }),
              ButtonBack(
                onBackPressed: () {
                  if (controller.step.value == 0) {
                    // Jika berada di step 0, navigasi kembali ke halaman sebelumnya
                    Get.back();
                  } else {
                    // Jika di step 1 atau lebih, kembali ke langkah sebelumnya
                    controller.step.value -= 1;
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Become part of our platform and connect with individuals seeking mental health support",
                      style: TextStyle(color: textColor),
                    )
                  ],
                ),
              ),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // Menampilkan step aktif berdasarkan controller.step.value
                      Obx(() {
                        if (controller.step.value == 0) {
                          return FirstStep(controller: controller);
                        } else if (controller.step.value == 1) {
                          return SecondStep(controller: controller);
                        }

                        return const SizedBox();
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        bool isLastStep = controller.step.value ==
                            controller.steps.length - 1;

                        return SizedBox(
                          width: width,
                          child: ElevatedButton(
                            onPressed: controller
                                .goToNextStep, // Lanjutkan jika validasi berhasil
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  primaryColor, // Warna tombol jika valid
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: Text(
                              isLastStep ? "Create Account" : "Next",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
