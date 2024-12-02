import 'package:get/get.dart';

import '../controllers/personal_information_pasien_controller.dart';

class PersonalInformationPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInformationPasienController>(
      () => PersonalInformationPasienController(),
    );
  }
}
