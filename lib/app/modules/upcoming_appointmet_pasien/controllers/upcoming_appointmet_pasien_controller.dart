import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Consultation {
  final String status;
  final String name;
  final DateTime dateTime;

  Consultation({
    required this.status,
    required this.name,
    required this.dateTime,
  });

  String get formattedDateWithTime {

    final dateTimeInWIB = dateTime.toUtc().add(Duration(hours: 7));
    return DateFormat('dd MMM yyyy HH:mm').format(dateTimeInWIB);
  }
}

class UpcomingAppointmetPasienController extends GetxController {

  var upcomingAppointments = <Consultation>[
    Consultation(
      status: 'Ongoing Consultation',
      name: 'John Doe',
      dateTime: DateTime.now().subtract(Duration(hours: 5)),
    ),
    Consultation(
      status: 'Waiting Consultation',
      name: 'Jane Smith',
      dateTime: DateTime.now().add(Duration(hours: 2)),
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }
}

