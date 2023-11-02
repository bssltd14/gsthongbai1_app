import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/mobileapppaymentint/mobileapppaymentint_bloc.dart';
import 'package:gsthongbai1app/bloc/mobileapppaymentint/mobileapppaymentint_event.dart';
import 'package:gsthongbai1app/bloc/mobileapppaymentint/mobileapppaymentint_state.dart';
import 'package:gsthongbai1app/src/models/mobileapppaymentint_response.dart';
import 'package:gsthongbai1app/src/pages/mobileapppaymentintimage_page.dart';

import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/bottom_loader.dart';

class MobileAppPaymentIntPage extends StatefulWidget {
  @override
  _MobileAppPaymentIntPageState createState() =>
      _MobileAppPaymentIntPageState();
}

class _MobileAppPaymentIntPageState extends State<MobileAppPaymentIntPage> {
  @override
  void initState() {
    super.initState();
  }

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
          title: Text(
            "ประวัติการโอน ต่อดอก",
            style: TextStyle(color: Constant.FONT_COLOR_MENU),
          ),
          iconTheme: IconThemeData(
            color: Constant.FONT_COLOR_MENU,
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocProvider(
        create: (BuildContext context) {
          return MobileAppPaymentIntBloc()..add(FetchMobileAppPaymentInt());
        },
        child: BlocBuilder<MobileAppPaymentIntBloc, MobileAppPaymentIntState>(
          builder: (context, state) {
            if (state is MobileAppPaymentIntLoaded) {
              return _buildList(state.items);
            }

            if (state is Failure) {
              return Center(child: Text('Oops something went wrong!'));
            }

            return Center(
              child: CircularProgressIndicator(),
            );
//              return  CircularProgressIndicator();
          },
        ),
      ),
      ),
    );
  }

  Widget _buildList(List<MobileAppPaymentIntResponse> posts) {
    return Container(
      child: BlocBuilder<MobileAppPaymentIntBloc, MobileAppPaymentIntState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(child: Text('Oops something went wrong!'));
          }
          if (state is MobileAppPaymentIntLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text("ไม่พบข้อมูล",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.FONT_COLOR_PAGE,
                        fontSize: 18),
                    textAlign: TextAlign.right),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.only(bottom: 70),
              itemBuilder: (context, index) {
                return index >= posts.length
                    ? BottomLoader()
                    : PostWidget(post: posts[index], index: index);
              },
              separatorBuilder: (context, index) {
//          return Divider(
//            indent: 1,
//            height: 8,
//          );
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: posts.length + 1,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final MobileAppPaymentIntResponse post;
  final index;

  const PostWidget({Key key, @required this.post, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, 2))
          ],
          gradient: LinearGradient(
            colors: index % 2 == 0

//                ? <Color>[Colors.blueGrey[600], Colors.blueGrey[200]]
//                : <Color>[Colors.blueGrey[200], Colors.blueGrey[600]],

                ? <Color>[Constant.PRIMARY_COLOR, Constant.SECONDARY_COLOR]
                : <Color>[Constant.SECONDARY_COLOR, Constant.PRIMARY_COLOR],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              showImage(post, MediaQuery.of(context).size.width),
              showText(post, MediaQuery.of(context).size.width)
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MobileAppPaymentIntImagePage(post: post),
              ));
        },
      ),
    );
  }

  Widget showImage(MobileAppPaymentIntResponse post, double width) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          //BoxShadow(color: Colors.white70, blurRadius: 20, offset: Offset(0, 2))
        ], borderRadius: BorderRadius.circular(3)),
        padding: EdgeInsets.all(10.0),
        width: width * 0.5,
//      child: Image.network(post.mobileAppPromotionLink),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(post.picLink)));
  }

  Widget showText(MobileAppPaymentIntResponse post, double width) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: width * 0.5,
//   width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Text("${post.type} ${post.billId}",
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF))),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(Constant.formatNumber.format(post.price),
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFFFFF))),
                    SizedBox(height: 10),
                    Text(post.status,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFFFFF))),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  "${Constant.formatDate.format(post.dateSend)}  ${post.timeSend}",
                  style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF))),
            ]));
  }
}
