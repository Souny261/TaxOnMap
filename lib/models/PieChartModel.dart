import 'package:flutter/material.dart';

class PieChartModel {
  int? value;
  String? title;
  String? image;
  Color? color;

  PieChartModel({this.value, this.title, this.image, this.color});

  PieChartModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    title = json['title'];
    image = json['image'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['title'] = this.title;
    data['image'] = this.image;
    data['color'] = this.color;
    return data;
  }
}
