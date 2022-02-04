import 'dart:convert';

import 'package:easy_tax_map/helper/Laoder.dart';
import 'package:easy_tax_map/provider/LocationProvider.dart';
import 'package:easy_tax_map/provider/MainProvider.dart';
import 'package:easy_tax_map/widgets/CreatedMap.dart';
import 'package:easy_tax_map/widgets/SearchWidget.dart';
import 'package:easy_tax_map/widgets/TaxPieChartWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.loadData();
    mainProvider.loadProvinceData();
    // mainProvider.setMapController();
    locationProvider.getCurentLocation().whenComplete(() {
      mainProvider.setMapController();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      body: locationProvider.latLngPosition == null
          ? Center(
              child: LoaderTwo(),
            )
          : Row(
              children: [
                Expanded(
                  child: SearchWidget(),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CreatedMapWidget(),
                      ),
                      Expanded(child: TaxPieChart())
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
