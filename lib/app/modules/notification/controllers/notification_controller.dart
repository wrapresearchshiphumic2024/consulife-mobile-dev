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

class NotificationController extends GetxController {
  var todayConsultations = <Consultation>[
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

  var yesterdayConsultations = <Consultation>[
    Consultation(
      status: 'Canceled Consultation',
      name: 'Sam Wilson',
      dateTime: DateTime.now().subtract(Duration(days: 1, hours: 3)),
    ),
  ].obs;

  var past30DaysConsultations = <Consultation>[
    Consultation(
      status: 'Waiting Consultation',
      name: 'Alice Cooper',
      dateTime: DateTime.now().subtract(Duration(days: 7, hours: 9)),
    ),
    Consultation(
      status: 'Canceled Consultation',
      name: 'Bob Marley',
      dateTime: DateTime.now().subtract(Duration(days: 21, hours: 11)),
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }
}
