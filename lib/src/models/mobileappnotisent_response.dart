// To parse this JSON data, do
//
//     final mobileAppNotiSentResponse = mobileAppNotiSentResponseFromJson(jsonString);

import 'dart:convert';

List<MobileAppNotiSentResponse> mobileAppNotiSentResponseFromJson(String str) =>
    List<MobileAppNotiSentResponse>.from(
        json.decode(str).map((x) => MobileAppNotiSentResponse.fromJson(x)));

String mobileAppNotiSentResponseToJson(List<MobileAppNotiSentResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MobileAppNotiSentResponse {
  MobileAppNotiSentResponse({
    this.autoNo,
    this.branchName,
    this.notiDate,
    this.notiTime,
    this.notiTitle,
    this.notiRefNo,
    this.notiDetail,
    this.custTel,
    this.statusCheckNoti,
  });

  int autoNo;
  String branchName;
  DateTime notiDate;
  String notiTime;
  String notiTitle;
  String notiRefNo;
  String notiDetail;
  String custTel;
  bool statusCheckNoti;

  factory MobileAppNotiSentResponse.fromJson(Map<String, dynamic> json) =>
      MobileAppNotiSentResponse(
        autoNo: json["autoNo"] == null ? null : json["autoNo"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        notiDate:
            json["notiDate"] == null ? null : DateTime.parse(json["notiDate"]),
        notiTime: json["notiTime"] == null ? null : json["notiTime"],
        notiTitle: json["notiTitle"] == null ? null : json["notiTitle"],
        notiRefNo: json["notiRefNo"] == null ? null : json["notiRefNo"],
        notiDetail: json["notiDetail"] == null ? null : json["notiDetail"],
        custTel: json["custTel"] == null ? null : json["custTel"],
        statusCheckNoti:
            json["statusCheckNoti"] == null ? null : json["statusCheckNoti"],
      );

  Map<String, dynamic> toJson() => {
        "autoNo": autoNo == null ? null : autoNo,
        "branchName": branchName == null ? null : branchName,
        "notiDate": notiDate == null ? null : notiDate.toIso8601String(),
        "notiTime": notiTime == null ? null : notiTime,
        "notiTitle": notiTitle == null ? null : notiTitle,
        "notiRefNo": notiRefNo == null ? null : notiRefNo,
        "notiDetail": notiDetail == null ? null : notiDetail,
        "custTel": custTel == null ? null : custTel,
        "statusCheckNoti": statusCheckNoti == null ? null : statusCheckNoti,
      };
}
