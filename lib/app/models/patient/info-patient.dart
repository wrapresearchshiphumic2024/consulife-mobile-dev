import 'package:consulin_mobile_dev/app/models/psychologst/info-data-psychologst.dart';
import 'package:consulin_mobile_dev/app/models/user.dart';

class UpcomingSchedule {
  String date;
  List<ScheduleTime> times;

  UpcomingSchedule({
    required this.date,
    required this.times,
  });

  factory UpcomingSchedule.fromJson(Map<String, dynamic> json) {
    return UpcomingSchedule(
      date: json['date'],
      times:
          (json['times'] as List).map((i) => ScheduleTime.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'times': times.map((i) => i.toJson()).toList(),
    };
  }
}

class ScheduleTime {
  String start;
  String end;

  ScheduleTime({
    required this.start,
    required this.end,
  });

  factory ScheduleTime.fromJson(Map<String, dynamic> json) {
    return ScheduleTime(
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}

class AppointmentPatient {
  List<Appointment> upcomingAppointments;
  List<Appointment> history;

  AppointmentPatient({
    required this.upcomingAppointments,
    required this.history,
  });

  factory AppointmentPatient.fromJson(Map<String, dynamic> json) {
    return AppointmentPatient(
      upcomingAppointments: (json['upcoming_appointments'] as List)
          .map((i) => Appointment.fromJson(i))
          .toList(),
      history: (json['history'] as List)
          .map((i) => Appointment.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'upcoming_appointments':
          upcomingAppointments.map((i) => i.toJson()).toList(),
      'history': history.map((i) => i.toJson()).toList(),
    };
  }
}

class PsychologistDataResponse {
  final bool patientHasAIAnalysis;
  final List<User> psychologists;

  PsychologistDataResponse({
    required this.patientHasAIAnalysis,
    required this.psychologists,
  });
}
