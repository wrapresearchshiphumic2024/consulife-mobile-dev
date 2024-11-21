import 'package:get/get.dart';

class PickRoleController extends GetxController {

  var selectedRole = ''.obs;


  void selectRole(String role) {
    selectedRole.value = role;

  }
}
