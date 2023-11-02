import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsthongbai1app/src/themes/login_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'otpinput_page.dart';

class OTPScreenPage extends StatefulWidget {
  final String mobileNumber;
  OTPScreenPage({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenPageState createState() => _OTPScreenPageState();
}

class _OTPScreenPageState extends State<OTPScreenPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Constant.FONT_COLOR_MENU);

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobiel ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "ส่งรหัส OTP ไปยังหมายเลข ${widget.mobileNumber}",
          style: TextStyle(color: Constant.FONT_COLOR_MENU, fontSize: 14),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: _pinDecoration,
                controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {
                    _onFormSubmitted();
                  } else {
                    showToast("OTP ไม่ถูกต้อง", Colors.red);
                  }
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
                    "ยืนยัน OTP",
                    style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (isCodeSent) {
                      if (_pinEditingController.text.length == 6) {
                        _onFormSubmitted();
                      } else {
                        showToast("OTP ไม่ถูกต้อง", Colors.red);
                      }
                    } else {
                      showToast("กรุณารอรหัส OTP สักครู่", Colors.red);
                    }
                  },
                  //padding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
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

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    // final PhoneVerificationCompleted verificationCompleted =
    //     (AuthCredential phoneAuthCredential) {
    //   // _firebaseAuth
    //   //     .signInWithCredential(phoneAuthCredential)
    //   //     .then((AuthResult value) {
    //   //   if (value.user != null) {
    //   //     // Handle loogged in state
    //   //     print(value.user.phoneNumber);

    //   _firebaseAuth.signInWithCredential(phoneAuthCredential).then((var value) {
    //     if (value.user != null) {
    //       // Handle loogged in state
    //       print(value.user.phoneNumber);

    //       Constant.IS_LOGIN = true;
    //       Constant.CUSTID = Constant.CUSTIDTEMP;
    //       Constant.CUSTNAME = Constant.CUSTNAMETEMP;
    //       Constant.CUSTTEL = Constant.CUSTTELTEMP;
    //       _SaveLogin();

    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => HomePage(),
    //           ),
    //           (Route<dynamic> route) => false);
    //     } else {
    //       showToast("เกิดข้อผิดพลาดในการตรวจสอบ OTP ลองอีกครั้ง", Colors.red);
    //     }
    //   }).catchError((error) {
    //     showToast("ไม่สามารถตรวจสอบ OTP ลองอีกครั้ง 1111", Colors.red);
    //   });
    // };
    final PhoneVerificationFailed verificationFailed = (final authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+66${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _pinEditingController.text = phoneAuthCredential.smsCode.toString();
        },
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth.signInWithCredential(_authCredential).then((final value) {
      if (value.user != null) {
        // Handle loogged in state
        print(value.user.phoneNumber);
//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(
//              builder: (context) => HomePageTest(
//                user: value.user,
//              ),
//            ),
//            (Route<dynamic> route) => false);

        Constant.IS_LOGIN = true;
        Constant.CUSTID = Constant.CUSTIDTEMP;
        Constant.CUSTNAME = Constant.CUSTNAMETEMP;
        Constant.CUSTTEL = Constant.CUSTTELTEMP;
        _SaveLogin();

//        Navigator.pushReplacementNamed(
//            context, Constant.HOME_ROUTE);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (Route<dynamic> route) => false);
      } else {
        showToast("เกิดข้อผิดพลาดในการตรวจสอบ OTP ลองอีกครั้ง", Colors.red);
      }
    }).catchError((error) {
      showToast("ไม่สามารถตรวจสอบ OTP ลองอีกครั้ง 2222", Colors.red);
    });
  }

  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);

    Constant.savePayerId(Constant.CUSTTEL);
  }
}
