import 'package:get/get.dart';

class Psychologist {
  final String name;
  final String specialty;
  final String gender;
  final String experience;
  final String status;

  Psychologist({
    required this.name,
    required this.specialty,
    required this.gender,
    required this.experience,
    required this.status,
  });
}

class PsychologController extends GetxController {
  RxList<Psychologist> psychologists = <Psychologist>[
    Psychologist(
      name: 'David Williams',
      specialty: 'Anxiety Disorders',
      gender: 'Male',
      experience: '7 years',
      status: 'Available',
    ),
    Psychologist(
      name: 'John Anderson',
      specialty: 'Clinical Psychology',
      gender: 'Male',
      experience: '4 years',
      status: 'Full Booked',
    ),
    Psychologist(
      name: 'James Mitchel',
      specialty: 'Child Psychology',
      gender: 'Female',
      experience: '3 years',
      status: 'Available',
    ),
  ].obs;

  RxList<Psychologist> filteredPsychologists = RxList<Psychologist>();

  @override
  void onInit() {
    super.onInit();
    filteredPsychologists.value = psychologists;
  }

  void filterPsychologists({
    String? name,
    String? gender,
    String? status,
  }) {
    filteredPsychologists.value = psychologists.where((psychologist) {
      return (name == null || psychologist.name.toLowerCase().contains(name.toLowerCase())) &&
          (gender == null || psychologist.gender.toLowerCase() == gender.toLowerCase()) &&
          (status == null || psychologist.status.toLowerCase() == status.toLowerCase());
    }).toList();
  }

  void goToDetails(Psychologist psychologist) {

  }
}
