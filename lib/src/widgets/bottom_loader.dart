import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  bool _showCircle = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: Visibility(
            visible:  _showCircle,
            child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
          
          )
          
        ),
      ),
    );
  }
}