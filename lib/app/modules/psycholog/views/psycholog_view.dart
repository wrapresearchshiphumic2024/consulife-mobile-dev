import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/string_helper.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';
import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/psycholog_controller.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/models/user.dart';

class PsychologView extends GetView<PsychologController> {
  const PsychologView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Obx to manage the UI based on state
    return Scaffold(
      body: Obx(() {
        if (!controller.patientHasAIAnalysis.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'AI Analysis Required',
                    style: TextStyle(fontSize: 25, color: textColor),
                  ),
                  const Text(
                      " You need to complete the AI analysis before proceeding. Please go to your Ai Analyzer and fill out the required information."),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    onPressed: () {
                      controller.landingPatientController.selectedIndex.value =
                          2;
                    }, // Implement navigation to AI Analyzer
                    buttonText: 'Go to Ai Analyzer',
                    primaryColor: primaryColor,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller.name,
                  onChanged: (value) {
                    // Ensure fetchPsychologists is only called when necessary
                    if (value.isNotEmpty) {
                      controller.fetchPsychologists(
                        name: value,
                        gender: controller.gender.value,
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search psychologist by name',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              // Gender Filter with Obx
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GenderFilterButton(
                      genderLabel: 'All',
                      genderValue: '',
                      selectedGender: controller.gender,
                      onGenderSelected: (gender) {
                        controller.gender.value = gender;
                        controller.fetchPsychologists(
                            name: controller.name.text, gender: gender);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    GenderFilterButton(
                      genderLabel: 'Male',
                      genderValue: 'Male',
                      selectedGender: controller.gender,
                      onGenderSelected: (gender) {
                        controller.gender.value = gender;
                        controller.fetchPsychologists(
                            name: controller.name.text, gender: gender);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    GenderFilterButton(
                      genderLabel: 'Female',
                      genderValue: 'Female',
                      selectedGender: controller.gender,
                      onGenderSelected: (gender) {
                        controller.gender.value = gender;
                        controller.fetchPsychologists(
                            name: controller.name.text, gender: gender);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              // List of Psychologists
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const LoadingCustom();
                  } else if (controller.psychologists.isEmpty) {
                    return const Center(child: Text("No psychologists found."));
                  } else {
                    return CustomRefreshIndicator(
                      onRefresh: () => controller.fetchPsychologists(
                        name: controller.name.text,
                        gender: controller.gender.value,
                      ),
                      child: ListView.builder(
                        itemCount: controller.psychologists.length,
                        itemBuilder: (context, index) {
                          final psychologist = controller.psychologists[index];
                          return PsychologistCard(
                            psychologist: psychologist,
                            onTap: () {
                              // Handle onTap action here
                              Get.toNamed(Routes.DETAIL_AVAILABLE_PASIEN,
                                  arguments: psychologist.id);
                            },
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}

class PsychologistCard extends StatelessWidget {
  final User psychologist;
  final VoidCallback onTap;

  const PsychologistCard({
    super.key,
    required this.psychologist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: carddetail,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${psychologist.firstname.capitalizeFirst} ${psychologist.lastname.capitalizeFirst}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              getSpecializationString(
                                  psychologist.psychologist?.specialization),
                              style: const TextStyle(fontSize: 10),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GenderInfoBadge(
                                  gender: psychologist.gender.toString(),
                                ),
                                const SizedBox(width: 8.0),
                                ExperienceInfoBadge(
                                  experience: psychologist
                                          .psychologist?.workExperience
                                          .toString() ??
                                      'N/A',
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderInfoBadge extends StatelessWidget {
  final String gender;

  const GenderInfoBadge({
    super.key,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            gender == 'Male' ? Icons.male : Icons.female,
            size: 12,
            color: textColor,
          ),
          const SizedBox(width: 8.0),
          Text(
            gender,
            style: const TextStyle(
              color: textColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceInfoBadge extends StatelessWidget {
  final String experience;
  const ExperienceInfoBadge({
    super.key,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 8.0),
          Text(
            experience, // Example experience value
            style: const TextStyle(
              color: textColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class GenderFilterButton extends StatelessWidget {
  final String genderLabel;
  final String genderValue;
  final RxString selectedGender;
  final Function(String) onGenderSelected;

  const GenderFilterButton({
    super.key,
    required this.genderLabel,
    required this.genderValue,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ElevatedButton(
        onPressed: () {
          onGenderSelected(genderValue); // When button pressed, select gender
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedGender.value == genderValue
              ? primaryColor
              : Colors.grey, // Button color changes based on selection
        ),
        child: Text(
          genderLabel,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      );
    });
  }
}
