import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsthongbai1app/src/pages/phonelogin_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/pages/readbeforesaving_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-white.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  _buildLogo(),
                  ..._buildComName(),
                  SizedBox(height: 5),
                  ..._buildList(context),
                  SizedBox(height: 10),
                  ..._buildLogInOut(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      //color: Color(0xFFfe0002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //margin: const EdgeInsets.all(40.0),
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo2.png"))),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    return <Widget>[];
  }

  List<Widget> _buildComName() {
    return <Widget>[
      SizedBox(
        height: 20,
      ),
      Text(
        "ห้างทองทองใบ ๑ นนทบุรี",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "729 ถ.พิบูลสงคราม ต.สวนใหญ่ อ.เมือง จ.นนทบุรี 11000",
        style: TextStyle(
          fontSize: 18,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "เวลาเปิด - ปิด 10.00-18.00 น.",
        style: TextStyle(
          fontSize: 18,
          color: Constant.FONT_COLOR_MENU,
        ),
      ),
      SizedBox(
        height: 30,
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
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "ห้างทอง ทองใบ ๑ นนทบุรี ",
                style: TextStyle(
                  fontSize: 20,
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
      InkWell(
        onTap: () {
          _makePhoneCall('tel:025251455');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.mobileAlt,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "02-5251455",
                style: TextStyle(
                  fontSize: 20,
                  color: Constant.FONT_COLOR_MENU,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
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
            fontSize: 20,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Constant.CUSTID,
          style: TextStyle(
            fontSize: 16,
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
            fontSize: 20,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          Constant.CUSTID,
          style: TextStyle(
            fontSize: 16,
            color: Constant.FONT_COLOR_MENU,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Constant.delPayerId(Constant.CUSTTEL);
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
                  color: Constant.FONT_COLOR_MENU,
                ),
                SizedBox(width: 8),
                Text(
                  "ออกจากระบบ",
                  style: TextStyle(
                    fontSize: 20, color: Constant.FONT_COLOR_MENU,
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

  void _SaveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constant.IS_LOGIN_PREF, Constant.IS_LOGIN);
    prefs.setString(Constant.CUSTID_PREF, Constant.CUSTID);
    prefs.setString(Constant.CUSTNAME_PREF, Constant.CUSTNAME);
    prefs.setString(Constant.CUSTTEL_PREF, Constant.CUSTTEL);
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
      fbProtocolUrl = "fb://profile/100057361603649";
    } else {
      fbProtocolUrl = "https://www.facebook.com/thongbai1nont";
    }

//    String fallbackUrl = 'https://www.facebook.com/page_name';
    String fallbackUrl =
        "https://www.facebook.com/thongbai1nont";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  _launchFacebook2() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = "fb://profile/100086191411782";
    } else {
      fbProtocolUrl = "fb://page/100086191411782";
    }

//    String fallbackUrl = 'https://www.facebook.com/page_name';
    String fallbackUrl =
        "https://www.facebook.com/thongbai1nont";
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

    lineProtocolUrl = "https://lin.ee/s0CydlL";
    print(lineProtocolUrl);
//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchLine2() async {
    String lineProtocolUrl;
    //officail account
//    lineProtocolUrl = "https://line.me/R/oaMessage/${Constant.LINE_ID}/";

    lineProtocolUrl = "https://lin.ee/gBJ1gul";
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

  _launchTiktok() async {
    String tikkokProtocolUrl = "https://www.tiktok.com/@thongbai1.gold";

    if (await canLaunch(tikkokProtocolUrl)) {
      return await launch(tikkokProtocolUrl, forceSafariVC: false);
    }
    throw 'Could not launch url';

    // const nativeUrl = "tiktok://user?username=@nomchok1668";
    // const webUrl = "https://www.tiktok.com/@nomchok1668/";
    // if (await canLaunch(nativeUrl)) {
    //   await launch(nativeUrl);
    // } else if (await canLaunch(webUrl)) {
    //   await launch(webUrl);
    // } else {
    //   print("can't open Tiktok");
    // }
  }

  _launchMap1() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/gU2ZUgy1KPYL56JWA";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/gU2ZUgy1KPYL56JWA";
    }

//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchMap2() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/CTLLZ6cjPnxscHrd6";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/CTLLZ6cjPnxscHrd6";
    }

//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchMap3() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/jNA6mjXVB1bicEpWA";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/jNA6mjXVB1bicEpWA";
    }

//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchMap4() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/R55d3AWK5tMnLKM4A";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/R55d3AWK5tMnLKM4A";
    }

    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchMap5() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/nwq7q2HRM77VFRkZ6";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/nwq7q2HRM77VFRkZ6";
    }

    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }

  _launchMap6() async {
    String lineProtocolUrl;
    if (Platform.isIOS) {
      lineProtocolUrl = "https://goo.gl/maps/nepMCBJjeVPXjwhRA";
    } else {
      lineProtocolUrl = "https://goo.gl/maps/nepMCBJjeVPXjwhRA";
    }

//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
    if (await canLaunch(lineProtocolUrl)) {
      return await launch(lineProtocolUrl);
    }

    throw 'Could not launch url';
  }
}

_launchWeb() async {
  String WebProtocolUrl = "https://www.sumphangold.com";

  if (await canLaunch(WebProtocolUrl)) {
    return await launch(WebProtocolUrl, forceSafariVC: false);
  }
  throw 'Could not launch url';

  // const nativeUrl = "tiktok://user?username=@nomchok1668";
  // const webUrl = "https://www.tiktok.com/@nomchok1668/";
  // if (await canLaunch(nativeUrl)) {
  //   await launch(nativeUrl);
  // } else if (await canLaunch(webUrl)) {
  //   await launch(webUrl);
  // } else {
  //   print("can't open Tiktok");
  // }
}
