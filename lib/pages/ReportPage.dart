import 'package:easy_tax_map/widgets/ChartWidget.dart/TopTaxChart.dart';
import 'package:easy_tax_map/widgets/ChartWidget.dart/TotalTypeBusChart.dart';
import 'package:easy_tax_map/widgets/ChartWidget.dart/TotalYearChart.dart';
import 'package:easy_tax_map/widgets/ChartWidget.dart/YearToYearChart.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: TotalYearchart()),
                Expanded(child: TotalTypeBusChart()),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: YearToYearChart()
                ),
                Expanded(
                  child: TopTaxChart(),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
