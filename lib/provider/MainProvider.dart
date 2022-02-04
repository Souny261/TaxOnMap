import 'dart:convert';

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
  Future setMapController() async {
    mapController = MapController();
    notifyListeners();
  }

  Future loadData() async {
    var url = Uri.parse("http://172.28.14.87:3000/EasyTax_2022");
    // print(url);
    var res = await http.get(url);
    // print("DATA"+res.body);
    // var data = json
    //     .decode(await rootBundle.loadString('assets/chanthabouly_data.json'));
    var data = json.decode(res.body);
    // print(data);
    taxData = TaxModel.fromJson(data);
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
}
