class TaxDetail {
  List<Data>? data;

  TaxDetail({this.data});

  TaxDetail.fromJson(Map<String, dynamic> json) {
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
  String? tOTALTAXES;
  String? sTATUS;
  String? iMAGE;
  String? lOCATION;
  List<BARCODES>? bARCODES;
  int? statusNumber;
  int? totalPaid;

  Data(
      {this.tINNAME,
      this.tIN,
      this.tINTYPEGROUP,
      this.tOTALTAXES,
      this.sTATUS,
      this.iMAGE,
      this.lOCATION,
      this.bARCODES,
      this.statusNumber,
      this.totalPaid});

  Data.fromJson(Map<String, dynamic> json) {
    tINNAME = json['TIN_NAME'];
    tIN = json['TIN'];
    tINTYPEGROUP = json['TIN_TYPE_GROUP'];
    tOTALTAXES = json['TOTAL_TAXES'];
    sTATUS = json['STATUS'];
    iMAGE = json['IMAGE'];
    lOCATION = json['LOCATION'];
    if (json['BARCODES'] != null) {
      bARCODES = <BARCODES>[];
      json['BARCODES'].forEach((v) {
        bARCODES!.add(new BARCODES.fromJson(v));
      });
    }
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
    data['IMAGE'] = this.iMAGE;
    data['LOCATION'] = this.lOCATION;
    if (this.bARCODES != null) {
      data['BARCODES'] = this.bARCODES!.map((v) => v.toJson()).toList();
    }
    data['status_number'] = this.statusNumber;
    data['total_paid'] = this.totalPaid;
    return data;
  }
}

class BARCODES {
  String? barcode;
  int? statusCode;
  int? total;
  int? debitTotal;

  BARCODES({this.barcode, this.statusCode, this.total, this.debitTotal});

  BARCODES.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
    statusCode = json['statusCode'];
    total = json['Total'];
    debitTotal = json['DebitTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = this.barcode;
    data['statusCode'] = this.statusCode;
    data['Total'] = this.total;
    data['DebitTotal'] = this.debitTotal;
    return data;
  }
}