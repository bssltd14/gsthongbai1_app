// To parse this JSON data, do
//
//     final viewAPIMAPResponse = viewAPIMAPResponseFromJson(jsonString);

import 'dart:convert';

List<ViewAPIMAPResponse> viewAPIMAPResponseFromJson(String str) => List<ViewAPIMAPResponse>.from(json.decode(str).map((x) => ViewAPIMAPResponse.fromJson(x)));

String viewAPIMAPResponseToJson(List<ViewAPIMAPResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewAPIMAPResponse {
  String mobileAppPromotionId;
  String mobileAppPromotionName;
  String mobileAppPromotionDetail;
  String mobileAppPromotionLink;
  DateTime mobileAppPromotionDate;
  String mobileAppPromotionTime;
  int autoNo;

  ViewAPIMAPResponse({
    this.mobileAppPromotionId,
    this.mobileAppPromotionName,
    this.mobileAppPromotionDetail,
    this.mobileAppPromotionLink,
    this.mobileAppPromotionDate,
    this.mobileAppPromotionTime,
    this.autoNo,
  });

  factory ViewAPIMAPResponse.fromJson(Map<String, dynamic> json) => ViewAPIMAPResponse(
    mobileAppPromotionId: json["mobileAppPromotionID"],
    mobileAppPromotionName: json["mobileAppPromotionName"],
    mobileAppPromotionDetail: json["mobileAppPromotionDetail"],
    mobileAppPromotionLink: json["mobileAppPromotionLink"],
    mobileAppPromotionDate: DateTime.parse(json["mobileAppPromotionDate"]),
    mobileAppPromotionTime: json["mobileAppPromotionTime"],
    autoNo: json["autoNo"],
  );

  Map<String, dynamic> toJson() => {
    "mobileAppPromotionID": mobileAppPromotionId,
    "mobileAppPromotionName": mobileAppPromotionName,
    "mobileAppPromotionDetail": mobileAppPromotionDetail,
    "mobileAppPromotionLink": mobileAppPromotionLink,
    "mobileAppPromotionDate": mobileAppPromotionDate.toIso8601String(),
    "mobileAppPromotionTime": mobileAppPromotionTime,
    "autoNo": autoNo,
  };
}
