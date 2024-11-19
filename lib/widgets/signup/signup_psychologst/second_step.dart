import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/app/utils/validation/signup_validation.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SecondStep extends StatelessWidget {
  final SignupPsychologstController controller;

  const SecondStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomTextField untuk First Name
        CustomTextField(
          controller: controller.email,
          labelText: "Email",
          validator: SignupValidation.validateEmail,
        ),
        const SizedBox(height: 10),

        CustomTextField(
          controller: controller.phoneNumber,
          labelText: "Phone Number",
          isNumber: true, // Mengatur agar input ini hanya menerima angka
          validator: SignupValidation.validatePhoneNumber,
        ),
        const SizedBox(height: 10),

        // Wrap Password field with Obx to listen for showPassword
        Obx(() {
          return CustomTextField(
            controller: controller.password,
            labelText: "Password",
            isPassword: true,
            showPassword: controller.showPassword.value,
            onTogglePasswordVisibility: controller.changeShowPassword,
            validator: SignupValidation.validatePassword,
          );
        }),
        const SizedBox(height: 10),

        // Wrap Confirm Password field with Obx to listen for showConfirmPassword
        Obx(() {
          return CustomTextField(
            controller: controller.confirmPassword,
            labelText: "Confirm Password",
            showPassword: controller.showConfirmPassword.value,
            isPassword: true,
            onTogglePasswordVisibility: controller.changeShowConfirmPassword,
            validator: (value) => SignupValidation.validateConfirmPassword(
                value, controller.password.text),
          );
        }),
      ],
    );
  }
}
