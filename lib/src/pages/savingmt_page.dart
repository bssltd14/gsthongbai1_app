import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/savingmt/savingmt_bloc.dart';
import 'package:gsthongbai1app/bloc/savingmt/savingmt_event.dart';
import 'package:gsthongbai1app/bloc/savingmt/savingmt_state.dart';
import 'package:gsthongbai1app/src/models/savingmt_response.dart';
import 'package:gsthongbai1app/src/pages/mobileapppayment_page.dart';
import 'package:gsthongbai1app/src/pages/saving_page.dart';
import 'package:gsthongbai1app/src/pages/uploadslip_page.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/logintitle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavingMtPage extends StatefulWidget {
  @override
  _SavingMtPage createState() => _SavingMtPage();
}

class _SavingMtPage extends State<SavingMtPage> {
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
            child: Column(
              children: [
                SizedBox(height: 15),
                LoginTitle(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.history,
                          color: Constant.FONT_COLOR_MENU,
                        ),
                        onPressed: () {
                          Constant.MobileAppPaymentCustId = Constant.CUSTID;
                          Constant.MobileAppPaymentType = "ออมทอง";
                          Constant.MobileAppPaymentBillId = "";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileAppPaymentPage(),
                              ));
                        }),
                  ],
                ),
              ],
            ),
          ),
          toolbarHeight: 70,
          backgroundColor: Color(0xFFFFFFFF),
        ),
        body: BlocProvider(
          create: (BuildContext context) {
            return SavingMtBloc()..add(FetchSavingMt());
          },
          child:
              BlocBuilder<SavingMtBloc, SavingMtState>(builder: (context, state) {
            if (state is SavingMtLoaded) {
              return _buildSavingMtList(state.items);
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

  Widget _buildSavingMtList(List<SavingMtResponse> items) {
    return Container(
      child: BlocBuilder<SavingMtBloc, SavingMtState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(child: Text('Oops something went wrong!'));
          }
          if (state is SavingMtLoaded) {
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
              padding: EdgeInsets.only(top: 30, bottom: 80),
              itemBuilder: (BuildContext context, int index) {
                return ItemTileSavingMt(item: state.items[index]);
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

  _buildOpenAcct() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ไม่พบข้อมูลออมทอง",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Constant.FONT_COLOR_MENU,
                fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class ItemTileSavingMt extends StatelessWidget {
  final SavingMtResponse item;
  final index;

  const ItemTileSavingMt({Key key, @required this.item, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black54, blurRadius: 10, offset: Offset(0, 2))
              // ],
              gradient: LinearGradient(
                colors: [
                  Constant.PRIMARY_COLOR,
                  Constant.SECONDARY_COLOR,
                ],
              ),
              border: Border.all(
                color: Color(0xFFf0e19b),
                width: 5,
                style: BorderStyle.solid
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTitle(item, MediaQuery.of(context).size.width),
                    _buildDetail(item, MediaQuery.of(context).size.width),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Color(0xFFf0e19b),
                        ),
                        onPressed: () {
                        Constant.MobileAppPaymentBranchName = item.branchName;
                        Constant.MobileAppPaymentCustId = Constant.CUSTID;
                        Constant.MobileAppPaymentType = "ออมทอง";
                        Constant.MobileAppPaymentBillId = item.savingId;
                        Constant.BankAcctNameSaving =
                            item.mobileTranBankAcctNameSaving;
                        Constant.BankAcctNoSaving =
                            item.mobileTranBankAcctNoSaving;

                        if (item.mobileTranBankSaving == "BAY") {
                          Constant.BankAccSaving = "กรุงศรีอยุธยา";
                        } else if (item.mobileTranBankSaving == "BAAC") {
                          Constant.BankAccSaving = "ธ.ก.ส";
                        } else if (item.mobileTranBankSaving == "BBL") {
                          Constant.BankAccSaving = "กรุงเทพ";
                        } else if (item.mobileTranBankSaving == "CIMBT") {
                          Constant.BankAccSaving = "ซีไอเอ็มบี ไทย";
                        } else if (item.mobileTranBankSaving == "GSB") {
                          Constant.BankAccSaving = "ออมสิน";
                        } else if (item.mobileTranBankSaving == "ICBS") {
                          Constant.BankAccSaving = "ไอซีบีซี (ไทย)";
                        } else if (item.mobileTranBankSaving == "KBANK") {
                          Constant.BankAccSaving = "กสิกรไทย";
                        } else if (item.mobileTranBankSaving == "KK") {
                          Constant.BankAccSaving = "เกียรตินาคินภัทร";
                        } else if (item.mobileTranBankSaving == "KTB") {
                          Constant.BankAccSaving = "กรุงไทย";
                        } else if (item.mobileTranBankSaving == "LH") {
                          Constant.BankAccSaving = "แลนด์ แอนด์ เฮ้าส์";
                        } else if (item.mobileTranBankSaving == "SCB") {
                          Constant.BankAccSaving = "ไทยพาณิชย์";
                        } else if (item.mobileTranBankSaving == "TISCO") {
                          Constant.BankAccSaving = "ทิสโก้";
                        } else if (item.mobileTranBankSaving == "TTB") {
                          Constant.BankAccSaving = "ทหารไทยธนชาต";
                        } else if (item.mobileTranBankSaving == "UOB") {
                          Constant.BankAccSaving = "ยูโอบี";
                        } else {
                          Constant.BankAccSaving = "";
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadSlipPagePage(),
                            ));
                      },
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () {
          Constant.SavingId = item.savingId;
          print("${item.savingId}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavingPage(),
            ),
          );
        },
      ),
    );
  }

  _buildTitle(SavingMtResponse item, double width) {
    return Container(
      width: width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "สาขาที่ทำรายการ :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b),fontSize: 18),
          ),
          Text(
            "เลขที่ออมทอง  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          Text(
            "วันที่เปิดออม  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          Text(
            "ยอดออมทอง  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          
          SizedBox(height: 5),
        ],
      ),
    );
  }

  _buildDetail(SavingMtResponse item, double width) {
    return Container(
      width: width * 0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            " ${item.branchName}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b),fontSize: 18),
          ),
          Text(
            "  ${item.savingId}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          Text(
            "  ${Constant.formatDate.format(item.savingDate)}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          Text(
            "  ${Constant.formatNumber.format(item.totalPay)} บาท",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 18),
          ),
          
          
          
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

_launchLine() async {
  String lineProtocolUrl;
  //officail account
//    lineProtocolUrl = "https://line.me/R/oaMessage/${Constant.LINE_ID}/";

  lineProtocolUrl = "https://bit.ly/2Y6NXIV";
  print(lineProtocolUrl);
//    String fallbackUrl = 'https://www.line.com/page_name';
//    String fallbackUrl = "https://www.Line.com/ห้างทองรัตนไชยเยาวราช";
  if (await canLaunch(lineProtocolUrl)) {
    return await launch(lineProtocolUrl);
  }

  throw 'Could not launch url';
}



