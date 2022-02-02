import 'dart:convert';

import 'package:easy_tax_map/models/ProvineModel.dart';
import 'package:easy_tax_map/models/TaxModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainProvider with ChangeNotifier {
  TaxModel? taxData;
  ProvinceModel? provinceModel;
  MapController? mapController;
  Future setMapController() async {
    mapController = MapController();
    notifyListeners();
  }

  Future loadData() async {
    var data = json
        .decode(await rootBundle.loadString('assets/chanthabouly_data.json'));
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
