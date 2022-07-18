class Tax {
  List<Data>? data;

  Tax({this.data});

  Tax.fromJson(Map<String, dynamic> json) {
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
  String? tINNAME;
  String? tIN;
  String? tINTYPEGROUP;
  dynamic? tOTALTAXES;
  String? sTATUS;
  String? lOCATION;
  int? statusNumber;
  int? totalPaid;

  Data(
      {this.tINNAME,
      this.tIN,
      this.tINTYPEGROUP,
      this.tOTALTAXES,
      this.sTATUS,
      this.lOCATION,
      this.statusNumber,
      this.totalPaid});

  Data.fromJson(Map<String, dynamic> json) {
    tINNAME = json['TIN_NAME'];
    tIN = json['TIN'];
    tINTYPEGROUP = json['TIN_TYPE_GROUP'];
    tOTALTAXES = json['TOTAL_TAXES'];
    sTATUS = json['STATUS'];
    lOCATION = json['LOCATION'];
    statusNumber = json['status_number'];
    totalPaid = json['total_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TIN_NAME'] = this.tINNAME;
    data['TIN'] = this.tIN;
    data['TIN_TYPE_GROUP'] = this.tINTYPEGROUP;
    data['TOTAL_TAXES'] = this.tOTALTAXES;
    data['STATUS'] = this.sTATUS;
    data['LOCATION'] = this.lOCATION;
    data['status_number'] = this.statusNumber;
    data['total_paid'] = this.totalPaid;
    return data;
  }
}