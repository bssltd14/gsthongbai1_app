import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchNotiSentDatePage extends StatefulWidget {
  @override
  _SearchNotiSentDatePageState createState() => _SearchNotiSentDatePageState();
}

class _SearchNotiSentDatePageState extends State<SearchNotiSentDatePage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ค้นหา",
          style: TextStyle(color: Constant.FONT_COLOR_MENU),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
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
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Constant.PRIMARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    //   BoxShadow(
                    //     color: Constant.SECONDARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    // ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      "ตั้งแต่วันที่ ${Constant.formatDate.format(Constant.searchNotiDateStart)}",
                      style: TextStyle(
                          color: Color(0xFFf0e19b),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // ignore: missing_return
                    onPressed: () {
                      _selectDateStart(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
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
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Constant.PRIMARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    //   BoxShadow(
                    //     color: Constant.SECONDARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    // ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      "ถึงวันที่ ${Constant.formatDate.format(Constant.searchNotiDateEnd)}",
                      style: TextStyle(
                          color: Color(0xFFf0e19b),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // ignore: missing_return
                    onPressed: () {
                      _selectDateEnd(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
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
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Constant.PRIMARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    //   BoxShadow(
                    //     color: Constant.SECONDARY_COLOR,
                    //     offset: Offset(1.0, 6.0),
                    //     blurRadius: 20.0,
                    //   ),
                    // ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      "ค้นหา",
                      style: TextStyle(
                          color: Color(0xFFf0e19b),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // ignore: missing_return
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDateStart(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        Constant.searchNotiDateStart = selectedDate;
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        Constant.searchNotiDateEnd = selectedDate;
      });
  }
}
