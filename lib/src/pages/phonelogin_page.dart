import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gsthongbai1app/src/models/customer_response.dart';
import 'package:gsthongbai1app/src/pages/passwordscreen_page.dart';
import 'package:gsthongbai1app/src/pages/readbeforesaving_page.dart';
import 'package:http/http.dart' as http;
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/pages/readbeforesaving_page.dart';

class PhoneLoginPage extends StatefulWidget {
  PhoneLoginPage({Key key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();

  String custtel;
  String custIDGet;
  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_phoneNumberController.text.length}");
    if (_phoneNumberController.text.length == 10) {
      updateState(() {
        isValid = true;
      });
    } else {
      updateState(() {
        isValid = false;
      });
    }
  }

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
       showDialog(
      context: context,
      builder: (context) {
        return readbeforesaving(mdFileName: 'ReadBeforeSaving.md');
      },
    );
    });

   
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("pressed");
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bc) {
              print("VALID CC: $isValid");

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter state) {
                return Container(
                  padding: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Constant.FONT_COLOR_MENU),
                      ),
                      Text(
                        'ใส่หมายเลขโทรศัพท์เพื่อเข้าสู่ระบบ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Constant.FONT_COLOR_MENU),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          keyboardType: TextInputType.number,
                          controller: _phoneNumberController,
                          autofocus: true,
                          onChanged: (text) {
                            validate(state);
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.mobile_screen_share,
                            ),
                            labelText: "ใส่หมายเลขโทรศัพท์ 10 หลัก",
                          ),
                          autocorrect: false,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          validator: (value) {
                            return !isValid
                                ? 'กรุณาใส่หมายเลขโทรศัพท์ 10 หลักเท่านั้น'
                                : null;
                          },
                        ),
                      ),
                      !isValid
                          ? SizedBox(height: 10)
                          : Container(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Constant.PRIMARY_COLOR,
                                        Constant.SECONDARY_COLOR,
                                      ],
                                    ),
                                  ),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      "เข้าสู่ระบบ",
                                      style: TextStyle(
                                          color: Color(0xFFf0e19b),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // ignore: missing_return
                                    onPressed: () {
                                      if (isValid) {
                                        print(_phoneNumberController.text);
                                        custIDGet = "";
                                        fetchCustomerID();
                                      } else {
                                        validate(state);
                                      }
                                    },
                                    // padding: EdgeInsets.all(16.0),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              });
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            FontAwesome.sign_in,
            color: Constant.FONT_COLOR_MENU,
          ),
          SizedBox(width: 8),
          Text(
            "เข้าสู่ระบบ",
            style: TextStyle(
              fontSize: 18, color: Constant.FONT_COLOR_MENU,
//                  color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Future<CustomerResponse> fetchCustomerID() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final response = await http.get(
        Uri.parse('${Constant.API}/Customer/${_phoneNumberController.text}'),
        headers: requestHeaders);
    print("fetchCustomer : ${_phoneNumberController.text}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final CustomerResponse customerResponse =
          CustomerResponse.fromJson(json.decode(response.body));
      print("fetchCustomer CustID" + customerResponse.custId);

      custIDGet = customerResponse.custId;
      Constant.CUSTIDTEMP = customerResponse.custId;
      Constant.CUSTNAMETEMP = customerResponse.custName;
      Constant.CUSTTELTEMP = customerResponse.custTel;
      Constant.CUSTTHAIIDTEMP = customerResponse.custThaiId;
      Constant.MEMBERIDTEMP = customerResponse.memberId;
      Constant.MOBILEAPPPASSWORDTEMP = customerResponse.mobileAppPassword;

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordScreenPage(
              mobileNumber: _phoneNumberController.text,
            ),
          ));
    } else {
      showDialogInvid();
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load fetchCustomer');
    }
  }

  void showDialogInvid() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('เข้าสู่ระบบ',
              style: TextStyle(color: Constant.FONT_COLOR_MENU)),
          content: Text('หมายเลขโทรศัพท์ไม่ถูกต้อง',
              style: TextStyle(color: Constant.FONT_COLOR_MENU)),
          actions: <Widget>[
            TextButton(
              child: Text('ตกลง',
                  style: TextStyle(color: Constant.FONT_COLOR_MENU)),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
