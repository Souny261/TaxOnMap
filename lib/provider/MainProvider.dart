import 'dart:convert';
import 'dart:html';

import 'package:easy_tax_map/api/DioService.dart';
import 'package:easy_tax_map/models/PieChartModel.dart';
import 'package:easy_tax_map/models/ProvineModel.dart';
// import 'package:easy_tax_map/models/TaxModel.dart';
import 'package:easy_tax_map/models/tax.dart';
import 'package:easy_tax_map/models/taxdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MainProvider with ChangeNotifier {
  Tax? taxData;
  TaxDetail? taxDetail;
  String? tins;
  List districts = [
    // {
    //   "code": "0107",
    //   "district": "ຈັນທະຍູລີ",
    //   "lat": "17.996569134891963",
    //   "lng": "102.66422688231795",
    //   "value": taxDa,
    // }
  ];
  ProvinceModel? provinceModel;
  MapController? mapController;
  String? titleDonutChart = "ຈັນທະບູລີ";
  String? titleLinchart = "ນະຄອນຫຼວງວຽງຈັນ";
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

  List<PieChartModel> pieProvinceChartData = [
    // PieChartModel(
    //     value: 1000000000,
    //     title: "50%",
    //     image: "assets/images/icons8-done.png",
    //     color: Colors.green.shade900,
    //     label: "ຈ່າຍແລ້ວ"),
    // PieChartModel(
    //     value: 500000000,
    //     title: "35%",
    //     image: "assets/images/icons8-warning.png",
    //     color: Colors.yellow.shade900,
    //     label: "ຍັງບໍ່ຈ່າຍ"),
    // PieChartModel(
    //     value: 350000000,
    //     title: "15%",
    //     image: "assets/images/icons8-Red.png",
    //     color: Colors.red.shade900,
    //     label: "ຍັງບໍ່ແຈ້ງອາກອນ"),
  ];

  Future setMapController() async {
    mapController = MapController();
    notifyListeners();
  }

  Future loadData() async {
    // easyTax_list_all
    // taxData =
    //     TaxModel.fromJson(await DioService.createDio(path: "EasyTax_2022"));
    //     TaxModel.fromJson(await DioService.createDio(path: "easyTax_list_all"));
    // var data = await DioService.createDio(path: "easyTax_list_all");
    // data = data["data"].where((e)=>e["LOCATION"]!= null).toList();
    // data = {"data":data};
    // data = json.decode(data);
    // print(data);
    taxData =
        Tax.fromJson(await DioService.createDio(path: "easyTax_list_all"));
        // taxData = taxData!.data!.where((e)=>e.lOCATION != null) as Tax?;
    // print(taxData!.toJson());

    notifyListeners();
  }

  Future loadSubData(tin) async {
    tins = tin;
    // var url = Uri.parse("https://graph.mmoney.la/easyTax_list");
    // var res = await http.post(url, body: {"TIN": tin});

    // print(res.body);
    var data = await DioService.subDio(
        path: "https://graph.mmoney.la/easyTax_list", tin: tin);
    data["data"][0]["TOTAL_TAXES"] = data["data"][0]["TOTAL_TAXES"].toString();
    taxDetail = TaxDetail.fromJson(data);
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

  void setSearchData(data) {
    taxData?.data = [data];
    notifyListeners();
  }

  void setProvinceData() {
    List districtData = [];
    // var data =
    //     taxData!.data!.where((e) => e.provinceCode == provinceCode).toList();
    // var province =
    //     provinceModel!.data!.where((e) => e.code == provinceCode).first;
    // titleLinchart = province.provinceName;
    // List district = province.districtList!.toList();
    // for (var i = 0; i < district.length; i++) {
    //   var e = district[i];
    //   // var districtName = e.district;
    //   var value = 0;
    //   for (var j = 0; j < data.length; j++) {
    //     //  print(data[j].provinceCode);
    //     if ((data[j].provinceCode == provinceCode) &&
    //         (data[j].districtCode == e.code) &&
    //         (data[j].statusCode == 2)) {
    //       value += data[j].taxAmount!;
    //     }
    //   }
    //   districtData.add({"district": e.district, "value": value});
    // }

    var data = taxData!.data!.where((e) => e.statusNumber == 0).toList();
    var sum = 0;
    for (var i=0;i<data.length;i++){
      sum+=data[i].totalPaid!;
    }
    districtData.add({"district":"ຈັນທະບູລີ", "value": sum});
    districtData.add({"district":"ສີໂຄດຕະບອງ", "value": 0});
    districtData.add({"district":"ສີສັດຕະນາກ", "value": 0});
    districtData.add({"district":"ສັງທອງ", "value": 0});
    districtData.add({"district":"ໄຊເສດຖາ", "value": 0});
    districtData.add({"district":"ໄຊທານີ", "value": 0});
    districtData.add({"district":"ນາໄຊທອງ", "value": 0});
    districtData.add({"district":"ປາກງື່ມ", "value": 0});
    districtData.add({"district":"ຫາດຊາຍຟອງ", "value": 0});

    districts = districtData;

    //**
    //
    //
    //
    //
    //
    //
    // */

    // double valuePaid = 0;
    // double valueUnPaid = 0;
    // double valueUnClear = 0;
    // String titlePaidP = "0";
    // String titleUnPaidP = "0";
    // String titleUnClearP = "0";

    // var datas = taxData!.data!
    //     .where((e) => e.districtCode == data[0].districtCode)
    //     .toList();
    // if (datas.length > 0) {
    //   titleDonutChart = datas[0].district;
    //   for (var i = 0; i < datas.length; i++) {
    //     if (datas[i].statusCode == 0) {
    //       valueUnClear += datas[i].taxAmount!;
    //     } else if (datas[i].statusCode == 1) {
    //       valueUnPaid += datas[i].taxAmount!;
    //     } else {
    //       valuePaid += datas[i].taxAmount!;
    //     }
    //   }
    //   var total = valuePaid + valueUnPaid + valueUnClear;
    //   titlePaidP = ((valuePaid / total) * 100).toStringAsFixed(2).toString();
    //   titleUnPaidP =
    //       ((valueUnPaid / total) * 100).toStringAsFixed(2).toString();
    //   titleUnClearP =
    //       ((valueUnClear / total) * 100).toStringAsFixed(2).toString();
    // } else {
    //   valuePaid = 0;
    //   valueUnPaid = 0;
    //   valueUnClear = 0;
    //   titlePaidP = "0";
    //   titleUnPaidP = "0";
    //   titleUnClearP = "0";
    // }

    // pieProvinceChartData = [
    //   PieChartModel(
    //       value: valuePaid,
    //       title: titlePaidP,
    //       image: "assets/images/icons8-done.png",
    //       color: Colors.green.shade900,
    //       label: "ຈ່າຍແລ້ວ"),
    //   PieChartModel(
    //       value: valueUnPaid,
    //       title: titleUnPaidP,
    //       image: "assets/images/icons8-warning.png",
    //       color: Colors.yellow.shade900,
    //       label: "ຍັງບໍ່ຈ່າຍ"),
    //   PieChartModel(
    //       value: valueUnClear,
    //       title: titleUnClearP,
    //       image: "assets/images/icons8-Red.png",
    //       color: Colors.red.shade900,
    //       label: "ຍັງບໍ່ແຈ້ງອາກອນ"),
    // ];
    notifyListeners();
  }

  void setDistrictData() {
    double valuePaid = 0;
    double valueUnPaid = 0;
    double valueUnClear = 0;
    String titlePaidP = "0";
    String titleUnPaidP = "0";
    String titleUnClearP = "0";
    valuePaid = double.parse(taxData!.data!.where((e) => e.statusNumber == 0).toList().length.toString());
    valueUnPaid = double.parse(taxData!.data!.where((e) => e.statusNumber! > 0).toList().length.toString());
    valueUnClear = double.parse(taxData!.data!.where((e) => e.statusNumber! < 0).toList().length.toString());
    //   // valuePaid += 1000000000;

      var total = valuePaid + valueUnPaid + valueUnClear;
      titlePaidP = ((valuePaid / total) * 100).toStringAsFixed(2).toString()+"%";
      titleUnPaidP =
          ((valueUnPaid / total) * 100).toStringAsFixed(2).toString()+"%";
      titleUnClearP =
          ((valueUnClear / total) * 100).toStringAsFixed(2).toString()+"%";
    // } else {
    //   valuePaid = 0;
    //   valueUnPaid = 0;
    //   valueUnClear = 0;
    //   titlePaidP = "0";
    //   titleUnPaidP = "0";
    //   titleUnClearP = "0";
    // }

    pieProvinceChartData = [
      PieChartModel(
          value: valuePaid,
          title: titlePaidP,
          image: "assets/images/icons8-done.png",
          color: Colors.green.shade900,
          label: "ຈ່າຍແລ້ວ"),
      PieChartModel(
          value: valueUnPaid,
          title: titleUnPaidP,
          image: "assets/images/icons8-warning.png",
          color: Colors.yellow.shade900,
          label: "ຍັງບໍ່ຈ່າຍ"),
      PieChartModel(
          value: valueUnClear,
          title: titleUnClearP,
          image: "assets/images/icons8-Red.png",
          color: Colors.red.shade900,
          label: "ຍັງບໍ່ແຈ້ງອາກອນ"),
    ];
    // districts = districtData;
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
