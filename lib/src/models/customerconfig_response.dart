// To parse this JSON data, do
//
//     final customerConfigResponse = customerConfigResponseFromJson(jsonString);

import 'dart:convert';

CustomerConfigResponse customerConfigResponseFromJson(String str) =>
    CustomerConfigResponse.fromJson(json.decode(str));

String customerConfigResponseToJson(CustomerConfigResponse data) =>
    json.encode(data.toJson());

class CustomerConfigResponse {
  CustomerConfigResponse({
    this.custId,
    this.custName,
    this.contactName,
    this.custTel,
    this.serverIp,
    this.api,
    this.custType,
    this.autoNo,
    this.databaseName,
    this.custEmail,
  });

  String custId;
  String custName;
  String contactName;
  String custTel;
  String serverIp;
  String api;
  String custType;
  int autoNo;
  String databaseName;
  String custEmail;

  factory CustomerConfigResponse.fromJson(Map<String, dynamic> json) =>
      CustomerConfigResponse(
        custId: json["custID"] == null ? null : json["custID"],
        custName: json["custName"] == null ? null : json["custName"],
        contactName: json["contactName"] == null ? null : json["contactName"],
        custTel: json["custTel"] == null ? null : json["custTel"],
        serverIp: json["serverIP"] == null ? null : json["serverIP"],
        api: json["api"] == null ? null : json["api"],
        custType: json["custType"] == null ? null : json["custType"],
        autoNo: json["autoNo"] == null ? null : json["autoNo"],
        databaseName:
            json["databaseName"] == null ? null : json["databaseName"],
        custEmail: json["custEmail"] == null ? null : json["custEmail"],
      );

  Map<String, dynamic> toJson() => {
        "custID": custId == null ? null : custId,
        "custName": custName == null ? null : custName,
        "contactName": contactName == null ? null : contactName,
        "custTel": custTel == null ? null : custTel,
        "serverIP": serverIp == null ? null : serverIp,
        "api": api == null ? null : api,
        "custType": custType == null ? null : custType,
        "autoNo": autoNo == null ? null : autoNo,
        "databaseName": databaseName == null ? null : databaseName,
        "custEmail": custEmail == null ? null : custEmail,
      };
}
