// To parse this JSON data, do
//
//     final mobileAppPromotionResponse = mobileAppPromotionResponseFromJson(jsonString);

import 'dart:convert';

//List mobileAppPromotionResponseFromJson(String str) => List.from(json.decode(str).map((x) => MobileAppPromotionResponse.fromJson(x)));
//
//String mobileAppPromotionResponseToJson(List data) => json.encode(List.from(data.map((x) => x.toJson())));

class MobileAppPromotionResponse {
  String mobileAppPromotionId;
  String mobileAppPromotionName;
  String mobileAppPromotionDetail;
  String mobileAppPromotionLink;
  DateTime mobileAppPromotionDate;
  String mobileAppPromotionTime;
  String mobileAppPromotionPic;
  int autoNo;

  MobileAppPromotionResponse({
    this.mobileAppPromotionId,
    this.mobileAppPromotionName,
    this.mobileAppPromotionDetail,
    this.mobileAppPromotionLink,
    this.mobileAppPromotionDate,
    this.mobileAppPromotionTime,
    this.mobileAppPromotionPic,
    this.autoNo,
  });

  factory MobileAppPromotionResponse.fromJson(Map<String, dynamic> json) => MobileAppPromotionResponse(
    mobileAppPromotionId: json["mobileAppPromotionID"],
    mobileAppPromotionName: json["mobileAppPromotionName"],
    mobileAppPromotionDetail: json["mobileAppPromotionDetail"],
    mobileAppPromotionLink: json["mobileAppPromotionLink"],
    mobileAppPromotionDate: DateTime.parse(json["mobileAppPromotionDate"]),
    mobileAppPromotionTime: json["mobileAppPromotionTime"],
    mobileAppPromotionPic: json["mobileAppPromotionPic"],
    autoNo: json["autoNo"],
  );

  Map<String, dynamic> toJson() => {
    "mobileAppPromotionID": mobileAppPromotionId,
    "mobileAppPromotionName": mobileAppPromotionName,
    "mobileAppPromotionDetail": mobileAppPromotionDetail,
    "mobileAppPromotionLink": mobileAppPromotionLink,
    "mobileAppPromotionDate": mobileAppPromotionDate.toIso8601String(),
    "mobileAppPromotionTime": mobileAppPromotionTime,
    "mobileAppPromotionPic": mobileAppPromotionPic,
    "autoNo": autoNo,
  };
}

