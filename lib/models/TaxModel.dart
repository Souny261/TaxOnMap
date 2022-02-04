class TaxModel {
  List<Data>? data;

  TaxModel({this.data});

  TaxModel.fromJson(Map<String, dynamic> json) {
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
  String? barcode;
  String? tin;
  String? name;
  String? village;
  String? accType;
  String? taxType;
  String? busType;
  String? mainBusTpye;
  String? busTypeLSIC;
  String? issueDate;
  String? type;
  String? description;
  int? taxAmount;
  int? debitTax;
  int? statusCode;
  String? status;
  String? dates;
  String? districtCode;
  String? district;
  String? provinceCode;
  String? province;
  String? locations;

  Data(
      {this.id,
      this.barcode,
      this.tin,
      this.name,
      this.village,
      this.accType,
      this.taxType,
      this.busType,
      this.mainBusTpye,
      this.busTypeLSIC,
      this.issueDate,
      this.type,
      this.description,
      this.taxAmount,
      this.debitTax,
      this.statusCode,
      this.status,
      this.dates,
      this.districtCode,
      this.district,
      this.provinceCode,
      this.province,
      this.locations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    tin = json['tin'];
    name = json['name'];
    village = json['village'];
    accType = json['AccType'];
    taxType = json['TaxType'];
    busType = json['BusType'];
    mainBusTpye = json['MainBusTpye'];
    busTypeLSIC = json['BusTypeLSIC'];
    issueDate = json['IssueDate'];
    type = json['Type'];
    description = json['Description'];
    taxAmount = json['TaxAmount'];
    debitTax = json['DebitTax'];
    statusCode = json['StatusCode'];
    status = json['Status'];
    dates = json['Dates'];
    districtCode = json['DistrictCode'];
    district = json['District'];
    provinceCode = json['ProvinceCode'];
    province = json['Province'];
    locations = json['Locations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['tin'] = this.tin;
    data['name'] = this.name;
    data['village'] = this.village;
    data['AccType'] = this.accType;
    data['TaxType'] = this.taxType;
    data['BusType'] = this.busType;
    data['MainBusTpye'] = this.mainBusTpye;
    data['BusTypeLSIC'] = this.busTypeLSIC;
    data['IssueDate'] = this.issueDate;
    data['Type'] = this.type;
    data['Description'] = this.description;
    data['TaxAmount'] = this.taxAmount;
    data['DebitTax'] = this.debitTax;
    data['StatusCode'] = this.statusCode;
    data['Status'] = this.status;
    data['Dates'] = this.dates;
    data['DistrictCode'] = this.districtCode;
    data['District'] = this.district;
    data['ProvinceCode'] = this.provinceCode;
    data['Province'] = this.province;
    data['Locations'] = this.locations;
    return data;
  }
}
