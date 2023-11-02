import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildLogo(),
      ),
    );
  }

  Container _buildLogo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(50.0),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
