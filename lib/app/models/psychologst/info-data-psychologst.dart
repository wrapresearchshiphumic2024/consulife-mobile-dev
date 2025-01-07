import 'package:consulin_mobile_dev/app/models/user.dart';

class ConsultationDataPsychologist {
  List<Appointment> consultations;
  int totalWeeklyConsultation;
  int totalConsultation;
  int todayOngoingConsultation;
  Map<String, double>? monthlyPatientCount;

  ConsultationDataPsychologist({
    required this.consultations,
    required this.totalWeeklyConsultation,
    required this.totalConsultation,
    required this.todayOngoingConsultation,
    this.monthlyPatientCount,
  });

  factory ConsultationDataPsychologist.fromJson(Map<String, dynamic> json) {
    return ConsultationDataPsychologist(
      consultations: (json['consultations'] as List)
          .map((i) => Appointment.fromJson(i))
          .toList(),
      totalWeeklyConsultation: json['total_weekly_consultation'],
      totalConsultation: json['total_consultation'],
      todayOngoingConsultation: json['today_ongoing_consultation'],
      monthlyPatientCount: json['monthly_patient_count'] != null
          ? {
              'January':
                  (json['monthly_patient_count']['January'] as num).toDouble(),
              'February':
                  (json['monthly_patient_count']['February'] as num).toDouble(),
              'March':
                  (json['monthly_patient_count']['March'] as num).toDouble(),
              'April':
                  (json['monthly_patient_count']['April'] as num).toDouble(),
              'May': (json['monthly_patient_count']['May'] as num).toDouble(),
              'June': (json['monthly_patient_count']['June'] as num).toDouble(),
              'July': (json['monthly_patient_count']['July'] as num).toDouble(),
              'August':
                  (json['monthly_patient_count']['August'] as num).toDouble(),
              'September': (json['monthly_patient_count']['September'] as num)
                  .toDouble(),
              'October':
                  (json['monthly_patient_count']['October'] as num).toDouble(),
              'November':
                  (json['monthly_patient_count']['November'] as num).toDouble(),
              'December':
                  (json['monthly_patient_count']['December'] as num).toDouble(),
            }
          : null, // If monthly_patient_count doesn't exist, leave it null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consultations': consultations.map((i) => i.toJson()).toList(),
      'total_weekly_consultation': totalWeeklyConsultation,
      'total_consultation': totalConsultation,
      'today_ongoing_consultation': todayOngoingConsultation,
      if (monthlyPatientCount != null)
        'monthly_patient_count': monthlyPatientCount,
    };
  }
}

class Appointment {
  final int id;
  final String? channelId;
  final String date;
  final String? startTime;
  final String? endTime;
  final String? duration;
  final String status;
  final String? note;
  final User user;
  final AiAnalyzer? aiAnalyzer;

  Appointment({
    required this.id,
    this.channelId,
    required this.date,
    this.startTime,
    this.endTime,
    this.duration,
    required this.status,
    this.note,
    required this.user,
    this.aiAnalyzer,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      channelId: json['channel_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      duration: json['duration'],
      status: json['status'],
      note: json['note'],
      user: User.fromJson(json['user']),
      aiAnalyzer: json['ai_analyzer'] != null
          ? AiAnalyzer.fromJson(json['ai_analyzer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channel_id': channelId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'duration': duration,
      'status': status,
      'note': note,
      'user': user.toJson(),
      'ai_analyzer': aiAnalyzer?.toJson(),
    };
  }
}

class AiAnalyzer {
  final int? id; // Optional field
  final String complaint;
  final double stress;
  final double anxiety;
  final double depression;
  final String createdAt;
  final String? updatedAt; // Optional field
  final int? patientId; // Optional field

  AiAnalyzer({
    this.id,
    required this.complaint,
    required this.stress,
    required this.anxiety,
    required this.depression,
    required this.createdAt,
    this.updatedAt,
    this.patientId,
  });

  // Factory constructor to create an AiAnalyzer instance from JSON
  factory AiAnalyzer.fromJson(Map<String, dynamic> json) {
    return AiAnalyzer(
      id: json['id'], // Optional
      complaint: json['complaint'],
      stress: (json['stress'] as num).toDouble(),
      anxiety: (json['anxiety'] as num).toDouble(),
      depression: (json['depression'] as num).toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'], // Optional
      patientId: json['patient_id'], // Optional
    );
  }

  // Method to convert AiAnalyzer instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Optional
      'complaint': complaint,
      'stress': stress,
      'anxiety': anxiety,
      'depression': depression,
      'created_at': createdAt,
      'updated_at': updatedAt, // Optional
      'patient_id': patientId, // Optional
    };
  }
}

class Schedule {
  int id;
  int psychologistId;
  String status;
  List<Day> days;

  Schedule({
    required this.id,
    required this.psychologistId,
    required this.status,
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      psychologistId: json['psychologist_id'],
      status: json['status'],
      days: (json['days'] as List).map((i) => Day.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'psychologist_id': psychologistId,
      'status': status,
      'days': days.map((i) => i.toJson()).toList(),
    };
  }
}

class Day {
  int id;
  int scheduleId;
  String day;

  List<Time> times;

  Day({
    required this.id,
    required this.scheduleId,
    required this.day,
    required this.times,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'],
      scheduleId: json['schedule_id'],
      day: json['day'],
      times: (json['times'] as List).map((i) => Time.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schedule_id': scheduleId,
      'day': day,
      'times': times.map((i) => i.toJson()).toList(),
    };
  }
}

class Time {
  int id;
  int dayId;
  String start;
  String end;

  Time({
    required this.id,
    required this.dayId,
    required this.start,
    required this.end,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      id: json['id'],
      dayId: json['day_id'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day_id': dayId,
      'start': start,
      'end': end,
    };
  }
}
