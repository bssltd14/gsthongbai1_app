import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/pages/readbeforesaving_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class TermsOfUser extends StatelessWidget {
  const TermsOfUser ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "สำคัญ..โปรดอ่าน 11 ข้อต้องรู้ ทำความเข้าใจก่อนออมทอง",
          style:  
          TextStyle(
            fontSize: 20,
            color: Constant.FONT_COLOR_MENU,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {
            //เปิด dialog ของ 10 ควรรู้
            showDialog(context: context, builder: (context){
              return readbeforesaving(mdFileName: 'ReadBeforeSaving.md');
            },);
          }
        )
      ),
      );

  }
}