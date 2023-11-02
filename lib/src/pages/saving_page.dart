import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:gsthongbai1app/bloc/saving/saving_bloc.dart';
import 'package:gsthongbai1app/bloc/saving/saving_event.dart';
import 'package:gsthongbai1app/bloc/saving/saving_state.dart';
import 'package:gsthongbai1app/src/models/saving_response.dart';
import 'package:gsthongbai1app/src/themes/page_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/bottom_loader.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'mobileapppayment_page.dart';

class SavingPage extends StatefulWidget {
  @override
  _SavingPage createState() => _SavingPage();
}

class _SavingPage extends State<SavingPage> {
  double _progressSlideSheet = 0;
  double _totalSaving = 0;
  String _savingID = "";
  double _moneyBackWard = 0;
  String _savingText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-home.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ออมทอง",
                  style: TextStyle(color: Constant.FONT_COLOR_MENU),
                ),
                IconButton(
                    icon: Icon(
                      Icons.history,
                      color: Constant.FONT_COLOR_MENU,
                    ),
                    onPressed: () {
                      Constant.MobileAppPaymentCustId = Constant.CUSTID;
                      Constant.MobileAppPaymentType = "ออมทอง";
                      Constant.MobileAppPaymentBillId = Constant.SavingId;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MobileAppPaymentPage(),
                          ));
                    }),
              ],
            ),
          ),
          iconTheme: IconThemeData(
            color: Constant.FONT_COLOR_MENU,
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocProvider(
          create: (BuildContext context) {
            return SavingBloc()..add(FetchSaving());
          },
          child:
              BlocBuilder<SavingBloc, SavingState>(builder: (context, state) {
            if (state is SavingLoaded) {
              if (state.items.length > 0) {
                _totalSaving = state.items[0].totalPay;
                _savingID = state.items[0].savingId;
                _moneyBackWard = state.items[0].moneyBackWard;
              }

              if (_moneyBackWard > 0) {
                _savingText =
                    "ออมทอง : ${_savingID} ยอดยกมา ${Constant.formatNumber.format(_moneyBackWard)}";
              } else {
                _savingText = "ออมทอง : ${_savingID}";
              }
              print("$_savingID ${_totalSaving.toString()}");
              return _buildSavingList(state.items);
            }
            if (state is Failure) {
              return Center(child: Text('Oops something went wrong!'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }

  _buildDivider() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: const [Colors.white10, Colors.white],
              stops: [0.0, 1.0],
            )),
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
              colors: const [Colors.white, Colors.white10],
            )),
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildSavingList(List<SavingResponse> items) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            height: 150,
            width: 330,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(0, 2))
                ],
                gradient: LinearGradient(
                  colors: [
//                            Colors.grey[600],
//                            Colors.grey[400],
                    Constant.PRIMARY_COLOR,
                    Constant.SECONDARY_COLOR,
                  ],
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Constant.formatNumber.format(_totalSaving), //todo
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      fontSize: 80),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180, top: 20),
                  child: Text(
                    _savingText, //todo
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 2))
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Constant.PRIMARY_COLOR,
                      Constant.SECONDARY_COLOR,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15)),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(
                child: BlocBuilder<SavingBloc, SavingState>(
                  builder: (context, state) {
                    if (state is Failure) {
                      return Center(child: Text('Oops something went wrong!'));
                    }
                    if (state is SavingLoaded) {
                      if (state.items.isEmpty) {
                        return Center(
                          child: Text("ไม่พบข้อมูลออมทอง",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFf0e19b),
                                  fontSize: 18),
                              textAlign: TextAlign.right),
                        );
                      }
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Text(
                                      "ลำดับ",
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.29,
                                    child: Text("วัน/เดือน/ปี เวลา",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 16),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Text("จำนวนเงิน",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 16),
                                        textAlign: TextAlign.right),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text("ยอดสะสม",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 16),
                                        textAlign: TextAlign.right),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                              child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return ItemTile(item: state.items[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                child: _buildDivider(),
                              );
                            },
                            itemCount: state.items.length,
                          )),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final SavingResponse item;

  const ItemTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(
                  '${item.no}',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Text(
                    "${Constant.formatDate.format(item.payDate)} ${item.prTime}",
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    textAlign: TextAlign.left),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: Text(Constant.formatNumber.format(item.amountPay),
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    textAlign: TextAlign.right),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Text(Constant.formatNumber.format(item.totalAmountPay),
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    textAlign: TextAlign.right),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            ],
          ),
        ),
      ],
    );
  }
}
