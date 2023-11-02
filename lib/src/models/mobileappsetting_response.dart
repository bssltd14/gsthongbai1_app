// To parse this JSON data, do
//
//     final mobileAppSettingResponse = mobileAppSettingResponseFromJson(jsonString);

import 'dart:convert';

List<MobileAppSettingResponse> mobileAppSettingResponseFromJson(String str) => List<MobileAppSettingResponse>.from(json.decode(str).map((x) => MobileAppSettingResponse.fromJson(x)));

String mobileAppSettingResponseToJson(List<MobileAppSettingResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MobileAppSettingResponse {
  MobileAppSettingResponse({
    this.appName,
    this.address1,
    this.address2,
    this.address3,
    this.telText1,
    this.telText2,
    this.telText3,
    this.tel1,
    this.tel2,
    this.tel3,
    this.lineId,
    this.facebookName,
    this.facebookId,
    this.instagram,
    this.primaryColor,
    this.secondaryColor,
    this.fontColorMenu,
    this.fontColorPage,
    this.autoNo,
    this.lat1,
    this.lat2,
    this.lng1,
    this.lng2,
    this.urlapi,
    this.overDayInt,
  });

  String appName;
  String address1;
  String address2;
  String address3;
  String telText1;
  String telText2;
  String telText3;
  String tel1;
  String tel2;
  String tel3;
  String lineId;
  String facebookName;
  String facebookId;
  String instagram;
  String primaryColor;
  String secondaryColor;
  String fontColorMenu;
  String fontColorPage;
  int autoNo;
  String lat1;
  String lat2;
  String lng1;
  String lng2;
  String urlapi;
  int overDayInt;

  factory MobileAppSettingResponse.fromJson(Map<String, dynamic> json) => MobileAppSettingResponse(
    appName: json["appName"],
    address1: json["address1"],
    address2: json["address2"],
    address3: json["address3"],
    telText1: json["telText1"],
    telText2: json["telText2"],
    telText3: json["telText3"],
    tel1: json["tel1"],
    tel2: json["tel2"],
    tel3: json["tel3"],
    lineId: json["lineId"],
    facebookName: json["facebookName"],
    facebookId: json["facebookId"],
    instagram: json["instagram"],
    primaryColor: json["primaryColor"],
    secondaryColor: json["secondaryColor"],
    fontColorMenu: json["fontColorMenu"],
    fontColorPage: json["fontColorPage"],
    autoNo: json["autoNo"],
    lat1: json["lat1"],
    lat2: json["lat2"],
    lng1: json["lng1"],
    lng2: json["lng2"],
    urlapi: json["urlapi"],
     overDayInt: json["overDayInt"] == null ? null : json["overDayInt"],
  );

  Map<String, dynamic> toJson() => {
    "appName": appName,
    "address1": address1,
    "address2": address2,
    "address3": address3,
    "telText1": telText1,
    "telText2": telText2,
    "telText3": telText3,
    "tel1": tel1,
    "tel2": tel2,
    "tel3": tel3,
    "lineId": lineId,
    "facebookName": facebookName,
    "facebookId": facebookId,
    "instagram": instagram,
    "primaryColor": primaryColor,
    "secondaryColor": secondaryColor,
    "fontColorMenu": fontColorMenu,
    "fontColorPage": fontColorPage,
    "autoNo": autoNo,
    "lat1": lat1,
    "lat2": lat2,
    "lng1": lng1,
    "lng2": lng2,
    "urlapi": urlapi,
    "overDayInt": overDayInt == null ? null : overDayInt,
  };
}
