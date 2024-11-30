import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/psikolog_pro_det_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_text_field.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_elevated_button.dart';
import 'package:consulin_mobile_dev/widgets/ui/custom_multidropdown.dart';
class PsikologProDetView extends GetView<PsikologProDetController> {
  const PsikologProDetView({super.key});

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
          'Edit Information',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    "David William",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "1234567888099",
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
              controller: controller.universityController,
              labelText: "University",
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: controller.degreeController,
              labelText: "Degree",
            ),
            const SizedBox(height: 16),
            CustomMultiDropdown<String>(
              label: "Specialization",
              items: controller.specializationOptions
                  .map((specialization) => DropdownItem<String>(
                value: specialization,
                label: specialization,
              ))
                  .toList(),
              controller: MultiSelectController<String>(),
              onSelectionChange: (selectedItems) {
                controller.specialization.value = selectedItems;
                print("Selected Specializations: $selectedItems");
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: controller.graduationYear.value.isNotEmpty
                  ? controller.graduationYear.value
                  : null,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.graduationYear.value = newValue;
                }
              },
              decoration: InputDecoration(
                labelText: "Graduation Year",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: controller.graduationYearOptions
                  .map((year) => DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: controller.languageMaster.value.isNotEmpty
                  ? controller.languageMaster.value
                  : null,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.languageMaster.value = newValue;
                }
              },
              decoration: InputDecoration(
                labelText: "Language",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: controller.languageOptions
                  .map((language) => DropdownMenuItem<String>(
                value: language,
                child: Text(language),
              ))
                  .toList(),
            ),
            const SizedBox(height: 32),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomElevatedButton(
                  primaryColor: primaryColor,
                  onPressed: () {
                    controller.saveChanges();
                  },
                  buttonText: "Save",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => controller.cancel(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
