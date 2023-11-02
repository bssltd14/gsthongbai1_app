import 'dart:convert';
import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsthongbai1app/src/models/customerconfig_response.dart';
import 'package:gsthongbai1app/src/models/mobileappsetting_response.dart';
import 'package:gsthongbai1app/src/pages/start_page.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/pawn_page.dart';
import 'pages/point_page.dart';
import 'pages/saving_page.dart';
import 'pages/timeline_page.dart';
import 'utils/constant.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _route = <String, WidgetBuilder>{
    Constant.HOME_ROUTE: (context) => HomePage(),
    Constant.LOGIN_ROUTE: (context) => LoginPage(),
    Constant.TIMELINE_ROUTE: (context) => TimeLinePage(),
    Constant.SAVING_ROUTE: (context) => SavingPage(),
    Constant.POINT_ROUTE: (context) => PointPage(),
    Constant.PAWN_ROUTE: (context) => PawnPage(),
  };

  @override
  void initState() {
    super.initState();
    _mapGetLogin();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: Colors.white, // this one for android
    //     statusBarBrightness: Brightness.light // this one for iOS
    //     ));
    return MaterialApp(
      title: Constant.TITLE_NAME,
      routes: _route,
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert( 
       upgrader: Upgrader(
        shouldPopScope: () => true,
        canDismissDialog: true,
        showReleaseNotes: false,
        showIgnore: false,
        dialogStyle:  Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        durationUntilAlertAgain: const Duration(days: 1),
        ),
        child : FutureBuilder(
        future: _GetMobileAppSetting(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return HomePage();
            }
            return StartPage();
          }
          return StartPage();
        },
      )),
      theme: new ThemeData(
        fontFamily: 'SUPERMARKET',
      ),
    );
  }

 Future<bool> _GetMobileAppSetting() async {
    try {
      //หา server และ database
      final responseServerDatabase =
          await http.get(Uri.parse('${Constant.URL_BSSCONFIGAPI}'));
      print("responseServerDatabase : ${Constant.URL_BSSCONFIGAPI}");

      if (responseServerDatabase.statusCode == 200) {
        final CustomerConfigResponse customerConfigResponse =
            CustomerConfigResponse.fromJson(
                json.decode(responseServerDatabase.body));
        print("fetchCustomer API " + customerConfigResponse.api);
        print("fetchCustomer ServerIP " + customerConfigResponse.serverIp);
        print("fetchCustomer DatabaseName " +
            customerConfigResponse.databaseName);

        Constant.SERVERIP = customerConfigResponse.serverIp;
        Constant.API = customerConfigResponse.api;
        Constant.CustomerId = customerConfigResponse.databaseName;
        Constant.ServerId = customerConfigResponse.serverIp;

        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'serverId': Constant.ServerId,
          'customerId': Constant.CustomerId
        };

        final response = await http.get(
            Uri.parse('${Constant.API}/mobileappsetting'),
            headers: requestHeaders);
        print("fetch: mobileappsetting");
        print('${Constant.API}/mobileappsetting');

        if (response.statusCode == 200) {
          print("statuscode 200");
          // If the server did return a 200 OK response,
          // then parse the JSON.
          final MobileAppSettingResponse mobileAppSettingResponse =
              MobileAppSettingResponse.fromJson(json.decode(response.body));

          print("fetchMobileAppSetting AppName Complete");

          Constant.TITLE_NAME = mobileAppSettingResponse.appName;
          Constant.APP_NAME = mobileAppSettingResponse.appName;
          Constant.ADDRESS1 = mobileAppSettingResponse.address1;
          Constant.ADDRESS2 = mobileAppSettingResponse.address2;
          Constant.ADDRESS3 = mobileAppSettingResponse.address3;
          Constant.TELTEXT1 = mobileAppSettingResponse.telText1;
          Constant.TELTEXT2 = mobileAppSettingResponse.telText2;
          Constant.TELTEXT3 = mobileAppSettingResponse.telText3;
          Constant.TEL1 = mobileAppSettingResponse.tel1;
          Constant.TEL2 = mobileAppSettingResponse.tel2;
          Constant.TEL3 = mobileAppSettingResponse.tel3;
          Constant.LINE_ID = mobileAppSettingResponse.lineId;
          Constant.FACEBOOK_NAME = mobileAppSettingResponse.facebookName;
          Constant.FACEBOOK_ID = mobileAppSettingResponse.facebookId;
          Constant.INSTAGRAM = mobileAppSettingResponse.instagram;

          Constant.PRIMARY_COLOR =
              Color(int.parse(mobileAppSettingResponse.primaryColor));
          Constant.SECONDARY_COLOR =
              Color(int.parse(mobileAppSettingResponse.secondaryColor));

          Constant.FONT_COLOR_MENU =
              Color(int.parse(mobileAppSettingResponse.fontColorMenu));
          Constant.FONT_COLOR_PAGE =
              Color(int.parse(mobileAppSettingResponse.fontColorPage));

          Constant.LAT1 = mobileAppSettingResponse.lat1;
          Constant.LAT2 = mobileAppSettingResponse.lat2;

          Constant.LNG1 = mobileAppSettingResponse.lng1;
          Constant.LNG2 = mobileAppSettingResponse.lng2;

          Constant.OverDayInt = mobileAppSettingResponse.overDayInt;

          print("fetchMobileAppSetting Complete");
          return true;
        } else {
          print("fetchMobileAppSetting Not Complete");
          return false;
        }
      } else {
        print("responseServerDatabase Not Complete");
        return false;
      }
    } catch (_) {
      print("${_}");
    }
  }
}

_mapGetLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constant.IS_LOGIN = prefs.getBool(Constant.IS_LOGIN_PREF) ?? false;
    Constant.CUSTID = prefs.getString(Constant.CUSTID_PREF) ?? "-";
    Constant.CUSTNAME =
        prefs.getString(Constant.CUSTNAME_PREF) ?? "ลูกค้าทั่วไป";
    Constant.CUSTTEL = prefs.getString(Constant.CUSTTEL_PREF) ?? "-";

    print(Constant.CUSTNAME);
  }


