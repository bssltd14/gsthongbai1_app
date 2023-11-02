import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/models/viewapimap_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class TimeLineImagePage extends StatelessWidget {
  final ViewAPIMAPResponse post;

  const TimeLineImagePage({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.mobileAppPromotionName,
          style: TextStyle(color: Constant.FONT_COLOR_MENU),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: ClipRect(
                      child: Image.network(post.mobileAppPromotionLink),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      post.mobileAppPromotionDetail,
                      style: TextStyle(
                          fontSize: 20, color: Constant.FONT_COLOR_MENU),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
