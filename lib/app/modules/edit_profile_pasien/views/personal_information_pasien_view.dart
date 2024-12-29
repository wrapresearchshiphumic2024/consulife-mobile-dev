import 'package:consulin_mobile_dev/widgets/ui/loading_custom.dart';
import 'package:consulin_mobile_dev/widgets/ui/refresh_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/personal_information_pasien_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/utils/validation/signup_validation.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_dropdown_field.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';

class PersonalInformationPasienView
    extends GetView<PersonalInformationPasienController> {
  const PersonalInformationPasienView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: textColor, size: 40),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const LoadingCustom()
            : CustomRefreshIndicator(
                onRefresh: () async {
                  await controller.fetchPsychologistProfile();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: textColor,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "${controller.profile.value.firstname.capitalizeFirst} ${controller.profile.value.lastname.capitalizeFirst}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.profile.value.phoneNumber.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        controller: controller.firstnameController,
                        labelText: "First Name",
                        isEnabled: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.lastnameController,
                        labelText: "Last Name",
                        isEnabled: false,
                      ),
                      const SizedBox(height: 16),
                      CustomDropdownField<String>(
                        value: controller.selectedGender.value,
                        labelText: "Gender",
                        items: const ['Male', 'Female'],
                        isEnabled: false,
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedGender.value = value;
                          }
                        },
                        validator: SignupValidation.validateGender,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.phoneNumberController,
                        labelText: "Phone Number",
                        isNumber: true,
                        isEnabled: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: controller.emailController,
                        labelText: "Email",
                        isEnabled: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid email.";
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomElevatedButton(
                            primaryColor: primaryColor,
                            isEnabled: false,
                            onPressed: () {
                              controller.saveChanges();
                            },
                            buttonText: "Save",
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
