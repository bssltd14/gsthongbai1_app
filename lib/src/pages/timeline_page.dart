import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/timeline/timeline_bloc.dart';
import 'package:gsthongbai1app/bloc/timeline/timeline_event.dart';
import 'package:gsthongbai1app/bloc/timeline/timeline_state.dart';
import 'package:gsthongbai1app/src/models/mobileappnotisentcountunread_response.dart';
import 'package:gsthongbai1app/src/models/viewapimap_response.dart';
import 'package:gsthongbai1app/src/pages/mobileappnotisent_page.dart';
import 'package:gsthongbai1app/src/pages/timelineimage_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/utils/my_style.dart';
import 'package:gsthongbai1app/src/widgets/bottom_loader.dart';
import 'package:gsthongbai1app/src/widgets/custom_wrapper.dart';
import 'package:gsthongbai1app/src/widgets/goldprice.dart';
import 'package:gsthongbai1app/src/widgets/search_timeline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class TimeLinePage extends StatefulWidget {
  TimeLinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 800.0;
  String searchString = "";

  Future<bool> getNotiUnread() async {
    Constant.CountUnreadNoti = 0;
    try {
      print("getNotiUnread");
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'serverId': Constant.ServerId,
        'customerId': Constant.CustomerId
      };
      final url =
          "${Constant.API}/GetMobileAppNotiSentCountUnread?searchCustTel=${Constant.CUSTTEL}";
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      print(url);
      print("MobileAppNotiSentCountUnreadResponse : ${url}");
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final MobileAppNotiSentCountUnreadResponse
            mobileAppNotiSentCountUnreadResponse =
            MobileAppNotiSentCountUnreadResponse.fromJson(
                json.decode(response.body));
        Constant.CountUnreadNoti =
            mobileAppNotiSentCountUnreadResponse.countUnread;
        print("MobileAppNotiSentCountUnreadResponse Complete");
        return true;
      } else {
        print("Failed to load SummaryResponse ${response.statusCode}");
        return false;
      }
    } catch (_) {
      print("${_}");
    }
  }

  /*Widget logohome() {
    return Container(
        width: 175.0,
        height: 40.0,
        child: Image.asset('assets/images/logo-home.png'));
  }*/

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Container _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      //color: Color(0xFFfe0002),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //margin: const EdgeInsets.all(40.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"))),
          ),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       //color: Color(0xFFe7b971),
              //       color: Constant.PRIMARY_COLOR,
              //       borderRadius: BorderRadius.all(Radius.circular(
              //         15,
              //       )),
              //       border: Border.all(color: Color(0xFFe7b971))),
              //   child: Text(
              //     "   บางปูนคร   ",
              //     style: TextStyle(
              //         fontSize: 20,
              //         height: 1.2,
              //         color: Color(0xFFf0e19b),
              //         //color: Constant.PRIMARY_COLOR,
              //         fontWeight: FontWeight.bold),
              //   ),

              // ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-home3.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/bg-home1.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            width: MediaQuery.of(context).size.width * 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 125),
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo-3.png"))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              FutureBuilder(
                                  future: getNotiUnread(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == true) {
                                        return Container(
                                            //color: Constant.FONT_COLOR_MENU,
                                            decoration: BoxDecoration(
                                                //color: Color(0xFFe7b971),
                                                color: Constant.PRIMARY_COLOR,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                  15,
                                                )),
                                                border: Border.all(
                                                    color: Color(0xFFf0e19b))),
                                            child: Constant.CountUnreadNoti == 0
                                                ? IconButton(
                                                    icon: Icon(
                                                      Icons.notifications,
                                                      color: Color(0xFFf0e19b),
                                                      //color: Constant.PRIMARY_COLOR,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MobileAppNotiSentPage(),
                                                          ));
                                                    })
                                                : IconButton(
                                                    icon: badges.Badge(
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(
                                                                  top: -7,
                                                                  end: -7),
                                                      badgeContent: Text(
                                                          Constant.CountUnreadNoti
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFf0e19b),
                                                              //color: Constant.PRIMARY_COLOR,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      child: Icon(
                                                        Icons.notifications,
                                                        color:
                                                            Color(0xFFf0e19b),
                                                        //color: Constant.PRIMARY_COLOR,
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      try {
                                                        print(
                                                            "updateNotiUnread");
                                                        Map<String, String>
                                                            requestHeaders = {
                                                          'Content-type':
                                                              'application/json',
                                                          'serverId':
                                                              Constant.ServerId,
                                                          'customerId': Constant
                                                              .CustomerId
                                                        };
                                                        final url =
                                                            "${Constant.API}/MobileAppNotiSentUpdateCount?searchCustTel=${Constant.CUSTTEL}";
                                                        final response =
                                                            await http.put(
                                                                Uri.parse(url),
                                                                headers:
                                                                    requestHeaders);
                                                        print(response
                                                            .statusCode);
                                                        print(
                                                            "MobileAppNotiSentUpdateCount : ${url}");
                                                      } catch (_) {
                                                        print("${_}");
                                                      }

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                MobileAppNotiSentPage(),
                                                          ));
                                                      setState(() {
                                                        Constant
                                                            .CountUnreadNoti = 0;
                                                      });
                                                    }));
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    //color: Color(0xFFe7b971),
                                    color: Constant.PRIMARY_COLOR,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                      15,
                                    )),
                                    border:
                                        Border.all(color: Color(0xFFf0e19b))),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Color(0xFFf0e19b),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SearchTimeLinePage(),
                                          ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          //color: Color(0xFFe7b971),
                          color: Constant.PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(
                            15,
                          )),
                          border: Border.all(color: Color(0xFFf0e19b))),
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ราคาทองคำแท่ง",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              //color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              //color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Color(0xFF925f26),
                        //     Color(0xFFe6ba57),
                        //   ],
                        // ),
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: FutureBuilder(
                        future: fetchGoldPrice(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == true) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    padding: EdgeInsets.only(top: 0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              //color: Color(0xFFe7b971),
                                              color: Constant.PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              border: Border.all(
                                                  color: Color(0xFFf0e19b))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขายออก",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              Constant.GoldPriceSale,
                                              style: TextStyle(
                                                //color: Color(0xFFe7b971),
                                                color: Constant.PRIMARY_COLOR,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    padding: EdgeInsets.only(top: 0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              //color: Color(0xFFe7b971),
                                              color: Constant.PRIMARY_COLOR,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15)),
                                              border: Border.all(
                                                  color: Color(0xFFf0e19b))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "รับซื้อ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              Constant.GoldPriceBuy,
                                              style: TextStyle(
                                                //color: Color(0xFFe7b971),
                                                color: Constant.PRIMARY_COLOR,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          toolbarHeight: 370,
        ),
        body: BlocProvider(
          create: (BuildContext context) {
            return TimelineBloc()..add(Fetch(Constant.searchDetail));
          },
          child: BlocBuilder<TimelineBloc, TimelineState>(
            builder: (context, state) {
              if (state is TimelineLoaded) {
                return _buildList(state.posts);
              }

              if (state is TimelineError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return _buildWShimmer();
//              return  CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      // DI
      BlocProvider.of<TimelineBloc>(context).add(Fetch(searchString));
    }
  }

  Widget _buildList(List<ViewAPIMAPResponse> posts) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<TimelineBloc>(context).add(Reload(searchString));
      },
      child: ListView.separated(
        controller: _scrollController,
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
      ),
    );
  }

  Widget _buildWShimmer() {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Constant.PRIMARY_COLOR,
            highlightColor: Constant.SECONDARY_COLOR,
            enabled: true,
            child: ListView.builder(
              itemBuilder: (_, __) => Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Constant.PRIMARY_COLOR,
                        Constant.SECONDARY_COLOR,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(boxShadow: [
                        // BoxShadow(
                        //     color: Colors.white70,
                        //     blurRadius: 20,
                        //     offset: Offset(0, 2))
                      ], borderRadius: BorderRadius.circular(3)),
                      padding: EdgeInsets.all(10.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 80,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 7,
            ),
          ),
        ),
      ],
    ));
  }

  Widget searchForm() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(12.0)),
      height: 40.0,
      child: TextField(
        onChanged: (value) => searchString = value.trim(),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefix: SizedBox(
            width: 16.0,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyStyle().white1),
          hintText: 'ค้นหา สินค้า',
        ),
      ),
    );
  }

  IconButton searchIconButton() {
    return IconButton(
      tooltip: 'ค้นหา สินค้า',
      icon: Icon(
        Icons.search,
        color: Colors.white,
        // size: MyStyle().myIconSize,
      ),
      // ignore: missing_return
      onPressed: () {
        if (searchString == null || searchString.isEmpty) {
          print('Have Space');
        } else {
          BlocProvider.of<TimelineBloc>(context).add(Fetch(searchString));
        }
      },
    );
  }

  void routeToSearch() {
    BlocBuilder<TimelineBloc, TimelineState>(
      builder: (context, state) {
        if (state is TimelineLoaded) {
          return _buildList(state.posts);
        }

        if (state is TimelineError) {
          return Center(
            child: Text(state.error),
          );
        }

        return _buildWShimmer();
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final ViewAPIMAPResponse post;
  final index;

  const PostWidget({Key key, @required this.post, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: index % 2 == 0

               ? <Color>[Color(0xFF925f26), Color(0xFFe6ba57)]
               : <Color>[Color(0xFFe6ba57), Color(0xFF925f26)],

                // ? <Color>[Constant.PRIMARY_COLOR, Constant.SECONDARY_COLOR]
                // : <Color>[Constant.SECONDARY_COLOR, Constant.PRIMARY_COLOR],
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
                builder: (context) => TimeLineImagePage(post: post),
              ));
        },
      ),
    );
  }

  Widget showImage(ViewAPIMAPResponse post, double width) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          //BoxShadow(color: Colors.white70, blurRadius: 20, offset: Offset(0, 2))
        ], borderRadius: BorderRadius.circular(3)),
        padding: EdgeInsets.all(10.0),
        width: width * 0.5,
//      child: Image.network(post.mobileAppPromotionLink),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(post.mobileAppPromotionLink),
        ));
  }

  Widget showText(ViewAPIMAPResponse post, double width) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: width * 0.5,
//   width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Text(post.mobileAppPromotionName,
                    style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF))),
//        ,
//        style: TextStyle(
//        fontWeight: FontWeight.bold,
//        color: Color(0xFFf8d468),
//        fontSize: 18

                subtitle: Text(post.mobileAppPromotionDetail,
                    style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF))),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  "${Constant.formatDate.format(post.mobileAppPromotionDate)}     ",
                  style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF))),
//              Text(post.mobileAppPromotionDetail),
//   Text(post.mobileAppPromotionDate),
            ]));
  }
}
