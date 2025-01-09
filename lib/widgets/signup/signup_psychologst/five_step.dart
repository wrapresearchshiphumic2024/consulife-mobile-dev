import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/app/utils/validation/signup_validation.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:flutter/widgets.dart';

class FiveStep extends StatelessWidget {
  final SignupPsychologstController controller;
  const FiveStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomTextField untuk First Name
        CustomTextField(
          controller: controller.degree,
          labelText: "Degree",
          validator: SignupValidation.validateDegree,
        ),
        const SizedBox(height: 10),

        CustomTextField(
          controller: controller.university,
          labelText: "University",
          validator: SignupValidation.validateUniversity,
        ),
        const SizedBox(height: 10),

        // Wrap Password field with Obx to listen for showPassword

        CustomTextField(
          controller: controller.major,
          labelText: "Major",
          validator: SignupValidation.validateMajor,
        ),

        const SizedBox(height: 10),
        CustomTextField(
          controller: controller.graduationYear,
          labelText: "Graduation Year",
          isNumber: true,
          validator: SignupValidation.validateGraduationYear,
        ),
        // Wrap Confirm Password field with Obx to listen for showConfirmPassword
      ],
    );
  }
}
