import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/app/utils/validation/signup_validation.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_dropdown_field.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:flutter/material.dart';

class FirstStep extends StatelessWidget {
  final SignupPsychologstController controller;

  const FirstStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomTextField untuk First Name
        CustomTextField(
          controller: controller.firstname,
          labelText: "First Name",
          validator: SignupValidation.validateFirstName,
        ),
        const SizedBox(height: 10),

        CustomTextField(
          controller: controller.lastname,
          labelText: "Last Name",
          validator: SignupValidation.validateLastName,
        ),
        const SizedBox(height: 10),

        // CustomDropdownField untuk Gender
        CustomDropdownField<String>(
          value: controller.selectedGender.value,
          labelText: "Gender",
          items: const ['Male', 'Female'],
          onChanged: (value) {
            if (value != null) {
              controller.selectedGender.value = value;
            }
          },
          validator: SignupValidation.validateGender,
        ),
      ],
    );
  }
}
