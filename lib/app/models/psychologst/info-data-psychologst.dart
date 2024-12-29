import 'package:consulin_mobile_dev/app/models/user.dart';

class ConsultationDataPsychologist {
  List<Appointment> consultations;
  int totalWeeklyConsultation;
  int totalConsultation;
  int todayOngoingConsultation;

  ConsultationDataPsychologist({
    required this.consultations,
    required this.totalWeeklyConsultation,
    required this.totalConsultation,
    required this.todayOngoingConsultation,
  });

  factory ConsultationDataPsychologist.fromJson(Map<String, dynamic> json) {
    return ConsultationDataPsychologist(
      consultations: (json['consultations'] as List)
          .map((i) => Appointment.fromJson(i))
          .toList(),
      totalWeeklyConsultation: json['total_weekly_consultation'],
      totalConsultation: json['total_consultation'],
      todayOngoingConsultation: json['today_ongoing_consultation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consultations': consultations.map((i) => i.toJson()).toList(),
      'total_weekly_consultation': totalWeeklyConsultation,
      'total_consultation': totalConsultation,
      'today_ongoing_consultation': todayOngoingConsultation,
    };
  }
}

class Appointment {
  int id;
  String? channelId;
  String date;
  String? startTime;
  String? endTime;
  String? duration;
  String status;
  String? note;
  User user;
  String? aiAnalyzer; // Optional field for AI Analyzer

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
    this.aiAnalyzer, // Include aiAnalyzer in the constructor
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    // Check if the user field is null
    if (json['user'] == null) {
      throw Exception('User data is missing in the appointment details');
    }

    return Appointment(
      id: json['id'],
      channelId: json['channel_id'] != null && json['channel_id'] != 'undefined'
          ? json['channel_id']
          : null, // Handle undefined case
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      duration: json['duration'],
      status: json['status'],
      note: json['note'],
      user: User.fromJson(json['user']), // This will throw if user is null
      aiAnalyzer: json['ai_analyzer'], // Optional field, can be null
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
      'ai_analyzer': aiAnalyzer, // Include aiAnalyzer in the JSON output
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
