import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/src/models/customer_response.dart';
import 'package:gsthongbai1app/src/pages/phoneverify_page.dart';
import 'package:gsthongbai1app/src/services/customer_service.dart';
import 'package:gsthongbai1app/src/themes/login_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final custtelController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  // default value is null
  String custtelError;
  String passwordError;
  String custtel;
  String custIDGet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: LoginTheme.gradient),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
//              Image.asset(
//                "assets/images/logo_1.png",
//                height: 200,
//              ),
              SizedBox(height: 20),
              _buildSignIn(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildSignIn() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 22),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 40),
            child: Column(
              children: <Widget>[
                _buildUsername(),
              ],
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    colors: [
                      LoginTheme.endColor,
                      LoginTheme.beginColor,
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: LoginTheme.beginColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: LoginTheme.endColor,
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
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    custtel = custtelController.text;

//                    สมมติว่าใส่เบอร์ไว้แล้ว
                    custtel = "0849726380";
                    if (custtel.length != 10) {
                      custtelError = "ใส่หมายเลขโทรศัพท์ 10 หลักเท่านั้น";
                      setState(() {});
                      return;
                    }
//                    // send sms
                    requestVerifyCode();

//                    Navigator.push(
//                        context, MaterialPageRoute(builder: (context) => PhoneVerifyPage(custtel)));

//otp

//                      Navigator.push(
//                          context, MaterialPageRoute(builder: (context) => PhoneVerifyPage()));

//                    print(custtel);
//                    custIDGet = "";
//                    fetchCustomer();
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 120,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    colors: [
                      LoginTheme.endColor,
                      LoginTheme.beginColor,
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: LoginTheme.beginColor,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: LoginTheme.endColor,
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
                  child: Text(
                    "ย้อนกลับ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildUsername() {
    return TextField(
      controller: custtelController,
      decoration: InputDecoration(
        errorText: custtelError,
        hintText: "0123456789",
        icon: Icon(Icons.mobile_screen_share),
        labelText: "หมายเลขโทรศัพท์",
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.phone,
    );
  }

  void showDialogInvid() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('เข้าสู่ระบบ'),
          content: Text('หมายเลขโทรศัพท์ไม่ถูกต้อง'),
          actions: <Widget>[
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);
  }

  Future<CustomerResponse> fetchCustomer() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'serverId': Constant.ServerId,
      'customerId': Constant.CustomerId
    };

    final response = await http.get(
        Uri.parse("${Constant.API}/Customer/$custtel"),
        headers: requestHeaders);
    print("fetchCustomer : $custtel");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final CustomerResponse customerResponse =
          CustomerResponse.fromJson(json.decode(response.body));
      print("fetchCustomer CustID" + customerResponse.custId);

      custIDGet = customerResponse.custId;
      Constant.IS_LOGIN = true;
      Constant.CUSTID = customerResponse.custId;
      Constant.CUSTNAME = customerResponse.custName;
      Constant.CUSTTEL = customerResponse.custTel;
      _SaveLogin();

      Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
    } else {
      showDialogInvid();
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load fetchCustomer');
    }
  }

  requestVerifyCode() {
    _auth.verifyPhoneNumber(
//        phoneNumber: "+66" + phoneController.text,
        phoneNumber: "+66849726380",
        timeout: const Duration(seconds: 5),
        verificationCompleted: (firebaseUser) {
          //
        },
        verificationFailed: (error) {
          print(
              'Phone number verification failed. Code: ${error.code}. Message: ${error.message}');
        },
        codeSent: (verificationId, [forceResendingToken]) {
//          setState(() {
//            _verificationId = verificationId;
//          });
          print(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          //
        });
  }
}
