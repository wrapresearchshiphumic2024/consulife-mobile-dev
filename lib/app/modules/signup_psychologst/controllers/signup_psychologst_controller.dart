import 'dart:convert';
import 'dart:io';
import 'package:consulin_mobile_dev/app/routes/app_pages.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/five_step.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:consulin_mobile_dev/app/utils/api/auth/AuthService.dart';
import 'package:consulin_mobile_dev/app/utils/helpers/toast_helper.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/four_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/second_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/third_step.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class SignupPsychologstController extends GetxController {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  var selectedGender = 'Male'.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController degree = TextEditingController();
  final TextEditingController university = TextEditingController();
  final TextEditingController major = TextEditingController();
  final TextEditingController graduationYear = TextEditingController();
  final language = MultiSelectController<String>();
  final specialization = MultiSelectController<String>();
  final TextEditingController professionalIdentificationNumber =
      TextEditingController();
  var selectedWorkExperience = '1 Years'.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var practiceLicenceFile = Rxn<File>();
  var curricullumVitaeFile = Rxn<File>();
  var additionalCertificationsFile = Rxn<File>();

  var practiceLicenceFileName = ''.obs;
  var curricullumVitaeFileName = ''.obs;
  var additionalCertificationsFileName = ''.obs;

  final step = 0.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  var languages = [
    DropdownItem(label: 'Indonesia', value: "Indonesia"),
    DropdownItem(label: 'English', value: "English"),
  ];

  var specializations = [
    DropdownItem(label: 'Clinical Psychology', value: "Clinical Psychology"),
    DropdownItem(
        label: 'Educational Psychology', value: "Educational Psychology"),
    DropdownItem(
        label: 'Developmental Psychology', value: "Developmental Psychology"),
    DropdownItem(label: 'General Psychology', value: "General Psychology"),
  ];

  var selectedSpecializations = <String>[].obs;

  var steps = <Widget>[];

  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    steps = [
      FirstStep(controller: this),
      SecondStep(controller: this),
      ThirdStep(controller: this),
      FiveStep(controller: this),
      FourStep(controller: this),
    ];
  }

  bool validateStep() {
    if (step.value == 4) {
      return practiceLicenceFile.value != null &&
          curricullumVitaeFile.value != null &&
          additionalCertificationsFile.value != null;
    }
    return formKey.currentState?.validate() ?? false;
  }

  bool isLastStepValid() {
    if (step.value == steps.length - 1) {
      return practiceLicenceFile.value != null &&
          curricullumVitaeFile.value != null &&
          additionalCertificationsFile.value != null;
    }
    return true;
  }

  void goToNextStep() async {
    if (validateStep()) {
      if (step.value < steps.length - 1) {
        step.value++;
      } else {
        try {
          var uri = Uri.parse('${dotenv.env["API_URL"]}/register/psychologist');
          var request = http.MultipartRequest('POST', uri)
            ..fields['firstname'] = firstname.text
            ..fields['lastname'] = lastname.text
            ..fields['gender'] = selectedGender.value
            ..fields['email'] = email.text
            ..fields['phone_number'] = phoneNumber.text
            ..fields['password'] = password.text
            ..fields['work_experience'] = selectedWorkExperience.value
            ..fields['profesional_identification_number'] =
                professionalIdentificationNumber.text
            ..fields['degree'] = degree.text
            ..fields['graduation_year'] = graduationYear.text
            ..fields['major'] = major.text
            ..fields['university'] = university.text;

          language.selectedItems.forEach((lang) {
            // Mengambil value dari DropdownItem
            request.fields.addAll({'language[]': lang.value});
          });

          specialization.selectedItems.forEach((spec) {
            request.fields.addAll({'specialization[]': spec.value});
          });

          // Menambahkan file jika ada
          if (practiceLicenceFile.value != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'practice_license[]',
                practiceLicenceFile.value!.path,
              ),
            );
          }
          if (curricullumVitaeFile.value != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'cv[]',
                curricullumVitaeFile.value!.path,
              ),
            );
          }
          if (additionalCertificationsFile.value != null) {
            request.files.add(
              await http.MultipartFile.fromPath(
                'certification[]',
                additionalCertificationsFile.value!.path,
              ),
            );
          }

          var response = await request.send();

          if (response.statusCode == 201) {
            var responseBody = await response.stream.bytesToString();
            var responseData = jsonDecode(responseBody);

            ToastHelper.show(
              message: responseData['message'],
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Get.offAllNamed(Routes.SIGNIN);
          } else {
            var responseBody = await response.stream.bytesToString();
            var responseData = jsonDecode(responseBody);

            ToastHelper.show(
              message: responseData['message'],
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } catch (e) {
          // Menangani error jika ada masalah pada request
          Get.snackbar("Error", "An error occurred: ${e.toString()}");
        }
      }
    }
  }

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void changeShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void updateSpecializations(List<String> selectedItems) {
    selectedSpecializations.value = selectedItems;
  }

  void uploadFilePracticeLicense() async {
    await _uploadFile(
      'practiceLicenceFile',
      practiceLicenceFile,
      practiceLicenceFileName,
    );
  }

  void uploadFileCV() async {
    await _uploadFile(
      'curricullumVitaeFile',
      curricullumVitaeFile,
      curricullumVitaeFileName,
    );
  }

  void uploadFileSertificate() async {
    await _uploadFile(
      'additionalCertificationsFile',
      additionalCertificationsFile,
      additionalCertificationsFileName,
    );
  }

  Future<void> _uploadFile(
      String fieldName, Rxn<File> fileRx, RxString fileNameRx) async {
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
      if (file.size > 10485760) {
        // 10MB
        Get.snackbar(
            "Error", "File terlalu besar. Maksimal ukuran file adalah 10MB.");
        return;
      }
      fileRx.value = File(file.path!);
      fileNameRx.value = file.name;
    } else {
      Get.snackbar("Error", "Gagal memilih file");
    }
  }
}
