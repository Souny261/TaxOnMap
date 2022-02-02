class ProvinceModel {
  List<ProvinceData>? data;

  ProvinceModel({this.data});

  ProvinceModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = <ProvinceData>[];
      json['data'].forEach((v) {
        data!.add(new ProvinceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvinceData {
  String? code;
  String? provinceName;
  String? lat;
  String? lng;
  List<DistrictList>? districtList;

  ProvinceData(
      {this.code, this.provinceName, this.lat, this.lng, this.districtList});

  ProvinceData.fromJson(dynamic json) {
    code = json['code'];
    provinceName = json['province_name'];
    lat = json['lat'];
    lng = json['lng'];
    if (json['district_list'] != null) {
      districtList = <DistrictList>[];
      json['district_list'].forEach((v) {
        districtList!.add(new DistrictList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['province_name'] = this.provinceName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.districtList != null) {
      data['district_list'] =
          this.districtList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictList {
  String? code;
  String? district;
  String? lat;
  String? lng;

  DistrictList({this.code, this.district, this.lat, this.lng});

  DistrictList.fromJson(dynamic json) {
    code = json['code'];
    district = json['district'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['district'] = this.district;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
