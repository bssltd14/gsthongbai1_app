// To parse this JSON data, do
//
//     final goldPriceResponse = goldPriceResponseFromJson(jsonString);

import 'dart:convert';

List<GoldPriceResponse> goldPriceResponseFromJson(String str) => List<GoldPriceResponse>.from(json.decode(str).map((x) => GoldPriceResponse.fromJson(x)));

String goldPriceResponseToJson(List<GoldPriceResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoldPriceResponse {
  GoldPriceResponse({
    this.name,
    this.bid,
    this.ask,
    this.diff,
  });

  String name;
  dynamic bid;
  dynamic ask;
  dynamic diff;

  factory GoldPriceResponse.fromJson(Map<String, dynamic> json) => GoldPriceResponse(
    name: json["name"],
    bid: json["bid"],
    ask: json["ask"],
    diff: json["diff"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "bid": bid,
    "ask": ask,
    "diff": diff,
  };
}
