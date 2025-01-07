import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/modules/home_psycholog/controllers/home_psycholog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatelessWidget {
  const ColumnChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari controller
    var consultationData =
        Get.find<HomePsychologController>().consultationDataPsychologst.value;

    // Membuat data untuk chart berdasarkan monthlyPatientCount dari controller
    List<_ConsultationData> data = [
      _ConsultationData(
          'Jan', consultationData.monthlyPatientCount?['January'] ?? 0),
      _ConsultationData(
          'Feb', consultationData.monthlyPatientCount?['February'] ?? 0),
      _ConsultationData(
          'Mar', consultationData.monthlyPatientCount?['March'] ?? 0),
      _ConsultationData(
          'Apr', consultationData.monthlyPatientCount?['April'] ?? 0),
      _ConsultationData(
          'May', consultationData.monthlyPatientCount?['May'] ?? 0),
      _ConsultationData(
          'Jun', consultationData.monthlyPatientCount?['June'] ?? 0),
      _ConsultationData(
          'Jul', consultationData.monthlyPatientCount?['July'] ?? 0),
      _ConsultationData(
          'Aug', consultationData.monthlyPatientCount?['August'] ?? 0),
      _ConsultationData(
          'Sep', consultationData.monthlyPatientCount?['September'] ?? 0),
      _ConsultationData(
          'Oct', consultationData.monthlyPatientCount?['October'] ?? 0),
      _ConsultationData(
          'Nov', consultationData.monthlyPatientCount?['November'] ?? 0),
      _ConsultationData(
          'Dec', consultationData.monthlyPatientCount?['December'] ?? 0),
    ];

    return Column(
      children: [
        // Inisialisasi widget chart
        SfCartesianChart(
          backgroundColor: Colors.transparent, // Menghapus background chart
          borderColor: Colors.transparent, // Menghapus border chart
          borderWidth: 0, // Set borderWidth ke 0
          primaryXAxis: const CategoryAxis(
            axisLine: AxisLine(width: 0), // Menyembunyikan garis sumbu X
            majorGridLines:
                MajorGridLines(width: 0), // Menyembunyikan garis grid
          ),
          primaryYAxis: const NumericAxis(
            axisLine: AxisLine(width: 0), // Menyembunyikan garis sumbu Y
            majorGridLines:
                MajorGridLines(width: 0), // Menyembunyikan garis grid
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<_ConsultationData, String>>[
            // ColumnSeries untuk menampilkan chart kolom
            ColumnSeries<_ConsultationData, String>(
              dataSource: data,
              xValueMapper: (_ConsultationData consultation, _) =>
                  consultation.month,
              yValueMapper: (_ConsultationData consultation, _) =>
                  consultation.consultation,
              name: 'Consultation',
              pointColorMapper: (consultation, index) {
                // Alternatif warna berdasarkan index
                return index % 2 == 0 ? primaryColor : Colors.green;
              },
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              animationDuration: 500, // Durasi animasi chart
            ),
          ],
        ),
      ],
    );
  }
}

class _ConsultationData {
  _ConsultationData(this.month, this.consultation);

  final String month;
  final double consultation;
}
