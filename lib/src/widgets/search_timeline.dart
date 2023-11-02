import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class SearchTimeLinePage extends StatefulWidget {
  @override
  _SearchTimeLinePageState createState() => _SearchTimeLinePageState();
}

class _SearchTimeLinePageState extends State<SearchTimeLinePage> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _searchDetail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ค้นหาสินค้า",
          style: TextStyle(color: Constant.FONT_COLOR_MENU),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 24, color: Constant.FONT_COLOR_MENU),
                    keyboardType: TextInputType.text,
                    controller: _searchDetail,
                    autofocus: true,
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
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Constant.PRIMARY_COLOR,
                        //offset: Offset(1.0, 6.0),
                        //blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Constant.SECONDARY_COLOR,
                        //offset: Offset(1.0, 6.0),
                        //blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      "ค้นหา",
                      style: TextStyle(
                          color: Constant.FONT_COLOR,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // ignore: missing_return
                    onPressed: () {
                      Constant.searchDetail = _searchDetail.text;
                      print(Constant.searchDetail);
                      Navigator.pushReplacementNamed(
                          context, Constant.HOME_ROUTE);
                    },
                    //padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
