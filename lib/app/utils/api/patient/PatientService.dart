import 'dart:convert';
import 'package:consulin_mobile_dev/app/models/patient/info-patient.dart';
import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/models/user.dart';

import 'package:consulin_mobile_dev/app/utils/api/http_service.dart';

class PatientService {
  Future<User> getPatientProfile() async {
    final response =
        await HttpService.getRequest('/profile', includeBearer: true);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch psychologist profile');
    }

    final json = jsonDecode(response.body);

    return User.fromJson(json['data']);
  }

  Future<AppointmentPatient> getAppointmentPatient() async {
    final response = await HttpService.getRequest(
      '/patients/appointments',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch appointment data');
    }

    final json = jsonDecode(response.body);
    final appointmentsResponse = json['data'];

    // Mengonversi data janji temu
    final upcomingAppointments =
        (appointmentsResponse['upcoming_appointments'] as List)
            .map((item) => Appointment(
                  id: item['id'],
                  channelId: item['channel_id'],
                  date: item['date'],
                  startTime: item['start_time'],
                  endTime: item['end_time'],
                  status: item['status'],
                  user: User(
                    id: item['psychologist']['user_id'],
                    firstname: item['psychologist']['firstname'],
                    lastname: item['psychologist']['lastname'],
                  ),
                ))
            .toList();

    final history = (appointmentsResponse['history'] as List)
        .map((item) => Appointment(
              id: item['id'],
              channelId: item['channel_id'],
              date: item['date'],
              startTime: item['start_time'],
              endTime: item['end_time'],
              status: item['status'],
              user: User(
                id: item['psychologist']['user_id'],
                firstname: item['psychologist']['firstname'],
                lastname: item['psychologist']['lastname'],
              ),
            ))
        .toList();

    return AppointmentPatient(
      upcomingAppointments: upcomingAppointments,
      history: history,
    );
  }

  Future<Appointment> getAppointmentDetailPatient(String uuid) async {
    final response = await HttpService.getRequest(
      '/patients/appointments/$uuid/detail',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch appointment detail');
    }

    final json = jsonDecode(response.body);
    final item = json['data'];

    final detailAppointment = Appointment(
      id: item['id'],
      channelId: item['channel_id'],
      date: item['date'],
      startTime: item['start_time'],
      endTime: item['end_time'],
      duration: item['duration'],
      status: item['status'],
      note: item['note'],
      user: User(
        id: item['psychologist']['user_id'],
        firstname: item['psychologist']['firstname'],
        lastname: item['psychologist']['lastname'],
        email: item['psychologist']['email'],
        gender: item['psychologist']['gender'],
        psychologist: Psychologist(
          workExperience: item['psychologist']['work_experience'],
          specialization: List<String>.from(
              jsonDecode(item['psychologist']['specialization'])),
        ),
      ),
    );

    return detailAppointment;
  }

  Future<PsychologistDataResponse> getPsychologistData({
    String name = "",
    String gender = "",
  }) async {
    const String apiUrl = '/patients/psychologists-list';

    // Menyusun URL dengan parameter query
    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
      if (name.isNotEmpty) 'name': name,
      if (gender.isNotEmpty) 'gender': gender,
    });

    // Menggunakan HttpService untuk melakukan GET request
    final response = await HttpService.getRequest(
      uri.toString(),
      includeBearer: true,
    );

    final json = jsonDecode(response.body);

    // Memeriksa apakah patientHasAIAnalysis tersedia di respons JSON
    final bool patientHasAIAnalysis = json['patient_has_aianalysis'] ?? false;

    // Mapping data psychologist jika ada
    final List<User> psychologists =
        (json['data'] as List<dynamic>?)?.map((item) {
              return User(
                id: item['user_id'],
                firstname: item['firstname'],
                lastname: item['lastname'],
                gender: item['gender'],
                profilePicture: item['profile_picture'],
                psychologist: Psychologist(
                  id: item['id'],
                  userId: item['user_id'],
                  degree: item['degree'],
                  specialization: item['specialization'] != null
                      ? List<String>.from(jsonDecode(item['specialization']))
                      : [],
                  workExperience: item['work_experience'],
                  profesionalIdentificationNumber:
                      item['profesional_identification_number'],
                ),
              );
            }).toList() ??
            [];

    return PsychologistDataResponse(
      patientHasAIAnalysis: patientHasAIAnalysis,
      psychologists: psychologists,
    );
  }

  Future<User> getDetailPsychologistPatient(String uuid) async {
    final response = await HttpService.getRequest(
      '/patients/psychologists/$uuid',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch psychologist data');
    }

    final json = jsonDecode(response.body);

    final item = json['data'];
    print(item);

    // Mapping data untuk user dan psikolog
    final psychologist = User(
      id: item['user_id'] ?? item['id'],
      firstname: item['user']['firstname'],
      lastname: item['user']['lastname'],
      email: item['user']['email'],
      phoneNumber: item['user']['phone_number'],
      isVerified: item['is_verified'] == 1,
      isRejected: item['is_rejected'] == 1,
      gender: item['user']['gender'],
      profilePicture: item['user']['profile_picture'],
      psychologist: Psychologist.fromJson({
        'id': item['id'],
        'user_id': item['user_id'],
        'degree': item['degree'],
        'major': item['major'],
        'university': item['university'],
        'graduation_year': item['graduation_year'],
        'language': jsonDecode(item['language']),
        'certification': jsonDecode(item['certification']),
        'specialization': jsonDecode(item['specialization']),
        'work_experience': item['work_experience'],
        'profesional_identification_number':
            item['profesional_identification_number'],
        'cv': item['cv'] != null ? jsonDecode(item['cv']) : [],
        'practice_license': item['practice_license'] != null
            ? jsonDecode(item['practice_license'])
            : [],
        'schedule': item['schedule'],
        'upcoming_schedules': json['upcoming_schedules'] ?? [],
      }),
    );

    return psychologist;
  }

  // Fungsi untuk menambahkan janji temu
  Future<Map<String, String>> addAppointment(
      String psychologistId, Map<String, String> data) async {
    try {
      // Menyiapkan endpoint untuk request
      final endpoint = '/patients/psychologists/$psychologistId/book';

      // Mengirimkan POST request menggunakan HttpService
      final response = await HttpService.postRequest(
        endpoint,
        body: data,
        includeBearer: true, // Include Bearer token
      );

      // Memeriksa status code response
      final responseData = jsonDecode(response.body);

      // Jika status sukses
      if (responseData['status'] == 'success') {
        // Jika perlu, lakukan revalidation atau tindakan lainnya

        return {
          'status': 'success',
          'message': 'Appointment successfully scheduled',
        };
      } else {
        return {
          'status': 'error',
          'message': responseData['message'] ?? 'Failed to add appointment.',
        };
      }
    } catch (error) {
      return {
        'status': 'error',
        'message': 'An error occurred while scheduling the appointment.',
      };
    }
  }

  // Method to fetch AI analysis history
  Future<List<AiAnalyzer>?> getHistoryAiAnalyzer() async {
    final response = await HttpService.getRequest(
      '/patients/ai-analysis-history', // API endpoint
      includeBearer: true, // Include Bearer token in the request
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch AI analysis history');
    }

    final json = jsonDecode(response.body);

    if (json['data'] == null || (json['data'] as List).isEmpty) {
      return null;
    }

    // Mapping data from JSON to a list of AiAnalyzer objects
    List<AiAnalyzer> analyzers = (json['data'] as List).map((item) {
      return AiAnalyzer(
        id: item['id'],
        complaint: item['complaint'],
        stress: item['stress'],
        anxiety: item['anxiety'],
        depression: item['depression'],
        createdAt: item['created_at'],
        updatedAt: item['updated_at'],
        patientId: item['patient_id'],
      );
    }).toList();

    return analyzers;
  }
}
