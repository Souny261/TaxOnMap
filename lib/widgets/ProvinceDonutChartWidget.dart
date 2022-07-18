import 'package:easy_tax_map/models/PieChartModel.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

class ProvinceDonutChartWidget extends StatefulWidget {
  final List<PieChartModel>? pieChartData;
  final double? centerSpaceRadius;
  const ProvinceDonutChartWidget(
      {Key? key, this.pieChartData, this.centerSpaceRadius})
      : super(key: key);
  @override
  _ProvinceDonutChartWidgetState createState() =>
      _ProvinceDonutChartWidgetState();
}

class _ProvinceDonutChartWidgetState extends State<ProvinceDonutChartWidget> {
  int? touchedIndex;
  @override
  Widget build(BuildContext context) {
    // final mainProvider = Provider.of<MainProvider>(context);
    return Container(
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: widget.centerSpaceRadius,
                sections: showingSections(widget.pieChartData!)),
          ),
          widget.centerSpaceRadius! < 0
              ? Container()
              : Positioned(
                  right: 16,
                  top: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue.shade900,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ບ້ານ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green.shade900,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ບໍລິສັດຈຳກັດຜູ້ດຽວ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.yellow.shade900,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ວິສາຫະກິດບຸກຄົນ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.red.shade900,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ວິສາຫະກິດປະສົມ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ))
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<PieChartModel> pieChartData) {
    // final mainProvider = Provider.of<MainProvider>(context);

    return pieChartData.map((e) {
      final isTouched = pieChartData.indexOf(e) == touchedIndex;
      double fontSize = isTouched
          ? widget.centerSpaceRadius! < 0
              ? 16
              : 20.0
          : widget.centerSpaceRadius! < 0
              ? 13
              : 16.0;
      final radius = isTouched
          ? widget.centerSpaceRadius! < 0
              ? 80.0
              : 110.0
          : widget.centerSpaceRadius! < 0
              ? 70.0
              : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      return PieChartSectionData(
        color: e.color,
        value: e.value,
        title: e.title,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
        badgeWidget: _Badge(
          e.image!,
          size: widgetSize,
          borderColor: e.color!,
        ),
        badgePositionPercentageOffset: .98,
      );
    }).toList();
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
