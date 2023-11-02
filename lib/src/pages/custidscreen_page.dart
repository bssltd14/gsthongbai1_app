import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsthongbai1app/src/models/customer_response.dart';
import 'package:gsthongbai1app/src/themes/login_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';
import 'otpinput_page.dart';

class CustIDScreenPage extends StatefulWidget {
  final String mobileNumber;
  CustIDScreenPage({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _CustIDScreenPageState createState() => _CustIDScreenPageState();
}

class _CustIDScreenPageState extends State<CustIDScreenPage> {
  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Constant.FONT_COLOR_MENU);

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_pinEditingController.text.length}");
    if (_pinEditingController.text.length == 6) {
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
  Widget build(BuildContext context) {
    print("mobiel ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "กรอกรหัสลูกค้าที่ได้รับจากทางร้าน",
          style: TextStyle(color: Constant.FONT_COLOR_MENU, fontSize: 14),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child:
            StatefulBuilder(builder: (BuildContext context, StateSetter state) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.text,
                  controller: _pinEditingController,
                  autofocus: true,
                  onChanged: (text) {
                    validate(state);
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.login,
                    ),
                    labelText: "ใส่รหัสลูกค้า 6 หลัก",
                  ),
                  autocorrect: false,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value) {
                    return !isValid
                        ? 'กรุณาใส่รหัสลูกค้า 6 หลักเท่านั้น'
                        : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                //              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Constant.PRIMARY_COLOR,
                        Constant.SECONDARY_COLOR,
                      ],
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Constant.PRIMARY_COLOR,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Constant.SECONDARY_COLOR,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    //                    shape: RoundedRectangleBorder(
                    //                        borderRadius: BorderRadius.circular(0.0)),
                    child: Text(
                      !isValid ? "ใส่รหัสลูกค้า" : "ยืนยัน รหัสลูกค้า",
                      style: TextStyle(
                          color: Color(0xFFf0e19b),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (isValid) {
                        fetchCustTelAndCustId();
                      } else {
                        validate(state);
                      }
                    },
                    // padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        }),
      ),
    );
  }

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);

    Constant.savePayerId(Constant.CUSTTEL);
  }

  Future<CustomerResponse> fetchCustTelAndCustId() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final response = await http.get(
        Uri.parse(
            '${Constant.API}/Customer/custtelandcustid?searchcusttel=${widget.mobileNumber}&searchcustid=${_pinEditingController.text}'),
        headers: requestHeaders);
    print(
        "fetchCustTelAndCustId : searchcusttel=${widget.mobileNumber}&searchcustid=${_pinEditingController.text}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final CustomerResponse customerResponse =
          CustomerResponse.fromJson(json.decode(response.body));
      print("fetchCustTelAndCustId CustID" + customerResponse.custId);

      Constant.CUSTIDTEMP = customerResponse.custId;
      Constant.CUSTNAMETEMP = customerResponse.custName;
      Constant.CUSTTELTEMP = customerResponse.custTel;

      Constant.IS_LOGIN = true;
      Constant.CUSTID = Constant.CUSTIDTEMP;
      Constant.CUSTNAME = Constant.CUSTNAMETEMP;
      Constant.CUSTTEL = Constant.CUSTTELTEMP;
      _SaveLogin();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false);
    } else {
      showDialogInvid();
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load fetchCustTelAndCustId');
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
          content: Text('รหัสลูกค้าไม่ถูกต้อง',
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
