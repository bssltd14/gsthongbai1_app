import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/pages/mobileapppayment_page.dart';
import 'package:gsthongbai1app/src/pages/pawn_page.dart';
import 'package:gsthongbai1app/src/pages/point_page.dart';
import 'package:gsthongbai1app/src/pages/savingmt_page.dart';
import 'package:gsthongbai1app/src/pages/setting_page.dart';
import 'package:gsthongbai1app/src/pages/timeline_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Constant.handleClickNotification(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    TimeLinePage(),
    SavingMtPage(),
    // PointPage(),
    // PawnPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[_pages[_currentIndex]],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('หน้าหลัก'),
              icon: Icon(Icons.home),
              inactiveColor: Color(0xFF990000),
              activeColor: Color(0xFF990000)),
          BottomNavyBarItem(
              title: Text('ออมทอง'),
              icon: Icon(Icons.monetization_on),
              inactiveColor: Color(0xFF990000),
              activeColor: Color(0xFF990000)),
          // BottomNavyBarItem(
          //     title: Text('คะแนน'),
          //     icon: Icon(Icons.control_point),
          //     inactiveColor: Color(0xFF990000),
          //     activeColor: Color(0xFF990000)),
          // BottomNavyBarItem(
          //     title: Text('ขายฝาก'),
          //     icon: Icon(Icons.account_balance),
          //     inactiveColor: Color(0xFF990000),
          //     activeColor: Color(0xFF990000)),
          BottomNavyBarItem(
              title: Text('ติดต่อเรา'),
              icon: Icon(Icons.menu),
              inactiveColor: Color(0xFF990000),
              activeColor: Color(0xFF990000)),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
}
