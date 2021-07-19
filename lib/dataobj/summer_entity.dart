import 'dart:convert';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:registration_staff/dataobj/institue_entity.dart';

///填报总结数据结构
class SummerEntity{

  SummerEntity({
    this.applicationId,
    this.text,
    this.title
});

  int applicationId;
  String text;
  String title;

  SummerEntity.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    text = json['text'];
    title = json['title'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationId'] = this.applicationId;
    data['text'] = this.text;
    data['title'] = this.title;
    return data;
  }

  // ignore: missing_return
  static List<SummerEntity> fromJsonList(List list) {
    List<SummerEntity> res = List();
    list.forEach((element) {res.add(SummerEntity.fromJson(element));});
  }
}
