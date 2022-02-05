import 'package:easy_tax_map/widgets/ProvinceDonutChartWidget.dart';
import 'package:flutter/material.dart';

class TotalTypeBusChart extends StatefulWidget {
  const TotalTypeBusChart({Key? key}) : super(key: key);

  @override
  _TotalTypeBusChartState createState() => _TotalTypeBusChartState();
}

class _TotalTypeBusChartState extends State<TotalTypeBusChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            "ສັງລວມອາກອນ ຕາມປະເພດທຸລະກິດ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(child: ProvinceDonutChartWidget())
        ],
      ),
    ));
  }
}
