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

class SavingPage extends StatefulWidget {
  @override
  _SavingPage createState() => _SavingPage();
}

class _SavingPage extends State<SavingPage> {
  double _progressSlideSheet = 0;
  double _totalSaving = 0;
  String _savingID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) {
          return SavingBloc()..add(FetchSaving());
        },
        child: BlocBuilder<SavingBloc, SavingState>(builder: (context, state) {
          if (state is SavingLoaded) {
            if (state.items.length > 0) {
              _totalSaving = state.items[0].totalPay;
              _savingID = state.items[0].savingId;
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: PageTheme.gradient),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AnimatedContainer(
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
                            Colors.blueGrey[600],
                            Colors.blueGrey[200],
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    duration: Duration(milliseconds: 500),
                    height: _progressSlideSheet == 0
                        ? 180
                        : 180 - _progressSlideSheet * 65,
                    curve: Curves.elasticOut,
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              left: 50,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 50),
                opacity: 1 - _progressSlideSheet,
                child: AnimatedPadding(
                  padding: EdgeInsets.only(top: 190),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  child: Text(
                    "ออมทอง เลขที่ : $_savingID", //todo
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              child: AnimatedPadding(
                padding: EdgeInsets.only(top: 90 - _progressSlideSheet * 30),
                duration: Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                child: Text(
                  Constant.formatNumber.format(_totalSaving), //todo
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 80),
                ),
              ),
            ),
            SlidingSheet(
              listener: (state) {
                setState(() {
                  _progressSlideSheet = state.progress;
                });
              },
//              color: Colors.black45,
              elevation: 10,
              cornerRadius: 20,
              snapSpec: const SnapSpec(
                snappings: [
//                  0.40,
//                  0.52,
                  0.6, 0.7
                ],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              closeOnBackdropTap: true,
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(0, 2))
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueGrey[600],
                          Colors.blueGrey[200],
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height / 1.75,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blueGrey[600],
                                    Colors.blueGrey[100],
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            height: 20,
                            width: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: BlocBuilder<SavingBloc, SavingState>(
                            builder: (context, state) {
                              if (state is Failure) {
                                return Center(
                                    child: Text('Oops something went wrong!'));
                              }
                              if (state is SavingLoaded) {
                                if (state.items.isEmpty) {
                                  return Center(
                                    child: Text("ไม่พบข้อมูลออมทอง",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                        textAlign: TextAlign.right),
                                  );
                                }
                                return ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemTile(item: state.items[index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      child: _buildDivider(),
                                    );
                                  },
                                  itemCount: state.items.length,
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
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
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Text(
              '${item.no}',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.10),
          Container(
            width: MediaQuery.of(context).size.width * 0.40,
            child: Text(
                "${Constant.formatDate.format(item.payDate)} ${item.prTime}",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.left),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(Constant.formatNumber.format(item.amountPay),
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.right),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Text(Constant.formatNumber.format(item.totalAmountPay),
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.right),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}
