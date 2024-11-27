import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:consulin_mobile_dev/app/constants/color.dart';
class PsikologPerInfoController extends GetxController {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController licenceNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  var showPassword = false.obs;

  var isFormChanged = false.obs;

  @override
  void onInit() {
    super.onInit();


    usernameController.addListener(_onFormChanged);
    licenceNumberController.addListener(_onFormChanged);
    genderController.addListener(_onFormChanged);
    phoneNumberController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    passwordController.addListener(_onFormChanged);
  }

  @override
  void onClose() {

    usernameController.removeListener(_onFormChanged);
    licenceNumberController.removeListener(_onFormChanged);
    genderController.removeListener(_onFormChanged);
    phoneNumberController.removeListener(_onFormChanged);
    emailController.removeListener(_onFormChanged);
    passwordController.removeListener(_onFormChanged);

    super.onClose();
  }


  void _onFormChanged() {
    isFormChanged.value = true;
  }


  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }


  void saveChanges() {
    isFormChanged.value = false;


    Fluttertoast.showToast(
      msg: "Changes saved",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
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
