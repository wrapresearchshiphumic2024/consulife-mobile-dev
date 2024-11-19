import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/four_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/second_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/third_step.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class SignupPsychologstController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  var selectedGender = 'Male'.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final language = MultiSelectController<String>();
  final specialization = MultiSelectController<String>();
  final TextEditingController professionalIdentificationNumber =
      TextEditingController();
  var selectedWorkExperience = '1 Years'.obs;
  var languageMaster = "Indonesia".obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final practiceLicenceFileName = "Practice Licence".obs;
  final curricullumVitaeFileName = "Curriculum Vitae".obs;
  final additionalCertificationsFileName = "Additional Certifications".obs;
  final step = 0.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;
  final languages = [
    DropdownItem(label: 'Indonesia', value: "Indonesia"),
    DropdownItem(label: 'English', value: "English"),
  ];
  final spesializations = [
    DropdownItem(label: 'Clinical Psychology', value: "Clinical Psychology"),
    DropdownItem(
        label: 'Educational Psychology', value: "Educational Psychology"),
    DropdownItem(
        label: 'Developmental Psychology', value: "Developmental Psychology"),
    DropdownItem(label: 'General Psychology', value: "General Psychology"),
  ];
  // Observable list for multi-select dropdown
  var selectedSpecializations = <String>[].obs;

  // Form steps
  var steps = <Widget>[];

  @override
  void onInit() {
    super.onInit();
    steps = [
      FirstStep(controller: this),
      SecondStep(controller: this),
      ThirdStep(controller: this),
      FourStep(controller: this),
    ];
  }

  // Validasi untuk setiap step
  bool validateStep() {
    if (step.value == 3) {
      // Validasi untuk Step 3
      return practiceLicenceFileName.value != "Practice Licence" &&
          curricullumVitaeFileName.value != "Curriculum Vitae" &&
          additionalCertificationsFileName.value != "Additional Certifications";
    }

    return formKey.currentState?.validate() ?? false;
  }

  bool isLastStepValid() {
    if (step.value == steps.length - 1) {
      return practiceLicenceFileName.value != "Practice Licence" &&
          curricullumVitaeFileName.value != "Curriculum Vitae" &&
          additionalCertificationsFileName.value != "Additional Certifications";
    }
    return true;
  }

  void goToNextStep() {
    if (validateStep()) {
      if (step.value < steps.length - 1) {
        step.value++;
      } else {
        Get.snackbar("Success", "Sign up success");
        Get.back();
      }
    }
  }

  // Toggle password visibility
  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  // Toggle confirm password visibility
  void changeShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  // Method to update selected specializations from multi-select dropdown
  void updateSpecializations(List<String> selectedItems) {
    selectedSpecializations.value = selectedItems;
  }

  void uploadFilePracticeLicense() async {
    // Upload file here
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension != "pdf") {
        Get.snackbar("Error", "File harus berformat pdf");
        return;
      }
      practiceLicenceFileName.value = result.files.single.name;
    } else {
      Get.snackbar("Error", "Gagal memilih file");
    }
  }

  void uploadFileCV() async {
    // Upload file here
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension != "pdf") {
        Get.snackbar("Error", "File harus berformat pdf");
        return;
      }
      curricullumVitaeFileName.value = result.files.single.name;
    } else {
      Get.snackbar("Error", "Gagal memilih file");
    }
  }

  void uploadFileSertificate() async {
    // Upload file here
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension != "pdf") {
        Get.snackbar("Error", "File harus berformat pdf");
        return;
      }
      additionalCertificationsFileName.value = result.files.single.name;
    } else {
      Get.snackbar("Error", "Gagal memilih file");
    }
  }
}
