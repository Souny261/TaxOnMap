import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalTaxLineChartWidget extends StatefulWidget {
  const TotalTaxLineChartWidget({Key? key}) : super(key: key);

  @override
  _TotalTaxLineChartWidgetState createState() =>
      _TotalTaxLineChartWidgetState();
}

class _TotalTaxLineChartWidgetState extends State<TotalTaxLineChartWidget> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Card(
      shadowColor: Colors.blue,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ສັງລວມຂອງ: ${mainProvider.titleLinchart}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
