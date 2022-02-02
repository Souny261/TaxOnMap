class TaxModel {
  List<Data>? data;

  TaxModel({this.data});

  TaxModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? provinceCode;
  String? province;
  String? districtCode;
  String? district;
  String? taxpayerType;
  String? tIN;
  String? businessType;
  Null? column9;
  String? businessName;
  String? ownerName;
  String? lat;
  String? lng;

  Data(
      {this.id,
      this.provinceCode,
      this.province,
      this.districtCode,
      this.district,
      this.taxpayerType,
      this.tIN,
      this.businessType,
      this.column9,
      this.businessName,
      this.ownerName,
      this.lat,
      this.lng});

  Data.fromJson(dynamic json) {
    id = json['Id'];
    provinceCode = json['ProvinceCode'];
    province = json['Province'];
    districtCode = json['districtCode'];
    district = json['District'];
    taxpayerType = json['TaxpayerType'];
    tIN = json['TIN'];
    businessType = json['BusinessType'];
    column9 = json['Column9'];
    businessName = json['BusinessName'];
    ownerName = json['OwnerName'];
    lat = json['Lat'];
    lng = json['Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProvinceCode'] = this.provinceCode;
    data['Province'] = this.province;
    data['districtCode'] = this.districtCode;
    data['District'] = this.district;
    data['TaxpayerType'] = this.taxpayerType;
    data['TIN'] = this.tIN;
    data['BusinessType'] = this.businessType;
    data['Column9'] = this.column9;
    data['BusinessName'] = this.businessName;
    data['OwnerName'] = this.ownerName;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    return data;
  }
}
