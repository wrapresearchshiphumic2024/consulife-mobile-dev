import 'package:consulin_mobile_dev/app/modules/ai_analyzer_pasien/controllers/ai_analyzer_pasien_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChartAnalysis extends StatelessWidget {
  const ColumnChartAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var consultationData = Get.find<AiAnalyzerPasienController>();
    // Membuat data untuk chart berdasarkan monthlyPatientCount dari controller
    List<_ConsultationData> data = [
      _ConsultationData('Stress', consultationData.stressProbability.value,
          '#DC3545'), // Warna merah untuk Stress
      _ConsultationData('Anxiety', consultationData.anxietyProbability.value,
          '#4C9AFF'), // Warna biru untuk Anxiety
      _ConsultationData(
          'Depression',
          consultationData.depressionProbability.value,
          '#F28D35'), // Warna orange untuk Depression
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
                  consultation.type, // Menggunakan 'type' untuk x-axis
              yValueMapper: (_ConsultationData consultation, _) =>
                  consultation.consultation,
              name: 'Type', // Nama seri tetap 'Consultation'
              pointColorMapper: (consultation, index) {
                // Menentukan warna berdasarkan 'fill' yang ada pada data
                return Color(
                    int.parse('0xFF${consultation.fill.substring(1)}'));
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
  _ConsultationData(this.type, this.consultation, this.fill);

  final String type; // Ini adalah field 'type' yang digunakan di chart
  final double consultation;
  final String fill; // Menyimpan warna untuk setiap kategori
}
