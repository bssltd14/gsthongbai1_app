// To parse this JSON data, do
//
//     final pawnResponse = pawnResponseFromJson(jsonString);

import 'dart:convert';

List<PawnResponse> pawnResponseFromJson(String str) => List<PawnResponse>.from(
    json.decode(str).map((x) => PawnResponse.fromJson(x)));

String pawnResponseToJson(List<PawnResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PawnResponse {
  String pawnId;
  String branchName;
  String custName;
  double intrate;
  double amountget;
  double intamount;
  double intpay;
  DateTime inDate;
  DateTime outDate;
  DateTime duedate;
  int months;
  String remark;
  String sumDescription;
  double sumItemwt;
  String custTel;
  String custThaiId;
  String custId;
  String empName;
  int sumItemQty;
  int autoNo;
  String outStatus;
  String mobileTranBankInt;
  String mobileTranBankAcctNoInt;
  String mobileTranBankAcctNameInt;

  PawnResponse({
    this.pawnId,
    this.branchName,
    this.custName,
    this.intrate,
    this.amountget,
    this.intamount,
    this.intpay,
    this.inDate,
    this.outDate,
    this.duedate,
    this.months,
    this.remark,
    this.sumDescription,
    this.sumItemwt,
    this.custTel,
    this.custThaiId,
    this.custId,
    this.empName,
    this.sumItemQty,
    this.autoNo,
    this.outStatus,
    this.mobileTranBankInt,
    this.mobileTranBankAcctNoInt,
    this.mobileTranBankAcctNameInt,
  });

  factory PawnResponse.fromJson(Map<String, dynamic> json) => PawnResponse(
        pawnId: json["pawnId"],
        branchName: json["branchName"],
        custName: json["custName"],
        intrate: json["intrate"],
        amountget: json["amountget"],
        intamount: json["intamount"],
        intpay: json["intpay"],
        inDate: DateTime.parse(json["inDate"]),
        outDate: json["outDate"],
        duedate: DateTime.parse(json["duedate"]),
        months: json["months"],
        remark: json["remark"],
        sumDescription: json["sumDescription"],
        sumItemwt: json["sumItemwt"].toDouble(),
        custTel: json["custTel"],
        custThaiId: json["custThaiId"],
        custId: json["custId"],
        empName: json["empName"],
        sumItemQty: json["sumItemQty"],
        autoNo: json["autoNo"],
        outStatus: json["outStatus"],
        mobileTranBankInt:
            json["mobileTranBankInt"] == null ? "" : json["mobileTranBankInt"],
        mobileTranBankAcctNoInt: json["mobileTranBankAcctNoInt"] == null
            ? ""
            : json["mobileTranBankAcctNoInt"],
        mobileTranBankAcctNameInt: json["mobileTranBankAcctNameInt"] == null
            ? ""
            : json["mobileTranBankAcctNameInt"],
      );

  Map<String, dynamic> toJson() => {
        "pawnId": pawnId,
        "branchName": branchName,
        "custName": custName,
        "intrate": intrate,
        "amountget": amountget,
        "intamount": intamount,
        "intpay": intpay,
        "inDate": inDate.toIso8601String(),
        "outDate": outDate,
        "duedate": duedate.toIso8601String(),
        "months": months,
        "remark": remark,
        "sumDescription": sumDescription,
        "sumItemwt": sumItemwt,
        "custTel": custTel,
        "custThaiId": custThaiId,
        "custId": custId,
        "empName": empName,
        "sumItemQty": sumItemQty,
        "autoNo": autoNo,
        "outStatus": outStatus,
        "mobileTranBankInt":
            mobileTranBankInt == null ? null : mobileTranBankInt,
        "mobileTranBankAcctNoInt":
            mobileTranBankAcctNoInt == null ? null : mobileTranBankAcctNoInt,
        "mobileTranBankAcctNameInt": mobileTranBankAcctNameInt == null
            ? null
            : mobileTranBankAcctNameInt,
      };
}
