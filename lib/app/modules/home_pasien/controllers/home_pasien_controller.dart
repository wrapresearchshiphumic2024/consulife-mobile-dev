import 'package:get/get.dart';

class HomePasienController extends GetxController {
  var probabilityOfStress = 65.0.obs;
  var probabilityOfAnxiety = 40.0.obs;
  var probabilityOfDepression = 70.0.obs;

  final List<Map<String, dynamic>> ShowAppointment = [
    {
      "status": "Ongoing",
      "name": "John Rodrigo",
      "time": "12 Oct 2024, 10:00",
      "details": "General health checkup scheduled."
    },
    // {
    //   "status": "Canceled",
    //   "name": "Jane Doe",
    //   "time": "13 Oct 2024, 14:00",
    //   "details": "Appointment canceled due to personal reasons."
    // },
  ];

  final List<Map<String, dynamic>> upcomingAppointment = [
    {"status": "Ongoing", "name": "John Rodrigo", "time": "12 Oct 2024, 10:00"},
    {"status": "Waiting", "name": "Jane Doe", "time": "13 Oct 2024, 14:00"},
    {"status": "Waiting", "name": "Sarah Smith", "time": "14 Oct 2024, 15:00"},
  ];

  final List<Map<String, dynamic>> historyAppointment = [
    {
      "status": "Canceled",
      "name": "John Rodrigo",
      "time": "12 Oct 2024, 10:00"
    },
    {"status": "Completed", "name": "Jane Doe", "time": "13 Oct 2024, 14:00"},
    {"status": "Canceled", "name": "Sarah Smith", "time": "14 Oct 2024, 15:00"},
  ];

  void updateProbabilities(double stress, double anxiety, double depression) {
    probabilityOfStress.value = stress;
    probabilityOfAnxiety.value = anxiety;
    probabilityOfDepression.value = depression;
  }

  Map<String, double> getPieChartData() {
    return {
      "Probability of Stress": probabilityOfStress.value,
      "Probability of Anxiety": probabilityOfAnxiety.value,
      "Probability of Depression": probabilityOfDepression.value,
    };
  }


  Future<void> fetchProbabilitiesFromAPI() async {
    await Future.delayed(const Duration(seconds: 1));
    updateProbabilities(70.0, 45.0, 60.0);
  }

  @override
  void onInit() {
    super.onInit();
    fetchProbabilitiesFromAPI();
  }
}
