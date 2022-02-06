import 'package:easy_tax_map/widgets/ChartWidget.dart/TotalYearChart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopTaxChart extends StatefulWidget {
  const TopTaxChart({Key? key}) : super(key: key);

  @override
  _TopTaxChartState createState() => _TopTaxChartState();
}

class _TopTaxChartState extends State<TopTaxChart> {
  List<ChartData> chartData = <ChartData>[];

  List data = [
    {
      "label": "ນະຄອນຫຼວງ",
      "value": 50000000000,
    },
    {
      "label": "ວຽງຈັນ",
      "value": 40000000000,
    },
    {
      "label": "ບໍ່ແກ້ວ",
      "value": 33000000000,
    },
    {
      "label": "ຈຳປາສັກ",
      "value": 30000000000,
    },
    {
      "label": "ສະຫວັນນະເຂດ",
      "value": 25000000000,
    },
    {
      "label": "ຫຼວງພະບາງ",
      "value": 20000000000,
    },
    {
      "label": "ບໍລິຄຳໄຊ",
      "value": 15000000000,
    }
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              "ແຂວງທີ່ສາມາດເກັບອາກອນໄດ້ຫຼາຍທີ່ສຸດ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: SfCartesianChart(primaryXAxis: CategoryAxis(),
               tooltipBehavior: TooltipBehavior(
                      enable: true, header: "ການຊຳລະ"),
                  // Palette colors
                  palette: <Color>[
                    Colors.yellow.shade900
                  ], series: <CartesianSeries>[
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
