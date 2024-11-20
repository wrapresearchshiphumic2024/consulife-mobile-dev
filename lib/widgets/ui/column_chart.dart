import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({Key? key}) : super(key: key);

  @override
  _ColumnChartState createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 45),
    _SalesData('Jul', 50),
    _SalesData('Aug', 42),
    _SalesData('Sep', 38),
    _SalesData('Oct', 48),
    _SalesData('Nov', 41),
    _SalesData('Dec', 55)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Initialize the chart widget
        SfCartesianChart(
          backgroundColor: Colors.transparent, // Remove chart background color
          borderColor: Colors.transparent, // Remove chart border
          borderWidth: 0, // Set border width to 0
          primaryXAxis: const CategoryAxis(
            axisLine: AxisLine(width: 0), // Hide axis line
            majorGridLines: MajorGridLines(width: 0), // Hide grid lines
          ),
          primaryYAxis: const NumericAxis(
            axisLine: AxisLine(width: 0), // Hide axis line
            majorGridLines: MajorGridLines(width: 0), // Hide grid lines
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<_SalesData, String>>[
            // ColumnSeries to display column chart
            ColumnSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Sales',
              // Enable data label
              pointColorMapper: (sales, index) {
                // Alternating colors based on index
                return index % 2 == 0 ? primaryColor : Colors.green;
              },
              // Set borderRadius to make the columns rounded
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
          ],
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
