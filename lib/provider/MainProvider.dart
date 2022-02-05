import 'dart:convert';

import 'package:easy_tax_map/api/DioService.dart';
import 'package:easy_tax_map/models/PieChartModel.dart';
import 'package:easy_tax_map/models/ProvineModel.dart';
import 'package:easy_tax_map/models/TaxModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MainProvider with ChangeNotifier {
  TaxModel? taxData;
  ProvinceModel? provinceModel;
  MapController? mapController;
  String? titleDonutChart = "ຈັນທະບູລີ";
  String? titleLinchart = "ນະຄອນຫຼວງ";
  List<PieChartModel> pieChartData = [
    PieChartModel(
      value: 5.26,
      title: "5.26%",
      image: "assets/images/icons8-Red.png",
      color: Colors.blue.shade900,
    ),
    PieChartModel(
      value: 10.53,
      title: "10.53%",
      image: "assets/images/icons8-Red.png",
      color: Colors.green.shade900,
    ),
    PieChartModel(
      value: 31.58,
      title: "31.58%",
      image: "assets/images/icons8-Red.png",
      color: Colors.yellow.shade900,
    ),
    PieChartModel(
      value: 52.63,
      title: "52.63%",
      image: "assets/images/icons8-Red.png",
      color: Colors.red.shade900,
    ),
  ];

  Future setMapController() async {
    mapController = MapController();
    notifyListeners();
  }

  Future loadData() async {
    taxData =
        TaxModel.fromJson(await DioService.createDio(path: "EasyTax_2022"));
    notifyListeners();
  }

  Future loadProvinceData() async {
    var data =
        json.decode(await rootBundle.loadString('assets/provinces.json'));
    provinceModel = ProvinceModel.fromJson(data);
    notifyListeners();
  }

  void moveMap(String latn, String long) {
    mapController!.move(LatLng(double.parse(latn), double.parse(long)), 16.0);
    notifyListeners();
  }

  Future setInitialPieData() async {
    // pieChartData = [
    //   PieChartModel(
    //     value:
    //         taxData!.data!.where((element) => element.statusCode == 0).length,
    //     title: taxData!.data!
    //         .where((element) => element.statusCode == 0)
    //         .length
    //         .toString(),
    //     image: "assets/images/icons8-Red.png",
    //     color: Colors.red,
    //   ),
    //   PieChartModel(
    //     value:
    //         taxData!.data!.where((element) => element.statusCode == 1).length,
    //     title: taxData!.data!
    //         .where((element) => element.statusCode == 1)
    //         .length
    //         .toString(),
    //     image: "assets/images/icons8-warning.png",
    //     color: Colors.yellow,
    //   ),
    //   PieChartModel(
    //     value:
    //         taxData!.data!.where((element) => element.statusCode == 2).length,
    //     title: taxData!.data!
    //         .where((element) => element.statusCode == 2)
    //         .length
    //         .toString(),
    //     image: "assets/images/icons8-done.png",
    //     color: Colors.green,
    //   ),
    // ];
    notifyListeners();
  }
}
