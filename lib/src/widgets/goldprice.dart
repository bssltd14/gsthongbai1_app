import 'package:flutter/material.dart';
import 'package:gsthongbai1app/src/models/goldprice_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<bool> fetchGoldPrice() async {
  try {
    String GoldPrice = "";

    final url = "http://150.95.88.227:1150/GoldPrice";
    print(url);
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // final List<GoldPriceResponse> goldPriceResponse =
      //     List<GoldPriceResponse>.from(
      //         goldPriceResponseFromJson(response.body));
      // print("fetchGoldPrice Complete");
      // // return goldPriceResponse;
      // Constant.GoldPrice =
      //     "${Constant.formatNumber.format(double.parse(goldPriceResponse[4].bid))} - ${Constant.formatNumber.format(double.parse(goldPriceResponse[4].ask))} ";
      // // Constant.GoldPrice = "${goldPriceResponse[4].name}";

      GoldPrice = response.body;
      if (GoldPrice.length > 0) {
        final SplitValue = GoldPrice.split("|");

        if (SplitValue.length > 0) {
          Constant.GoldPriceSale = "${SplitValue[0]}";
          Constant.GoldPriceBuy = "${SplitValue[1]}";
        }
      }

      print(Constant.GoldPrice);
      return true;
    }
    print('Network failed GoldPriceService');
    return false;
  } catch (_) {
    print("${_}");
  }
}

class BuildGoldPrice extends StatefulWidget {
  @override
  _BuildGoldPriceState createState() => _BuildGoldPriceState();
}

class _BuildGoldPriceState extends State<BuildGoldPrice> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                FutureBuilder(
                    future: fetchGoldPrice(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ราคาทองแท่งสมาคม  ${Constant.GoldPrice}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Constant.FONT_COLOR_MENU),
                              ),
                              Text(
                                Constant.searchDetail,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Constant.FONT_COLOR_MENU),
                              )
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
