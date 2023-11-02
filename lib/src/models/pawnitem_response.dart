// To parse this JSON data, do
//
//     final pawnItemResponse = pawnItemResponseFromJson(jsonString);

import 'dart:convert';

List<PawnItemResponse> pawnItemResponseFromJson(String str) => List<PawnItemResponse>.from(json.decode(str).map((x) => PawnItemResponse.fromJson(x)));

String pawnItemResponseToJson(List<PawnItemResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PawnItemResponse {
  String pawnId;
  String branchName;
  String itemName;
  String itemPercent;
  int itemQty;
  double itemWeight;
  double itemPrice;
  int autoNo;

  PawnItemResponse({
    this.pawnId,
    this.branchName,
    this.itemName,
    this.itemPercent,
    this.itemQty,
    this.itemWeight,
    this.itemPrice,
    this.autoNo,
  });

  factory PawnItemResponse.fromJson(Map<String, dynamic> json) => PawnItemResponse(
    pawnId: json["pawnId"],
    branchName: json["branchName"],
    itemName: json["itemName"],
    itemPercent: json["itemPercent"],
    itemQty: json["itemQty"],
    itemWeight: json["itemWeight"].toDouble(),
    itemPrice: json["itemPrice"],
    autoNo: json["autoNo"],
  );

  Map<String, dynamic> toJson() => {
    "pawnId": pawnId,
    "branchName": branchName,
    "itemName": itemName,
    "itemPercent": itemPercent,
    "itemQty": itemQty,
    "itemWeight": itemWeight,
    "itemPrice": itemPrice,
    "autoNo": autoNo,
  };
}
