import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/pawndt/pawndt_bloc.dart';
import 'package:gsthongbai1app/bloc/pawndt/pawndt_event.dart';
import 'package:gsthongbai1app/bloc/pawndt/pawndt_state.dart';
import 'package:gsthongbai1app/src/models/pawndt_response.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class PawnDtPage extends StatefulWidget {
  final pawnId;
  final branchName;

  const PawnDtPage({Key key, this.pawnId, this.branchName}) : super(key: key);

  @override
  _PawnDtPageState createState() => _PawnDtPageState();
}

class _PawnDtPageState extends State<PawnDtPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ประวัติการต่อดอก",
          style: TextStyle(color: Constant.FONT_COLOR_MENU),
        ),
        iconTheme: IconThemeData(
          color: Constant.FONT_COLOR_MENU,
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return PawnDtBloc()
            ..add(FetchPawnDt(widget.pawnId, widget.branchName));
        },
        child: BlocBuilder<PawnDtBloc, PawnDtState>(builder: (context, state) {
          if (state is PawnDtLoaded) {
            return _buildPawnDt(state.items, context);
          }
          if (state is Failure) {
            return Column(
              children: <Widget>[
                Center(child: Text('Oops something went wrong!')),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget _buildPawnDt(List<PawnDtResponse> items, BuildContext context) {
    return Container(
      child: BlocBuilder<PawnDtBloc, PawnDtState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(child: Text('Oops something went wrong!'));
          }
          if (state is PawnDtLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text("ไม่พบข้อมูลต่อดอก",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.FONT_COLOR_MENU,
                        fontSize: 18),
                    textAlign: TextAlign.right),
              );
            }
//            return ListView.separated(
//              padding: EdgeInsets.only(top: 70, bottom: 80),
//              itemBuilder: (BuildContext context, int index) {
//
//                return PawnDtTile(item: state.items[index]);
//              },
//              separatorBuilder: (context, index) {
//                return Container(
//                  child: _buildDivider(),
//                );
//              },
//              itemCount: state.items.length,
//            );
            return Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: Text(
                            "วันที่ต่อดอก",
                            style: TextStyle(
                                fontSize: 16, color: Constant.FONT_COLOR_MENU),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: Text(
                            "ต่อดอกถึง",
                            style: TextStyle(
                                fontSize: 16, color: Constant.FONT_COLOR_MENU),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: Text(
                            "เดือน",
                            style: TextStyle(
                                fontSize: 16, color: Constant.FONT_COLOR_MENU),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: Text(
                            "วัน",
                            style: TextStyle(
                                fontSize: 16, color: Constant.FONT_COLOR_MENU),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: Text(
                            "จำนวนเงิน",
                            style: TextStyle(
                                fontSize: 16, color: Constant.FONT_COLOR_MENU),
                            textAlign: TextAlign.left,
                          ),
                        ),
//                        SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 10, bottom: 80),
                    itemBuilder: (BuildContext context, int index) {
                      return PawnDtTile(item: state.items[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        child: _buildDivider(),
                      );
                    },
                    itemCount: state.items.length,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _buildDivider() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white, Constant.FONT_COLOR_MENU],
              stops: [0.0, 1.0],
            )),
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Constant.FONT_COLOR_MENU, Colors.white],
              stops: [0.0, 1.0],
            )),
            width: MediaQuery.of(context).size.width / 2,
            height: 1,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class PawnDtTile extends StatelessWidget {
  final PawnDtResponse item;

  const PawnDtTile({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Container(
          width: MediaQuery.of(context).size.width * 0.36,
          child: Text(
            "${Constant.formatDate.format(item.payDate)} ${item.prTime}",
            style: TextStyle(fontSize: 14, color: Constant.FONT_COLOR_MENU),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.23,
          child: Text(
            item.dueDate == null
                ? ""
                : "${Constant.formatDate.format(item.dueDate)}",
            style: TextStyle(fontSize: 14, color: Constant.FONT_COLOR_MENU),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.08,
          child: Text(
            "${Constant.formatNumber.format(item.monthPay)}",
            style: TextStyle(fontSize: 14, color: Constant.FONT_COLOR_MENU),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.08,
          child: Text(
            "${Constant.formatNumber.format(item.dayPay)}",
            style: TextStyle(fontSize: 14, color: Constant.FONT_COLOR_MENU),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: Text(
            "${Constant.formatNumber.format(item.amountPay)}",
            style: TextStyle(fontSize: 14, color: Constant.FONT_COLOR_MENU),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }
}
