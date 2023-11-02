import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsthongbai1app/src/pages/login_page.dart';
import 'package:gsthongbai1app/src/pages/otpscreen_page.dart';
import 'package:gsthongbai1app/src/pages/phonelogin_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/goldprice.dart';
import 'package:gsthongbai1app/src/widgets/search_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomWrapper extends StatefulWidget {
  final Widget child;

  const CustomWrapper({Key key, this.child}) : super(key: key);

  @override
  _CustomWrapperState createState() => _CustomWrapperState();
}

class _CustomWrapperState extends State<CustomWrapper>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _animateController;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animateController = AnimationController(vsync: this, duration: duration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animateController);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_animateController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_animateController);

    super.initState();
  }

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Stack(
      children: <Widget>[
        CustomDrawer(
          menuScaleAnimation: _menuScaleAnimation,
          slideAnimation: _slideAnimation,
        ),
        _buildCollapse()
      ],
    );
  }

  _buildCollapse() => AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.6 * screenWidth,
        right: isCollapsed ? 0 : -0.2 * screenWidth,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius:
                isCollapsed ? null : BorderRadius.all(Radius.circular(40)),
            elevation: 8,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Constant.FONT_COLOR_MENU,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isCollapsed) {
                                  _animateController.forward();
                                } else {
                                  _animateController.reverse();
                                }
                                isCollapsed = !isCollapsed;
                              });
                            },
                          ),
                          Text(
                            Constant.TITLE_NAME,
                            style: TextStyle(
                                fontSize: 20, color: Constant.FONT_COLOR_MENU),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Constant.FONT_COLOR_MENU,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchTimeLinePage(),
                                    ));
                              }),
                        ],
                      ),
                      BuildGoldPrice(),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isCollapsed
                      ? widget.child
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: widget.child,
                        ),
                )
              ],
            ),
          ),
        ),
      );
}

class CustomDrawer extends StatelessWidget {
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;

  const CustomDrawer({Key key, this.menuScaleAnimation, this.slideAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildLogo(),
              ..._buildComName(),
              SizedBox(height: 10),
              ..._buildList(context),
              Spacer(),
              ..._buildLogInOut(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    return <Widget>[
      InkWell(
        onTap: () {
          _launchLine();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.line,
                color: Colors.green,
              ),
              SizedBox(width: 12),
              Text(
                "Line",
                style: TextStyle(
                  fontSize: 16,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          //todo
          _launchFacebook();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
              SizedBox(width: 12),
              Text(
                "Facebook",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          //todo
          _launchInstagram();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.instagram,
                color: Colors.deepOrangeAccent,
              ),
              SizedBox(width: 12),
              Text(
                "Instagram",
                style: TextStyle(
                  fontSize: 16,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          //            14.3285946, 99.6608253 ตำแหน่งร้าน
          _launchMaps(
              lat: double.parse(Constant.LAT1),
              lng: double.parse(Constant.LNG1));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mapMarked,
                color: Colors.green,
              ),
              SizedBox(width: 12),
              Text(
                "Map",
                style: TextStyle(
                  fontSize: 16,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }

  Container _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.only(left: 20, bottom: 5),
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo.png"))),
    );
  }

  List<Widget> _buildComName() {
    return <Widget>[
      Text(
        Constant.TITLE_NAME,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "สาขา 1",
        style: TextStyle(
          fontSize: 16,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      Text(
        "774 ม.1 ต.ปะหลาน อ.พยัคฆ์ภูมิพิสัย จ.มหาสารคาม 44110",
        style: TextStyle(
          fontSize: 10,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      Text(
        "บรรทัด 2",
        style: TextStyle(
          fontSize: 10,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:043791117');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "043-791117",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "สาขาวาปีปทุม",
        style: TextStyle(
          fontSize: 16,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      Text(
        "240 ม.1 ต.หนองแสง อ.วาปีปทุม จ.มหาสารคาม 44120",
        style: TextStyle(
          fontSize: 10,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:0821244556');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "082-1244556",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:0885185668');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "088-5185668",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:044161116');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "044-161116",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        "สาขาพุทไธสง",
        style: TextStyle(
          fontSize: 16,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      Text(
        "186/1 ม.1 ต.มะเฟือง อ.พุทไธสง จ.บุรีรัมย์ 31120",
        style: TextStyle(
          fontSize: 10,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:0821244556');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "082-1244556",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: () {
          _makePhoneCall('tel:0885185668');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "088-5185668",
                style: TextStyle(
                  fontSize: 14,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildLogInOut(BuildContext context) {
    if (Constant.CUSTID == "-") {
      return <Widget>[
        Text(
          Constant.CUSTNAME,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Constant.CUSTID,
          style: TextStyle(
            fontSize: 14,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        PhoneLoginPage(),
      ];
    } else {
      return <Widget>[
        Text(
          Constant.CUSTNAME,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Constant.CUSTID,
          style: TextStyle(
            fontSize: 14,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Constant.IS_LOGIN = false;
            Constant.CUSTID = "-";
            Constant.CUSTNAME = "ลูกค้าทั่วไป";
            Constant.CUSTTEL = "";

            _SaveLogin();

            Navigator.pushReplacementNamed(context, Constant.HOME_ROUTE);
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: 130,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  FontAwesome.sign_out,
//                color: Colors.grey,
                ),
                SizedBox(width: 8),
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
        ),
      ];
    }
  }

  _launchMaps({double lat, double lng}) async {
    // Set Google Maps URL Scheme for iOS in info.plist (comgooglemaps)

    const googleMapSchemeIOS = 'comgooglemaps://';
    const googleMapURL = 'https://maps.google.com/';
    const appleMapURL = 'https://maps.apple.com/';
    final parameter = '?z=16&q=${Constant.LAT1},${Constant.LNG1}';

    if (Platform.isAndroid) {
      if (await canLaunch(googleMapURL)) {
        return await launch(googleMapURL + parameter);
      }
    } else {
      if (await canLaunch(googleMapSchemeIOS)) {
        return await launch(googleMapSchemeIOS + parameter);
      }
      if (await canLaunch(appleMapURL)) {
        return await launch(appleMapURL + parameter);
      }
    }

    throw 'Could not launch url';
  }

  _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
//      fbProtocolUrl = 'fb://profile/page_id';
      fbProtocolUrl = "fb://profile/${Constant.FACEBOOK_ID}";
    } else {
//      fbProtocolUrl = 'fb://page/page_id';
      fbProtocolUrl = "fb://page/${Constant.FACEBOOK_ID}";
    }

//    String fallbackUrl = 'https://www.facebook.com/page_name';
    String fallbackUrl = "https://www.facebook.com/${Constant.FACEBOOK_NAME}";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  _launchLine() async {
    String lineProtocolUrl;
    //officail account
//    lineProtocolUrl = "https://line.me/R/oaMessage/${Constant.LINE_ID}/";

    lineProtocolUrl = Constant.LINE_ID;
    print(lineProtocolUrl);
//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchInstagram() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://www.instagram.com/${Constant.INSTAGRAM}/";
    } else {
      lineProtocolUrl = "https://www.instagram.com/${Constant.INSTAGRAM}/";
    }

//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  // ignore: non_constant_identifier_names
  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);
  }
}

class PhoneLogInOTP extends StatefulWidget {
  PhoneLogInOTP({Key key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_phoneNumberController.text.length}");
    if (_phoneNumberController.text.length == 10) {
      updateState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.7,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'LOGIN',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            Text(
              'Login/Create Account quickly to manage orders',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
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
                  labelText: "10 digit mobile number",
                  prefix: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "+66",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                autocorrect: false,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: (value) {
                  return !isValid
                      ? 'Please provide a valid 10 digit phone number'
                      : null;
                },
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   child: Center(
            //     child: SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.85,
            //       child: RaisedButton(
            //         color: !isValid
            //             ? Theme.of(context).primaryColor.withOpacity(0.5)
            //             : Theme.of(context).primaryColor,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(0.0)),
            //         child: Text(
            //           !isValid ? "ENTER PHONE NUMBER" : "CONTINUE",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 18.0,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         onPressed: () {
            //           if (isValid) {
            //             print(_phoneNumberController.text);
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => OTPScreenPage(
            //                     mobileNumber: _phoneNumberController.text,
            //                   ),
            //                 ));
            //           } else {
            //             validate(state);
            //           }
            //         },
            //         padding: EdgeInsets.all(16.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}
