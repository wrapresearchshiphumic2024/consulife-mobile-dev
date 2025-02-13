import 'dart:convert';
import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/models/user.dart';
import 'package:consulin_mobile_dev/app/utils/api/http_service.dart';

class PsychologstService {
  // Method to fetch psychologist profile
  Future<User> getPsychologistProfile() async {
    final response =
        await HttpService.getRequest('/profile', includeBearer: true);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch psychologist profile');
    }

    final json = jsonDecode(response.body);
    print(json['data']);
    return User.fromJson(json['data']);
  }

  Future<ConsultationDataPsychologist> getConsultationDataPsychologist() async {
    final response = await HttpService.getRequest('/psychologist/analitics',
        includeBearer: true);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch dashboard data');
    }

    final json = jsonDecode(response.body);
    print(json['data']);
    // Mengonversi data JSON ke dalam format yang diinginkan
    return ConsultationDataPsychologist(
      consultations: (json['data']['consultations'] as List)
          .map((consultation) => Appointment(
                id: consultation['appointment_id'],
                date: consultation['date'],
                startTime: consultation['start_time'],
                endTime: consultation['end_time'],
                status: consultation['status'],
                user: User(
                  id: consultation['id'],
                  firstname: consultation['firstname'],
                  lastname: consultation['lastname'],
                ),
              ))
          .toList(),
      totalWeeklyConsultation: json['data']['total_weekly_consultation'],
      totalConsultation: json['data']['total_consultation'],
      todayOngoingConsultation: json['data']['today_ongoing_consultation'],
    );
  }

  Future<Schedule> getSchedule() async {
    final response = await HttpService.getRequest('/psychologist/schedule',
        includeBearer: true);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch schedule data');
    }

    final json = jsonDecode(response.body);
    return Schedule.fromJson(json['data']);
  }

  Future<Map<String, String>> openAppointment() async {
    final response = await HttpService.postRequest(
        '/psychologist/schedule/open',
        includeBearer: true);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String status = responseData['status'];
      return {'success': status};
    } else {
      throw Exception('Failed to open appointment: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, String>> closeAppointment() async {
    final response = await HttpService.postRequest(
        '/psychologist/schedule/close',
        includeBearer: true);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String status = responseData['status'];
      return {'success': status};
    } else {
      throw Exception('Failed to close appointment: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> editSchedule(Map<String, dynamic> data) async {
    final response = await HttpService.putRequest(
      '/psychologist/schedule/update',
      body: data,
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      final errorResponse = jsonDecode(response.body);
      throw Exception(
          'Failed to update schedule: ${errorResponse['message'] ?? response.reasonPhrase}');
    }

    final responseData = jsonDecode(response.body);
    return {'success': responseData['status']};
  }

  // New method to fetch appointment history
  Future<List<Appointment>> getAppointmentHistory() async {
    final response = await HttpService.getRequest(
      '/psychologist/appointment-history',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch appointment history');
    }

    final json = jsonDecode(response.body);

    // Check if data is present and is a list
    if (json['data'] == null || (json['data'] as List).isEmpty) {
      return []; // Return an empty list if no data
    }
    print(json['data']);
    // Map the JSON data to a list of Appointment objects
    List<Appointment> appointments = (json['data'] as List).map((item) {
      return Appointment(
        id: item['id'],
        date: item['date'],
        startTime: item['start_time'],
        endTime: item['end_time'],
        status: item['status'],
        user: User(
          id: item['patient']['user_id'],
          firstname: item['patient']['firstname'],
          lastname: item['patient']['lastname'],
        ),
      );
    }).toList();

    return appointments;
  }

  Future<Appointment> getAppointmentDetailPsychologst(String uuid) async {
    final response = await HttpService.getRequest(
      '/psychologist/appointment/detail/$uuid',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch appointment details');
    }

    final json = jsonDecode(response.body);
    final item = json['data'];
    print(item);
    // Manually constructing the Appointment object
    // Parsing manual jika struktur berbeda
    final user = User(
      id: item['patient_id'].toString(),
      firstname: item['firstname'],
      lastname: item['lastname'],
      phoneNumber: item['phone'],
      email: item['email'],
      gender: item['gender'],
    );

    final aiAnalyzer = item['ai_analyzer'] != null
        ? AiAnalyzer.fromJson(item['ai_analyzer'])
        : null;

    return Appointment(
      id: item['id'],
      channelId: item['channel_id'],
      date: item['date'],
      startTime: item['start_time'],
      endTime: item['end_time'],
      duration: item['duration'],
      status: item['status'],
      note: item['note'],
      user: user,
      aiAnalyzer: aiAnalyzer,
    );
  }

  Future<List<AiAnalyzer>?> getAiAnalysisHistory(String uuid) async {
    final response = await HttpService.getRequest(
      '/psychologist/patients/$uuid/ai-analysis',
      includeBearer: true,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch AI analysis history');
    }

    final json = jsonDecode(response.body);
    print(json['data']);

    // Pastikan json['data'] adalah objek yang berisi kunci 'analysis' sebagai list
    if (json['data'] == null || json['data']['analysis'] == null) {
      return null; // Return null if no analysis data found
    }

    // Periksa apakah 'analysis' adalah List dan lakukan mapping
    List<AiAnalyzer> analyzers = (json['data']['analysis'] as List).map((item) {
      return AiAnalyzer.fromJson(item);
    }).toList();

    return analyzers;
  }

  Future<void> doneAppointment(String appointmentId) async {
    try {
      final response = await HttpService.postRequest(
        '/psychologist/appointment-done/$appointmentId}',
        includeBearer: true,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw responseData['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelAppointment(String appointmentId, String note) async {
    try {
      // Perbaikan endpoint URL (menghapus kurung kurawal ekstra di akhir)
      final response = await HttpService.postRequest(
        '/psychologist/appointment-cancel/$appointmentId',
        body: {'note': note},
        includeBearer: true,
      );

      // Memastikan respons dapat diproses dengan benar
      if (response.statusCode != 200) {
        final responseData = jsonDecode(response.body);
        final errorMessage =
            responseData['message'] ?? 'Unknown error occurred';
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Melempar ulang error untuk ditangani di tingkat yang lebih tinggi
      rethrow;
    }
  }
}
