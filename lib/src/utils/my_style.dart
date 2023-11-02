import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Color.fromARGB(0xff, 0x00, 0x7d, 0x5f);
  Color lightColor = Color.fromARGB(0xff, 0x48, 0xad, 0x8c);
  Color dartColor = Color.fromARGB(0xff, 0x00, 0x50, 0x35);

  Color white1 = Colors.white54;

  double myIconSize = 36.0;

  TextStyle titleH1 = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(0xff, 0x00, 0x50, 0x35),
  );

  TextStyle titleH2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(0xff, 0x00, 0x50, 0x35),
  );

  TextStyle titleH3 = TextStyle(
    fontSize: 16.0,
    // fontWeight: FontWeight.bold,
    color: Color.fromARGB(0xff, 0x00, 0x50, 0x35),
  );

  Widget mySizebox = SizedBox(
    width: 5.0,
    height: 10.0,
  );

  MyStyle();
}
