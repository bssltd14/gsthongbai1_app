// To parse this JSON data, do
//
//     final pawnDtResponse = pawnDtResponseFromJson(jsonString);

import 'dart:convert';

List<PawnDtResponse> pawnDtResponseFromJson(String str) =>
    List<PawnDtResponse>.from(
        json.decode(str).map((x) => PawnDtResponse.fromJson(x)));

String pawnDtResponseToJson(List<PawnDtResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PawnDtResponse {
  String pawnId;
  String branchName;
  double amountPay;
  DateTime dueDate;
  DateTime payDate;
  int autoNo;
  int dayPay;
  int monthPay;
  String prTime;

  PawnDtResponse({
    this.pawnId,
    this.branchName,
    this.amountPay,
    this.dueDate,
    this.payDate,
    this.autoNo,
    this.dayPay,
    this.monthPay,
    this.prTime,
  });

  factory PawnDtResponse.fromJson(Map<String, dynamic> json) => PawnDtResponse(
        pawnId: json["pawnId"] == null ? null : json["pawnId"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        amountPay:
            json["amountPay"] == null ? null : json["amountPay"].toDouble(),
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        payDate:
            json["payDate"] == null ? null : DateTime.parse(json["payDate"]),
        autoNo: json["autoNo"] == null ? null : json["autoNo"],
        dayPay: json["dayPay"] == null ? null : json["dayPay"],
        monthPay: json["monthPay"] == null ? null : json["monthPay"],
        prTime: json["prTime"] == null ? null : json["prTime"],
      );

  Map<String, dynamic> toJson() => {
        "pawnId": pawnId == null ? null : pawnId,
        "branchName": branchName == null ? null : branchName,
        "amountPay": amountPay == null ? null : amountPay,
        "dueDate": dueDate == null ? null : dueDate.toIso8601String(),
        "payDate": payDate == null ? null : payDate.toIso8601String(),
        "autoNo": autoNo == null ? null : autoNo,
        "dayPay": dayPay == null ? null : dayPay,
        "monthPay": monthPay == null ? null : monthPay,
        "prTime": prTime == null ? null : prTime,
      };
}
