import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearToYearChart extends StatefulWidget {
  const YearToYearChart({Key? key}) : super(key: key);

  @override
  _YearToYearChartState createState() => _YearToYearChartState();
}

class _YearToYearChartState extends State<YearToYearChart> {
  // _SplineDefaultState();

  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jan', y: 300000000000, secondSeriesYValue: 500000000000),
      ChartSampleData(
          x: 'Feb', y: 250000000000, secondSeriesYValue: 300000000000),
      ChartSampleData(
          x: 'Mar', y: 300000000000, secondSeriesYValue: 330000000000),
      ChartSampleData(
          x: 'Apr', y: 300000000000, secondSeriesYValue: 370000000000),
      ChartSampleData(
          x: 'May', y: 150000000000, secondSeriesYValue: 300000000000),
      ChartSampleData(
          x: 'Jun', y: 200000000000, secondSeriesYValue: 350000000000),
      ChartSampleData(
          x: 'Jul', y: 330000000000, secondSeriesYValue: 400000000000),
      // ChartSampleData(x: 'Aug', y: 0, secondSeriesYValue: 0),
      // ChartSampleData(x: 'Sep', y: 0, secondSeriesYValue: 0),
      // ChartSampleData(x: 'Oct', y: 0, secondSeriesYValue: 0),
      // ChartSampleData(x: 'Nov', y: 0, secondSeriesYValue: 0),
      // ChartSampleData(x: 'Dec', y: 0, secondSeriesYValue: 0)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultSplineChart();
  }

  List<ChartSampleData>? chartData;

  /// Returns the defaul spline chart.
  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'ສັງລວມອາກອນທຽບປີຜ່ານມາ'),
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          // minimum: 30,
          // maximum: 80,
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          // labelFormat: '{value}°F',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultSplineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData!,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        markerSettings: const MarkerSettings(isVisible: true),
        name: 'ປີ 2021',
      ),
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData!,
        name: 'ປີ 2022',
        markerSettings: const MarkerSettings(isVisible: true),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
      )
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
