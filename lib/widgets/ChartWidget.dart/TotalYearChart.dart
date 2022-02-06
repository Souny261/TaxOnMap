import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalYearchart extends StatefulWidget {
  const TotalYearchart({Key? key}) : super(key: key);

  @override
  _TotalYearchartState createState() => _TotalYearchartState();
}

class _TotalYearchartState extends State<TotalYearchart> {
  List<ChartData> chartData = <ChartData>[];

  List data = [
    {
      "label": "Jan",
      "value": 500000000000,
    },
    {
      "label": "Apr",
      "value": 300000000000,
    },
    {
      "label": "Feb",
      "value": 330000000000,
    },
    {
      "label": "Mar",
      "value": 370000000000,
    },
    {
      "label": "May",
      "value": 300000000000,
    },
    {
      "label": "May",
      "value": 300000000000,
    },
    {
      "label": "Jun",
      "value": 350000000000,
    },
    {
      "label": "Jul",
      "value": 400000000000,
    },
    {
      "label": "Aug",
      "value": 0,
    },
    {
      "label": "Sep",
      "value": 0,
    },
    {
      "label": "Oct",
      "value": 0,
    },
    {
      "label": "Nov",
      "value": 0,
    },
    {
      "label": "Dec",
      "value": 0,
    },
  ];

  @override
  void initState() {
    chartData.clear();
    data.forEach((element) {
      chartData.add(
        ChartData(
          x: element['label'],
          // y: element['value'],
          y1: element['value'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              "ສັງລວມອາກອນປີ 2022",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior:
                      TooltipBehavior(enable: true, header: "ການຊຳລະ"),
                  // Palette colors
                  palette: <Color>[
                    Colors.blue
                  ],
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                        dataSource: chartData,
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

class ChartData {
  String? x;
  double? y;
  double? y1;

  ChartData({this.x, this.y, this.y1});
}
