import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/app/utils/validation/signup_validation.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_dropdown_field.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_multidropdown.dart';

import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdStep extends StatelessWidget {
  final SignupPsychologstController controller;

  const ThirdStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CustomTextField untuk First Name
        CustomTextField(
          controller: controller.professionalIdentificationNumber,
          labelText: "Professional identification number",
          isNumber: true,
          validator: SignupValidation.validateProfessionalIdentificationNumber,
        ),
        const SizedBox(height: 10),
        CustomMultiDropdown<String>(
          label: 'Select Languages',
          items: controller.languages,
          controller: controller.language,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select at least one language';
            }
            return null;
          },
          onSelectionChange: (selectedItems) {
            // Handle the selected items
            print("Selected Items: $selectedItems");
          },
        ),
        const SizedBox(height: 10),
        CustomMultiDropdown<String>(
          label: 'Specialization',
          items: controller.specializations,
          controller: controller.specialization,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select at least one language';
            }
            return null;
          },
          onSelectionChange: (selectedItems) {
            // Handle the selected items
            print("Selected Items: $selectedItems");
          },
        ),
        const SizedBox(height: 10),
        CustomDropdownField<String>(
          value: controller.selectedWorkExperience.value,
          labelText: "Work Experience",
          items: const ['1 Years', '2 Years', '3 Years', '4 Years', '5 Years'],
          onChanged: (value) {
            if (value != null) {
              controller.selectedWorkExperience.value = value;
            }
          },
          validator: SignupValidation.workExperience,
        ),
      ],
    );
  }
}
