import 'package:flutter/material.dart';

//const LoginTheme()

class PageTheme {
  const PageTheme();
//
//  static const beginColor = const Color(0xFFFFF8E1);
//  static const endColor = const Color(0xFFFF6F00);

  static const beginColor = const Color(0xFFFAFAFA);
  static const endColor = const Color(0xFFEEEEE);

  static const gradient = const LinearGradient(
    colors: const [beginColor, endColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
}

