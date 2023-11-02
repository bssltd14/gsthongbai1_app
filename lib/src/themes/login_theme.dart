import 'package:flutter/material.dart';

//const LoginTheme()

class LoginTheme {
  const LoginTheme();
//
//  static const beginColor = const Color(0xFFfbab66);
//  static const endColor = const Color(0xFFf7418c);

//  static const beginColor = const Color(0xFFFFF8E1);
//  static const endColor = const Color(0xFFF79100);


  static const beginColor = const Color(0xFFB0BEC5);
  static const endColor = const Color(0xFF546E7A);

  static const gradient = const LinearGradient(
    colors: const [beginColor, endColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
}

