import 'package:easy_tax_map/widgets/ProvinceDonutChartWidget.dart';
import 'package:easy_tax_map/widgets/TotalTaxLineChartwidget.dart';
import 'package:flutter/material.dart';

class CreatedChartWidget extends StatefulWidget {
  const CreatedChartWidget({Key? key}) : super(key: key);

  @override
  _CreatedChartWidgetState createState() => _CreatedChartWidgetState();
}

class _CreatedChartWidgetState extends State<CreatedChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TotalTaxLineChartWidget()),
          Expanded(child: ProvinceDonutChartWidget()),
        ],
      ),
    );
  }
}
