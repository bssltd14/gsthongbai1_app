import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/pages/mobileappnotisent_page.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Constant {
  // URL API
  static String URL_BSSCONFIGAPI =
      "http://150.95.88.227:1150/customerconfig/custapp/GS2020TB1";
  // static String URL_API = "";

  static String OneSignalAppId = "00d1b28f-deb0-46a8-816f-ab0828e4a566";
  static String OneSignalRestkey =
      "MDlhMzQyMjEtZWQ2Mi00MmZjLThhMWQtMjg2M2Q2NTRjODFj";

  // static String URL_BSSCONFIGAPI =
  //     "http://150.95.88.227:1150/customerconfig/GS2020";
  // static String URL_API = "http://150.95.88.227:2000/api";

  //Get MobileAppSetting
  static String TITLE_NAME = "";
  static String APP_NAME = "";
  static String ADDRESS1 = "";
  static String ADDRESS2 = "";
  static String ADDRESS3 = "";
  static String TELTEXT1 = "";
  static String TELTEXT2 = "";
  static String TELTEXT3 = "";
  static String TEL1 = "";
  static String TEL2 = "";
  static String TEL3 = "";
  static String LINE_ID = "";
  static String FACEBOOK_NAME = "";
  static String FACEBOOK_ID = "";
  static String INSTAGRAM = "";

  static Color PRIMARY_COLOR = Color(0xFFF99000);
  static Color SECONDARY_COLOR = Color(0xFFF99000);

  static Color FONT_COLOR_MENU = Color(0xFFF99000);
  static Color FONT_COLOR_PAGE = Color(0xFFFFFFFF);

  static String LAT1 = "";
  static String LAT2 = "";

  static String LNG1 = "";
  static String LNG2 = "";

  static int OverDayInt = 0;

  // shared preferences
  static const String IS_LOGIN_PREF = "is_login";
  static const String CUSTID_PREF = "custid";
  static const String CUSTNAME_PREF = "custname";
  static const String CUSTTEL_PREF = "custtel";
  static const String CUSTTHAIID_PREF = "custthaiid";
  static const String MEMBERID_PREF = "memberid";

//  Date Number
  static var formatDate = new DateFormat("dd/MM/yyyy");
  static var formatTime = new DateFormat("HH:mm");
  static var formatNumber = new NumberFormat("#,##0");
  static var formatNumber2 = new NumberFormat("#,##0.00");
  static var formatDateToDatabase = new DateFormat("yyyy-MM-dd");
  static var formatDateWhere = new DateFormat("MM/dd/yyyy");

//  userlogin
  static bool IS_LOGIN = false;
  static String CUSTID = "-";
  static String CUSTNAME = "ลูกค้าทั่วไป";
  static String CUSTTEL = "-";
  static String CUSTTHAIID = "-";
  static String MEMBERID = "";

  static String SERVERIP = "-";
  static String API = "-";
  static String CustomerId = "-";
  static String ServerId = "-";

  static String CUSTIDTEMP = "-";
  static String CUSTNAMETEMP = "ลูกค้าทั่วไป";
  static String CUSTTELTEMP = "-";
  static String CUSTTHAIIDTEMP = "-";
  static String MEMBERIDTEMP = "";
  static String MOBILEAPPPASSWORDTEMP = "-";

  //routes
  static const String HOME_ROUTE = "/home";
  static const String LOGIN_ROUTE = "/login";
  static const String DETAIL_ROUTE = "/youtube detail";
  static const String FAVORITE_ROUTE = "/favorite";
  static const String MAP_ROUTE = "/map";
  static const String TIMELINE_ROUTE = "/timeline";
  static const String SAVING_ROUTE = "/saving";
  static const String POINT_ROUTE = "/point";
  static const String PAWN_ROUTE = "/pawn";
  static const String SETTING_ROUTE = "/setting";

  //strings

  //fonts
  static const String QUICK_SAND_FONT = "Quicksand";
  static const String KANIT_FONT = "Kanit";

  //images
  static const String IMAGE_DIR = "assets/images";
  static const String HEADER_1_IMAGE = "$IMAGE_DIR/header_1.png";
  static const String HEADER_2_IMAGE = "$IMAGE_DIR/header_2.png";
  static const String HEADER_3_IMAGE = "$IMAGE_DIR/header_3.png";
  static const String CMDEV_LOGO_IMAGE = "$IMAGE_DIR/cmdev_logo.png";
  static const String PIN_MARKER = "$IMAGE_DIR/pin_marker.png";
  static const String PIN_CURRENT = "$IMAGE_DIR/pin_current.png";

  //color

  static const Color BLUE_COLOR = Colors.blueAccent;
  static const Color GRAY_COLOR = Color(0xFF666666);
  static const Color BG_COLOR = Color(0xFFF4F6F8);
  static const Color BG_WHITE_COLOR = Color(0xFFFFFFFF);
  static const Color BG_LOAD_COLOR = Color(0xFFe1e5e7);

  static Color FONTHEAD_COLOR = Colors.blueGrey[600];
  static Color FONT_COLOR = Colors.white;

  //random color
  static final Random _random = Random();

  // Returns a random color.
  static Color next() {
    return Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

  static String searchDetail = "";
  static String GoldPrice = "";
  static String GoldPriceSale = "";
  static String GoldPriceBuy = "";
  static String SavingId = "";

  static String MobileAppPaymentBranchName = "";
  static String MobileAppPaymentCustId = "";
  static String MobileAppPaymentType = "";
  static String MobileAppPaymentBillId = "";
  static String BankAcctNameSaving = "";
  static String BankAcctNoSaving = "";
  static String BankAccSaving = "";

  static String MobileAppPaymentIntBranchName = "";
  static String MobileAppPaymentIntCustId = "";
  static String MobileAppPaymentIntType = "";
  static String MobileAppPaymentIntBillId = "";
  static String IntPerMonth = "";
   static String BankInt = "";
  static String BankAcctNameInt = "";
  static String BankAcctNoInt = "";
  static String BankAccInt = "";
  static String Month = "";
  static String DueDate = "";

  static int CountUnreadNoti = 0;

  static DateTime SelectDate = DateTime.now();
  static TimeOfDay SelectTime = TimeOfDay.now();

  static DateTime searchNotiDateStart =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  static DateTime searchNotiDateEnd = DateTime.now();

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void handleClickNotification(BuildContext context) {
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      try {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MobileAppNotiSentPage()));
      } catch (e, stacktrace) {
        print(e);
      }
    });
  }

  static void delPayerId(String Custtel) async {
    // ลบ payer id ลง sql
    try {
      final status = await OneSignal.shared.getDeviceState();
      final String osUserID = status?.userId;
      print("Payer Id : ${osUserID}");

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'serverId': Constant.ServerId,
        'customerId': Constant.CustomerId
      };

      final url =
          '${Constant.API}/mobileappnoticonfig/deluser?custtel=${Custtel}&onesignaluserid=${osUserID}';
      final response = await http.put(Uri.parse(url), headers: requestHeaders);
      print(url);
      if (response.statusCode == 204) {
        print('del user complete ${Custtel}');
      } else {
        print('Failed to load del ${response.statusCode}');
      }
    } catch (_) {
      print("Error catch ${_}");
    }
  }

  static void savePayerId(String Custtel) async {
    // เพิ่ม payer id ลง sql
    try {
      final status = await OneSignal.shared.getDeviceState();
      final String osUserID = status?.userId;
      print("Payer Id : ${osUserID}");

      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'serverId': Constant.ServerId,
        'customerId': Constant.CustomerId
      };

      final url =
          '${Constant.API}/mobileappnoticonfig/adduser?custtel=${Custtel}&onesignaluserid=${osUserID}';
      final response = await http.put(Uri.parse(url), headers: requestHeaders);
      print(url);
      if (response.statusCode == 204) {
        print('save user complete ${Custtel}');
      } else {
        print('Failed to load save ${response.statusCode}');
      }
    } catch (_) {
      print("Error catch ${_}");
    }
  }
}
