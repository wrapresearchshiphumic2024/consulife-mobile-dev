import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';

class PsikologProDetController extends GetxController {
  final TextEditingController universityController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();

  var specialization = ''.obs;
  var graduationYear = ''.obs;
  var languageMaster = ''.obs;

  final List<String> specializationOptions = [
    "Educational Psychology",
    "Clinical Psychology",
    "Developmental Psychology",
    "General Psychology"
  ];

  final List<String> graduationYearOptions = List<String>.generate(
    30,
        (index) => (DateTime.now().year - index).toString(),
  );

  final List<String> languageOptions = ["English", "Indonesian"];

  var isFormChanged = false.obs;

  @override
  void onInit() {
    super.onInit();
    universityController.addListener(_onFormChanged);
    degreeController.addListener(_onFormChanged);

    specialization.value = specializationOptions.isNotEmpty ? specializationOptions.first : '';
    graduationYear.value = graduationYearOptions.isNotEmpty ? graduationYearOptions.first : '';
    languageMaster.value = languageOptions.isNotEmpty ? languageOptions.first : '';
  }

  @override
  void onClose() {
    universityController.dispose();
    degreeController.dispose();
    super.onClose();
  }

  void _onFormChanged() {
    isFormChanged.value = true;
  }

  void showToast(String message, {Color backgroundColor = Colors.green}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  bool validateForm() {
    if (universityController.text.isEmpty) {
      showToast("University cannot be empty", backgroundColor: Colors.red);
      return false;
    }
    if (degreeController.text.isEmpty) {
      showToast("Degree cannot be empty", backgroundColor: Colors.red);
      return false;
    }
    return true;
  }

  void saveChanges() {
    if (!validateForm()) return;
    isFormChanged.value = false;
    showToast("Changes saved");
  }

  void cancel(BuildContext context) {
    if (isFormChanged.value) {

      Get.dialog(
        AlertDialog(
          title: const Text('Discard Changes?',textAlign: TextAlign.center,style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          )),
          content: const Text(
            'You have unsaved changes. Are you sure you want to cancel the update? This action cannot be undone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,

            ),

          ),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    isFormChanged.value = false;
                    Navigator.pop(context);


                    Fluttertoast.showToast(
                      msg: "Changes discarded",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Yes, Discard',style: TextStyle(
                    color: Colors.white,
                  )),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Return',style: TextStyle(
                    color: primaryColor,
                  )),
                ),
              ],
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }
}
