import 'package:flutter/material.dart';

class TaxPieChart extends StatefulWidget {
  const TaxPieChart({Key? key}) : super(key: key);

  @override
  _TaxPieChartState createState() => _TaxPieChartState();
}

class _TaxPieChartState extends State<TaxPieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.blue)),
    );
  }
}
