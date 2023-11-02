import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsthongbai1app/bloc/point/point_bloc.dart';
import 'package:gsthongbai1app/bloc/point/point_event.dart';
import 'package:gsthongbai1app/bloc/point/point_state.dart';
import 'package:gsthongbai1app/src/models/point_response.dart';
import 'package:gsthongbai1app/src/themes/page_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/item_list.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../widgets/logintitle.dart';

class PointPage extends StatefulWidget {
  @override
  _PointPage createState() => _PointPage();
}

class _PointPage extends State<PointPage> {
  double _progressSlideSheet = 0;
  double _custRemainPoint = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LoginTitle(),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return PointBloc()..add(FetchPoint());
        },
        child: BlocBuilder<PointBloc, PointState>(builder: (context, state) {
          if (state is PointLoaded) {
            if (state.items.length > 0) {
              _custRemainPoint = state.items[0].custRemainPoint;
            }
            print("${_custRemainPoint.toString()}");
            return _buildPointList(state.items);
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

  Widget _buildPointList(List<PointResponse> itmes) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-home.png"),
          fit: BoxFit.cover,
        ),
      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "คะแนนสะสม", //todo
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                        fontSize: 28),
                  ),
                  Text(
                    Constant.formatNumber.format(_custRemainPoint), //todo
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                        fontSize: 80),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
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
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Center(
                    child: BlocBuilder<PointBloc, PointState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Center(
                              child: Text('Oops something went wrong!'));
                        }
                        if (state is PointLoaded) {
                          if (state.items.isEmpty) {
                            return Container(
                              child: Text("ไม่พบข้อมูลคะแนนสะสม",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 18),
                                  textAlign: TextAlign.right),
                            );
                          }
                          return ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return ItemTilePoint(item: state.items[index]);
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
              ),
            ),
          ],
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
          width: MediaQuery.of(context).size.width,
          height: 1,
        ),
      ],
    ));
  }
}

class ItemTilePoint extends StatelessWidget {
  final PointResponse item;

  const ItemTilePoint({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              '${item.description}',
              style: TextStyle(color: Color(0xFFf0e19b), fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Container(
            width: MediaQuery.of(context).size.width * 0.38,
            child: Text(
                "${Constant.formatDate.format(item.pointDate)} ${item.pointTime}",
                style: TextStyle(color: Color(0xFFf0e19b), fontSize: 16),
                textAlign: TextAlign.left),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.17,
            child: Text(Constant.formatNumber.format(item.point),
                style: TextStyle(color: Color(0xFFf0e19b), fontSize: 16),
                textAlign: TextAlign.right),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.10),
        ],
      ),
    );
  }
}
