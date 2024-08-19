import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/mobileappnotisent/mobileappnotisent_bloc.dart';
import 'package:gsthongbai1app/bloc/mobileappnotisent/mobileappnotisent_event.dart';
import 'package:gsthongbai1app/bloc/mobileappnotisent/mobileappnotisent_state.dart';
import 'package:gsthongbai1app/src/models/mobileappnotisent_response.dart';
import 'package:gsthongbai1app/src/search/search_notisentdate.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/bottom_loader.dart';
import 'package:http/http.dart' as http;

class MobileAppNotiSentPage extends StatefulWidget {
  @override
  _MobileAppNotiSentPageState createState() => _MobileAppNotiSentPageState();
}

class _MobileAppNotiSentPageState extends State<MobileAppNotiSentPage> {
  @override
  void initState() {
    super.initState();
    // if (Constant.CountUnreadNoti > 0) {
    //   updateNotiUnread();
    // }
  }

  void updateNotiUnread() async {
    try {
      print("updateNotiUnread");
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'serverId': Constant.ServerId,
        'customerId': Constant.CustomerId
      };
      final url =
          "${Constant.API}/MobileAppNotiSentUpdateCount?searchCustTel=${Constant.CUSTTEL}";
      final response = await http.put(Uri.parse(url), headers: requestHeaders);
      print(response.statusCode);
      Constant.CountUnreadNoti = 0;
      print("MobileAppNotiSentUpdateCount : ${url}");
    } catch (_) {
      print("${_}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-noti.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "แจ้งเตือน",
                style: TextStyle(
                    fontSize: 20,
                    color: Constant.FONT_COLOR_MENU,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Constant.FONT_COLOR_MENU,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchNotiSentDatePage()),
                    ).then((value) {
                      setState(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileAppNotiSentPage()));
                      });
                    });
                  }),
            ],
          ),
          iconTheme: IconThemeData(
            color: Constant.FONT_COLOR_MENU,
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocProvider(
          create: (BuildContext context) {
            return MobileAppNotiSentBloc()..add(FetchMobileAppNotiSent());
          },
          child: BlocBuilder<MobileAppNotiSentBloc, MobileAppNotiSentState>(
            builder: (context, state) {
              if (state is MobileAppNotiSentLoaded) {
                return _buildList(state.items);
              }

              if (state is Failure) {
                return Center(
                  child: Text("ไม่พบข้อมูลแจ้งเตือน",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constant.FONT_COLOR_MENU,
                          fontSize: 24),
                      textAlign: TextAlign.right),
                );
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

  Widget _buildList(List<MobileAppNotiSentResponse> posts) {
    return Container(
      child: BlocBuilder<MobileAppNotiSentBloc, MobileAppNotiSentState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(child: Text("ไม่พบข้อมูลแจ้งเตือน",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.FONT_COLOR_MENU,
                        fontSize: 24),
                    textAlign: TextAlign.right),);
          }
          if (state is MobileAppNotiSentLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text("ไม่พบข้อมูล",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.FONT_COLOR_MENU,
                        fontSize: 24),
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
                return Container(
                  child: _buildDivider(),
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

  _buildDivider() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Constant.PRIMARY_COLOR, Constant.SECONDARY_COLOR],
              stops: [0.0, 1.0],
            )),
            width: MediaQuery.of(context).size.width,
            height: 2,
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final MobileAppNotiSentResponse post;
  final index;

  const PostWidget({Key key, @required this.post, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black,
//             width: 1,

//           ),
//           boxShadow: [
//             // BoxShadow(
//                 //color: Colors.black54, blurRadius: 10, offset: Offset(0, 2))
//           ],
// //           gradient: LinearGradient(
// //             colors: index % 2 == 0

// // //                ? <Color>[Constant.PRIMARY_COLOR, Colors.blueGrey[200]]
// // //                : <Color>[Colors.blueGrey[200], Constant.PRIMARY_COLOR],

// //                 ? <Color>[Constant.PRIMARY_COLOR, Constant.SECONDARY_COLOR]
// //                 : <Color>[Constant.SECONDARY_COLOR, Constant.PRIMARY_COLOR],
// //           ),
//           borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        child: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  showText(post, MediaQuery.of(context).size.width)
                ],
              ),
            ],
          ),
        ),
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => MobileAppNotiSentImagePage(post: post),
        //       ));
        // },
      ),
    );
  }

  Widget showText(MobileAppNotiSentResponse post, double width) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: width * 1,
//   width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Container(
                  width: width * 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Constant.PRIMARY_COLOR,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.white)),
                        child: Icon(
                          Icons.notifications,
                          color: Color(0xFFf0e19b),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(" ${post.notiTitle}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Constant.PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${Constant.formatDate.format(post.notiDate)} ${post.notiTime}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constant.PRIMARY_COLOR,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text("เลขที่ ${post.notiRefNo}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Constant.PRIMARY_COLOR,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(post.notiDetail,
                        style: TextStyle(
                          fontSize: 16,
                          color: Constant.PRIMARY_COLOR,
                        )),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 50,
              // ),
            ]));
  }
}
