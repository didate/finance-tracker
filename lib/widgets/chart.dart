import 'package:finance/colory.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int index;

  Chart({super.key, required this.index});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool b = true;
  bool j = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        b = true;
        j = true;
        break;
      case 1:
        b = false;
        j = true;
        break;
      case 2:
        b = false;
        j = true;
        break;
      case 3:
        j = false;
        break;
      default:
    }

    return SizedBox(
        width: double.infinity,
        height: 300,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <SplineSeries<SalesData, String>>[
            SplineSeries<SalesData, String>(
              color: Colory.greendark,
              width: 3,
              dataSource: const <SalesData>[],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
            )
          ],
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
