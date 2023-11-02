// To parse this JSON data, do
//
//     final savingMtResponse = savingMtResponseFromJson(jsonString);

import 'dart:convert';

List<SavingMtResponse> savingMtResponseFromJson(String str) =>
    List<SavingMtResponse>.from(
        json.decode(str).map((x) => SavingMtResponse.fromJson(x)));

String savingMtResponseToJson(List<SavingMtResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavingMtResponse {
  SavingMtResponse({
    this.savingId,
    this.custId,
    this.custTel,
    this.custThaiId,
    this.custName,
    this.branchName,
    this.savingDate,
    this.savingDueDate,
    this.totalPrice,
    this.totalPay,
    this.totalRemain,
    this.sumDescription,
    this.sumItemwt,
    this.sumItemQty,
    this.empName,
    this.months,
    this.autoNo,
    this.mobileTranBankSaving,
    this.mobileTranBankAcctNoSaving,
    this.mobileTranBankAcctNameSaving,
  });

  String savingId;
  String custId;
  String custTel;
  String custThaiId;
  String custName;
  String branchName;
  DateTime savingDate;
  DateTime savingDueDate;
  double totalPrice;
  double totalPay;
  double totalRemain;
  String sumDescription;
  double sumItemwt;
  int sumItemQty;
  String empName;
  int months;
  int autoNo;
  String mobileTranBankSaving;
  String mobileTranBankAcctNoSaving;
  String mobileTranBankAcctNameSaving;

  factory SavingMtResponse.fromJson(Map<String, dynamic> json) =>
      SavingMtResponse(
        savingId: json["savingId"] == null ? null : json["savingId"],
        custId: json["custId"] == null ? null : json["custId"],
        custTel: json["custTel"] == null ? null : json["custTel"],
        custThaiId: json["custThaiId"] == null ? null : json["custThaiId"],
        custName: json["custName"] == null ? null : json["custName"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        savingDate: json["savingDate"] == null
            ? null
            : DateTime.parse(json["savingDate"]),
        savingDueDate: json["savingDueDate"] == null
            ? null
            : DateTime.parse(json["savingDueDate"]),
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
        totalPay: json["totalPay"] == null ? null : json["totalPay"].toDouble(),
        totalRemain:
            json["totalRemain"] == null ? null : json["totalRemain"].toDouble(),
        sumDescription:
            json["sumDescription"] == null ? null : json["sumDescription"],
        sumItemwt:
            json["sumItemwt"] == null ? null : json["sumItemwt"].toDouble(),
        sumItemQty: json["sumItemQty"] == null ? null : json["sumItemQty"],
        empName: json["empName"] == null ? null : json["empName"],
        months: json["months"] == null ? null : json["months"],
        autoNo: json["autoNo"] == null ? null : json["autoNo"],
        mobileTranBankSaving: json["mobileTranBankSaving"] == null
            ? ""
            : json["mobileTranBankSaving"],
        mobileTranBankAcctNoSaving: json["mobileTranBankAcctNoSaving"] == null
            ? ""
            : json["mobileTranBankAcctNoSaving"],
        mobileTranBankAcctNameSaving:
            json["mobileTranBankAcctNameSaving"] == null
                ? ""
                : json["mobileTranBankAcctNameSaving"],
      );

  Map<String, dynamic> toJson() => {
        "savingId": savingId == null ? null : savingId,
        "custId": custId == null ? null : custId,
        "custTel": custTel == null ? null : custTel,
        "custThaiId": custThaiId == null ? null : custThaiId,
        "custName": custName == null ? null : custName,
        "branchName": branchName == null ? null : branchName,
        "savingDate": savingDate == null ? null : savingDate.toIso8601String(),
        "savingDueDate":
            savingDueDate == null ? null : savingDueDate.toIso8601String(),
        "totalPrice": totalPrice == null ? null : totalPrice,
        "totalPay": totalPay == null ? null : totalPay,
        "totalRemain": totalRemain == null ? null : totalRemain,
        "sumDescription": sumDescription == null ? null : sumDescription,
        "sumItemwt": sumItemwt == null ? null : sumItemwt,
        "sumItemQty": sumItemQty == null ? null : sumItemQty,
        "empName": empName == null ? null : empName,
        "months": months == null ? null : months,
        "autoNo": autoNo == null ? null : autoNo,
        "mobileTranBankSaving":
            mobileTranBankSaving == null ? null : mobileTranBankSaving,
        "mobileTranBankAcctNoSaving": mobileTranBankAcctNoSaving == null
            ? null
            : mobileTranBankAcctNoSaving,
        "mobileTranBankAcctNameSaving": mobileTranBankAcctNameSaving == null
            ? null
            : mobileTranBankAcctNameSaving,
      };
}
