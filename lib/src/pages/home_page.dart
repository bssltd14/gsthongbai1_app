import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
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

  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    TimeLinePage(),
    SavingMtPage(),
    // PointPage(),
    PawnPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? CurvedNavigationBar(
              color: Color(0xFFfefca7),
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.white,
              items: [
                const CurvedNavigationBarItem(
                    child: Icon(
                      Icons.home_outlined,color: Color(0xFF7a131a),size: 35,),
                    label: 'หน้าหลัก',
                    labelStyle: TextStyle(color: Color(0xFF7a131a))),
                const CurvedNavigationBarItem(
                    child:
                        Icon(Icons.savings, color: Color(0xFF7a131a), size: 35),
                    label: 'ออมทอง',
                    labelStyle: TextStyle(color: Color(0xFF7a131a))),
                // const CurvedNavigationBarItem(
                //     child:
                //         Icon(Icons.paypal, color: Color(0xFF7a131a), size: 35),
                //     label: 'คะแนน',
                //     labelStyle: TextStyle(color: Color(0xFF7a131a))),
                const CurvedNavigationBarItem(
                    child: Icon(Icons.account_balance,
                        color: Color(0xFF7a131a), size: 35),
                    label: 'ขายฝาก',
                    labelStyle: TextStyle(color: Color(0xFF7a131a))),
                const CurvedNavigationBarItem(
                    child: Icon(Icons.support_agent,
                        color: Color(0xFF7a131a), size: 35),
                    label: 'ติดต่อเรา',
                    labelStyle: TextStyle(color: Color(0xFF7a131a))),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                // log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
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
