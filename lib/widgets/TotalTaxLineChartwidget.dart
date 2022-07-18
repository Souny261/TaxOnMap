import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'ChartWidget.dart/TotalYearChart.dart';

class TotalTaxLineChartWidget extends StatefulWidget {
  const TotalTaxLineChartWidget({Key? key}) : super(key: key);

  @override
  _TotalTaxLineChartWidgetState createState() =>
      _TotalTaxLineChartWidgetState();
}

class _TotalTaxLineChartWidgetState extends State<TotalTaxLineChartWidget> {
  // List data = [
  //   {
  //     "code": "0101",
  //     "district": "ຈັນທະບູລີ",
  //     "lat": "18.00450949969345",
  //     "lng": "102.59299916677381",
  //     "value": 50000000000,
  //   },
  //   {
  //     "code": "0102",
  //     "district": "ສີໂຄດຕະບອງ",
  //     "lat": "17.999564",
  //     "lng": "102.547297",
  //     "value": 33000000000,
  //   },
  //   {
  //     "code": "0104",
  //     "district": "ສີສັດຕະນາກ",
  //     "lat": "17.913725",
  //     "lng": "102.626112",
  //     "value": 20000000000,
  //   },
  //   {
  //     "code": "0108",
  //     "district": "ສັງທອງ",
  //     "lat": "18.701483192996026",
  //     "lng": "102.21919485400058",
  //     "value": 15000000000,
  //   },
  //   {
  //     "code": "0103",
  //     "district": "ໄຊເສດຖາ",
  //     "lat": "17.99036511621997",
  //     "lng": "102.63261805724113",
  //     "value": 40000000000,
  //   },
  //   {
  //     "code": "0106",
  //     "district": "ໄຊທານີ",
  //     "lat": "18.04405273166597",
  //     "lng": "102.63387133898257",
  //     "value": 12500000000,
  //   },
  //   {
  //     "code": "0105",
  //     "district": "ນາໄຊທອງ",
  //     "lat": "18.08731734561543",
  //     "lng": "102.52485252616604",
  //     "value": 12500000000,
  //   },
  //   {
  //     "code": "0109",
  //     "district": "ປາກງື່ມ",
  //     "lat": "18.06744867789096",
  //     "lng": "102.90215801575496",
  //     "value": 100000000,
  //   },
  //   {
  //     "code": "0107",
  //     "district": "ຫາດຊາຍຟອງ",
  //     "lat": "17.996569134891963",
  //     "lng": "102.66422688231795",
  //     "value": 4660000000,
  //   }
  // ];
  List<ChartData> chartData = <ChartData>[];
  @override
  void initState() {
    // var data = Provider.of<MainProvider>(context).districts;
    // if (data.length > 0) {
    //   chartData.clear();
    //   data.forEach((element) {
    //     chartData.add(
    //       ChartData(
    //         x: element['district'],
    //         // y: element['value'],
    //         y1: element['value'],
    //       ),
    //     );
    //   });
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    if (mainProvider.districts.length > 0) {
      chartData.clear();
      mainProvider.districts.forEach((element) {
        chartData.add(
          ChartData(
            x: element['district'],
            // y: element['value'],
            y1: element['value'],
          ),
        );
      });
    }
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
            ),
            Expanded(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: TooltipBehavior(
                      enable: true, header: "${mainProvider.titleLinchart}"),
                  // Palette colors
                  palette: <Color>[
                    Colors.blue
                  ],
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        // enableTooltip: false,
                        markerSettings: MarkerSettings(isVisible: true),
                        dataLabelSettings: DataLabelSettings(
                            // Renders the data label
                            isVisible: false),
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y1),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
