import 'package:easy_tax_map/helper/Laoder.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:easy_tax_map/widgets/ProvinceDonutChartWidget.dart';
import 'package:easy_tax_map/widgets/TotalTaxLineChartwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatedChartWidget extends StatefulWidget {
  const CreatedChartWidget({Key? key}) : super(key: key);

  @override
  _CreatedChartWidgetState createState() => _CreatedChartWidgetState();
}

class _CreatedChartWidgetState extends State<CreatedChartWidget> {
  Helpers _helpers = Helpers();
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(child: TotalTaxLineChartWidget()),
          Expanded(
              child: Card(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ProvinceDonutChartWidget(
                        pieChartData: Provider.of<MainProvider>(context)
                            .pieProvinceChartData,
                        centerSpaceRadius: -1,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Provider.of<MainProvider>(context)
                                .pieProvinceChartData
                                .map(
                                  (e) => ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: Image.asset(
                                      e.image!,
                                      height: 45,
                                    ),
                                    title: Text(
                                      e.label!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        "ຈຳນວນ: ${_helpers.customCurrency(e.value.toString())}ກີບ"),
                                  ),
                                )
                                .toList(),
                          ),
                        ))
                  ],
                ),
                Positioned(
                    left: 8,
                    top: 4,
                    child: Text(
                      "ສັງລວມຂອງ: ${Provider.of<MainProvider>(context).titleDonutChart}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
