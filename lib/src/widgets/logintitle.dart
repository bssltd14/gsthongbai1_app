import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/pages/phonelogin_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginTitle extends StatefulWidget {
  @override
  _LoginTitleState createState() => _LoginTitleState();
}

class _LoginTitleState extends State<LoginTitle> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return (Constant.CUSTID == "-")
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    Constant.CUSTNAME,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    Constant.CUSTID,
                    style: TextStyle(
                      fontSize: 14,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              PhoneLoginPage(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    Constant.CUSTNAME,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    Constant.CUSTID,
                    style: TextStyle(
                      fontSize: 14,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Constant.IS_LOGIN = false;
                  Constant.CUSTID = "-";
                  Constant.CUSTNAME = "ลูกค้าทั่วไป";
                  Constant.CUSTTEL = "";

                  _SaveLogin();

                  Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesome.sign_out,
                      size: 18,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                    Text(
                      "ออกจากระบบ",
                      style: TextStyle(
                        fontSize: 18, color: Constant.FONT_COLOR_MENU,
//                  color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);
  }
}

// List<Widget> _buildLogInOut(BuildContext context) {
//   if (Constant.CUSTID == "-") {
//     return <Widget>[
//       Text(
//         Constant.CUSTNAME,
//         style: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 18,
//           color: Constant.FONT_COLOR_MENU,
//         ),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Text(
//         Constant.CUSTID,
//         style: TextStyle(
//           fontSize: 14,
//           color: Constant.FONT_COLOR_MENU,
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       PhoneLoginPage(),
//     ];
//   } else {
//     return <Widget>[
//       Text(
//         Constant.CUSTNAME,
//         style: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 18,
//           color: Constant.FONT_COLOR_MENU,
//         ),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Text(
//         Constant.CUSTID,
//         style: TextStyle(
//           fontSize: 14,
//           color: Constant.FONT_COLOR_MENU,
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       InkWell(
//         onTap: () {
//           Constant.IS_LOGIN = false;
//           Constant.CUSTID = "-";
//           Constant.CUSTNAME = "ลูกค้าทั่วไป";
//           Constant.CUSTTEL = "";

//           _SaveLogin();

//           Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
//         },
//         child: Padding(
//           padding: EdgeInsets.only(
//             right: 130,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 FontAwesome.sign_out,
// //                color: Colors.grey,
//               ),
//               SizedBox(width: 8),
//               Text(
//                 "ออกจากระบบ",
//                 style: TextStyle(
//                   fontSize: 18, color: Constant.FONT_COLOR_MENU,
// //                  color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ];
//   }
// }
