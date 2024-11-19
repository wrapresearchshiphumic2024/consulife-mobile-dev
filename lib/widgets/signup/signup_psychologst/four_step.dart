import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/widgets/ui/file_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FourStep extends StatelessWidget {
  final SignupPsychologstController controller;

  const FourStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          FilePickerWidget(
            label: controller.practiceLicenceFileName.value,
            onPressed: controller.uploadFilePracticeLicense,
          ),
          const SizedBox(height: 10),
          FilePickerWidget(
            label: controller.curricullumVitaeFileName.value,
            onPressed: controller.uploadFileCV,
          ),
          const SizedBox(height: 10),
          FilePickerWidget(
            label: controller.additionalCertificationsFileName.value,
            onPressed: controller.uploadFileSertificate,
          )
        ],
      );
    });
  }
}
