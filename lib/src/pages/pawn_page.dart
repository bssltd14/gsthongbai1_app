import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsthongbai1app/bloc/pawn/pawn_bloc.dart';
import 'package:gsthongbai1app/bloc/pawn/pawn_event.dart';
import 'package:gsthongbai1app/bloc/pawn/pawn_state.dart';
import 'package:gsthongbai1app/src/models/pawn_response.dart';
import 'package:gsthongbai1app/src/pages/mobileapppaymentint_page.dart';
import 'package:gsthongbai1app/src/pages/pawndt_page.dart';
import 'package:gsthongbai1app/src/pages/uploadslipint_page.dart';
import 'package:gsthongbai1app/src/themes/page_theme.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';
import 'package:gsthongbai1app/src/widgets/logintitle.dart';

class PawnPage extends StatefulWidget {
  @override
  _PawnPage createState() => _PawnPage();
}

class _PawnPage extends State<PawnPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg-home3.png"),
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
                          Constant.MobileAppPaymentIntCustId = Constant.CUSTID;
                          Constant.MobileAppPaymentIntType = "ต่อดอก";
                          Constant.MobileAppPaymentIntBillId = "";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MobileAppPaymentIntPage(),
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
            return PawnBloc()..add(FetchPawn());
          },
          child: BlocBuilder<PawnBloc, PawnState>(builder: (context, state) {
            if (state is PawnLoaded) {
              return _buildPawnList(state.items);
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

  Widget _buildPawnList(List<PawnResponse> items) {
    return Container(
      child: BlocBuilder<PawnBloc, PawnState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(child: Text('Oops something went wrong!'));
          }
          if (state is PawnLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text("ไม่พบข้อมูลขายฝาก",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.FONT_COLOR_MENU,
                        fontSize: 18),
                    textAlign: TextAlign.right),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.only(top: 30, bottom: 80),
              itemBuilder: (BuildContext context, int index) {
                return ItemTilePawn(item: state.items[index]);
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
}

class ItemTilePawn extends StatelessWidget {
  final PawnResponse item;
  final index;

  const ItemTilePawn({Key key, @required this.item, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
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
//                            Colors.grey[600],
//                            Colors.grey[400],
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
              Container(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTitle(item, MediaQuery.of(context).size.width),
                    _buildDetail(item, MediaQuery.of(context).size.width),
                  ],
                ),
              ),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //         icon: Icon(
              //           Icons.add_circle,
              //           color: Color(0xFFFFFFFF),
              //         ),
              //         onPressed: () {
              //           Constant.MobileAppPaymentIntBranchName =
              //               item.branchName;
              //           Constant.MobileAppPaymentIntCustId = Constant.CUSTID;
              //           Constant.MobileAppPaymentIntType = "ต่อดอก";
              //           Constant.MobileAppPaymentIntBillId = item.pawnId;
              //           Constant.IntPerMonth =
              //               Constant.formatNumber2.format(item.intpay);
              //           Constant.BankAcctNameInt =
              //               item.mobileTranBankAcctNameInt;
              //           Constant.BankAcctNoInt = item.mobileTranBankAcctNoInt;

              //           if (item.mobileTranBankInt == "BAY") {
              //             Constant.BankAccInt = "กรุงศรีอยุธยา";
              //           } else if (item.mobileTranBankInt == "BAAC") {
              //             Constant.BankAccInt = "ธ.ก.ส";
              //           } else if (item.mobileTranBankInt == "BBL") {
              //             Constant.BankAccInt = "กรุงเทพ";
              //           } else if (item.mobileTranBankInt == "CIMBT") {
              //             Constant.BankAccInt = "ซีไอเอ็มบี ไทย";
              //           } else if (item.mobileTranBankInt == "GSB") {
              //             Constant.BankAccInt = "ออมสิน";
              //           } else if (item.mobileTranBankInt == "ICBS") {
              //             Constant.BankAccInt = "ไอซีบีซี (ไทย)";
              //           } else if (item.mobileTranBankInt == "KBANK") {
              //             Constant.BankAccInt = "กสิกรไทย";
              //           } else if (item.mobileTranBankInt == "KK") {
              //             Constant.BankAccInt = "เกียรตินาคินภัทร";
              //           } else if (item.mobileTranBankInt == "KTB") {
              //             Constant.BankAccInt = "กรุงไทย";
              //           } else if (item.mobileTranBankInt == "LH") {
              //             Constant.BankAccInt = "แลนด์ แอนด์ เฮ้าส์";
              //           } else if (item.mobileTranBankInt == "SCB") {
              //             Constant.BankAccInt = "ไทยพาณิชย์";
              //           } else if (item.mobileTranBankInt == "TISCO") {
              //             Constant.BankAccInt = "ทิสโก้";
              //           } else if (item.mobileTranBankInt == "TTB") {
              //             Constant.BankAccInt = "ทหารไทยธนชาต";
              //           } else if (item.mobileTranBankInt == "UOB") {
              //             Constant.BankAccInt = "ยูโอบี";
              //           } else {
              //             Constant.BankAccInt = "";
              //           }
              //           print(Constant.OverDayInt.toString());
              //           if (item.duedate
              //               .add(Duration(days: Constant.OverDayInt))
              //               // .add( Duration(days:1))
              //               .isAfter(DateTime.now())) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => UploadSlipIntPage(),
              //                 ));
              //           } else {
              //             showDialogDueDateOver(context);
              //           }
              //         }),
              //   ],
              // ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PawnDtPage(
                pawnId: "${item.pawnId}",
                branchName: "${item.branchName}",
              ),
            ),
          );
        },
      ),
    );
  }

  _buildTitle(PawnResponse item, double width) {
    return Container(
      width: width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "สาขาที่ทำรายการ  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "เลขที่  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "สินค้า  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "จำนวนรวม  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "น้ำหนักรวม  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "จำนวนเงิน  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "ระยะเวลา  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "วันที่ฝาก  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "วันที่ครบกำหนด  :",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  _buildDetail(PawnResponse item, double width) {
    return Container(
      width: width * 0.50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "  ${item.branchName}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "  ${item.pawnId}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFf0e19b),
                    fontSize: 18),
              ),
              Text(
                "สถานะ ${item.outStatus}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFf0e19b),
                    fontSize: 16),
              ),
            ],
          ),
          Text(
            "  ${item.sumDescription}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatNumber.format(item.sumItemQty)} ชิ้น",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatNumber2.format(item.sumItemwt)} กรัม",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatNumber.format(item.amountget)} บาท",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatNumber.format(item.months)} เดือน",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatDate.format(item.inDate)}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          Text(
            "  ${Constant.formatDate.format(item.duedate)}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFFf0e19b), fontSize: 16),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

void showDialogDueDateOver(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "❗️รายการเกินกำหนด" +
                            "\n" +
                            "\n" +
                            "กรุณาติดต่อหน้าร้านโดยตรง",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                  fontSize: 20,
                  color: Constant.FONT_COLOR_MENU,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
