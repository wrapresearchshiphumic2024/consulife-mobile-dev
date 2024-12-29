import 'package:consulin_mobile_dev/app/models/patient/info-patient.dart';
import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';

class User {
  String id;
  String firstname;
  String lastname;
  String? email;
  String? phoneNumber;
  bool? isVerified;
  bool? isRejected;
  String? gender;
  String? profilePicture;
  Psychologist? psychologist;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.isRejected,
    this.gender,
    this.profilePicture,
    this.psychologist,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'] ?? json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      isVerified: json['is_verified'] == 1, // Convert to bool if necessary
      isRejected: json['is_rejected'] == 1,
      gender: json['gender'],
      profilePicture: json['profile_picture'],
      psychologist: json['psychologist'] != null
          ? Psychologist.fromJson(json['psychologist'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id, // Ensure this matches the JSON key
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone_number': phoneNumber,
      'is_verified': isVerified == true ? 1 : 0, // Convert to int if necessary
      'is_rejected': isRejected,
      'gender': gender,
      'profile_picture': profilePicture,
      'psychologist': psychologist?.toJson(),
    };
  }
}

class Psychologist {
  int? id;
  String? userId;
  String? degree;
  String? major;
  String? university;
  String? graduationYear;
  List<String>? language;
  List<String>? certification;
  List<String>? specialization;
  String? workExperience; // Ensure this is nullable
  String? profesionalIdentificationNumber;
  List<String>? cv;
  List<String>? practiceLicense;
  Schedule? schedule;
  List<UpcomingSchedule>? upcomingSchedules;

  Psychologist({
    this.id,
    this.userId,
    this.degree,
    this.major,
    this.university,
    this.graduationYear,
    this.language,
    this.certification,
    this.specialization,
    this.workExperience,
    this.profesionalIdentificationNumber,
    this.cv,
    this.practiceLicense,
    this.schedule,
    this.upcomingSchedules,
  });

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist(
      id: json['id'],
      userId: json['user_id'],
      degree: json['degree'],
      major: json['major'],
      university: json['university'],
      graduationYear: json['graduation_year'],
      language:
          json['language'] != null ? List<String>.from(json['language']) : null,
      certification: json['certification'] != null
          ? List<String>.from(json['certification'])
          : null,
      specialization: json['specialization'] != null
          ? List<String>.from(json['specialization'])
          : null,
      workExperience: json['work_experience'], // Ensure this is nullable
      profesionalIdentificationNumber:
          json['profesional_identification_number'],
      cv: json['cv'] != null ? List<String>.from(json['cv']) : null,
      practiceLicense: json['practice_license'] != null
          ? List<String>.from(json['practice_license'])
          : null,
      schedule:
          json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
      upcomingSchedules: json['upcoming_schedules'] != null
          ? (json['upcoming_schedules'] as List)
              .map((i) => UpcomingSchedule.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'degree': degree,
      'major': major,
      'university': university,
      'graduation_year': graduationYear,
      'language': language,
      'certification': certification,
      'specialization': specialization,
      'work_experience': workExperience,
      'profesional_identification_number': profesionalIdentificationNumber,
      'cv': cv,
      'practice_license': practiceLicense,
      'schedule': schedule?.toJson(),
      'upcoming_schedules': upcomingSchedules?.map((i) => i.toJson()).toList(),
    };
  }
}
