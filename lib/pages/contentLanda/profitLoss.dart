import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import 'package:wajib_baca/pages/contentLanda/onPressedCashflow/onPressedCashFlow.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedCashflow/onPressedCashIn.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedCashflow/onPressedCashOut.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedNeraca/onPressedHarta.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedProfitLoss/onPressedExpense.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedProfitLoss/onPressedRevenue.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../sales_overdue_all.dart';
import 'onPressedNeraca/onPressedHutang.dart';
import 'onPressedNeraca/onPressedModal.dart';
import 'onPressedProfitLoss/onPressedProfitLoss.dart';



class ProfitLossLanda extends StatefulWidget {
  ProfitLossLanda({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfitLossLandaState createState() => _ProfitLossLandaState();
}

class _ProfitLossLandaState extends State<ProfitLossLanda> {
  // var now = DateTime.now();
  // String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  // String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  int loading = 0;
  var profitloss;

@override
  void initState() {
    // _profitlossLanda = getProfitLossLanda(nowGlobalService);
  profitloss = getProfitLossLanda(nowGlobalService);
  getCashFlowTotalLanda(nowGlobalService);
  getCashflowPengeluaranLanda(nowGlobalService);
  getCashflowPenerimaanLanda(nowGlobalService);
  getnNeracaLanda(nowGlobalService);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //ProfitLoss
          Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
          padding: EdgeInsets.only(bottom : 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
          ),
          ),
          child: Column(

            children: <Widget>[
              ClipRRect(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10),
                //   topRight: Radius.circular(10),
                // ),
                child: Container(

                     child: InkWell(
                       onTap: (){
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => ExpenseLanda()));
                       },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.grey.withOpacity(0.8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(25, 20, 0, 20),
                                        child: Text(
                                          "Profit & Loss (IDR)",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //GARIS PERTAMA INKWELL 4
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0.5),
                                    child: Container(
                                      height: 1.5,
                                      width: double.maxFinite,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //TEXT PROFIT THIS MONTH
                            InkWell(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[


                                     Padding(
                                      padding: const EdgeInsets.only(top: 15, bottom: 8),
                                      child:
                                      FutureBuilder(
                                        future: getProfitLossLanda(nowGlobalService),
                                        builder: (BuildContext context, snapshot) {

                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(),

                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Container();
                                          }
                                          if (snapshot.hasData) {
                                             var saldo = snapshot.data['data']['data']['total'];
                                             if(saldo >= 0){
                                               return Container(
                                                 child: Text(
                                                     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                     style: Theme.of(context).textTheme.display1.copyWith(
                                                         fontWeight: FontWeight.w500,
                                                         fontSize: 25,
                                                         color: Colors.teal)),
                                               );
                                             }else{
                                               return Container(
                                                 child: Text(
                                                     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                     style: Theme.of(context).textTheme.display1.copyWith(
                                                         fontWeight: FontWeight.w500,
                                                         fontSize: 25,
                                                         color: Colors.deepOrangeAccent)),
                                               );
                                             }
                                          }
                                          return Container();

                                          // if (snapshot.hasData &&
                                          //     snapshot.connectionState == ConnectionState.done) {
                                          //   var saldo = snapshot.data['data']['data']['total'];
                                          //   if(saldo >= 0){
                                          //     return Container(
                                          //       child: Text(
                                          //           NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                          //           style: Theme.of(context).textTheme.display1.copyWith(
                                          //               fontWeight: FontWeight.w500,
                                          //               fontSize: 25,
                                          //               color: Colors.teal)),
                                          //     );
                                          //   }else{
                                          //     return Container(
                                          //       child: Text(
                                          //           NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                          //           style: Theme.of(context).textTheme.display1.copyWith(
                                          //               fontWeight: FontWeight.w500,
                                          //               fontSize: 25,
                                          //               color: Colors.deepOrangeAccent)),
                                          //     );
                                          //   }
                                          // } else {
                                          //   return Container();
                                          // }

                                        },

                                      ),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: FutureBuilder(
                                      future: getProfitLossLanda(nowGlobalService),
                                      builder: (BuildContext context, snapshot) {
                                        if(snapshot.hasData &&
                                            snapshot.connectionState == ConnectionState.done) {
                                          if (snapshot.data['data']['data']['total'] >= 0) {
                                            return Container(
                                              child: Text(
                                                "Profit This Month",
                                                style: Theme.of(context).textTheme.display1.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              ),
                                            );
                                          } else {
                                            return
                                              Container(
                                                child: Text(
                                                  "Loss This Month",
                                                  style: Theme.of(context).textTheme.display1.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              );

                                            // Center(
                                            // child: CircularProgressIndicator(),
                                            // );
                                          }
                                        } else {
                                          return Container(
                                            child: Text(
                                              "Profit & Loss This Month",
                                              style: Theme.of(context).textTheme.display1.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          );
                                        }


                                      },

                                    ),
                                  ),

                                  // Padding(
                                  //   padding: EdgeInsets.only(bottom: 20),
                                  //   child: Text(
                                  //
                                  //     "Profit This Month",
                                  //     style: Theme.of(context).textTheme.display1.copyWith(
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: 15,
                                  //         color: Colors.grey),
                                  //   ),
                                  // ),

                                ],
                              ),
                            ),

                            //ROW 3
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //TEXT CASH IN
                                InkWell(

                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: getProfitLossLanda(nowGlobalService),
                                        builder: (BuildContext context, snapshot) {
                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(),

                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Container(
                                            );
                                          }
                                          if (snapshot.hasData) {
                                              var pendapatan = snapshot.data['data']['detail']['PENDAPATAN']['total'];
                                              var pendapatanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                              var totalPendapatan = pendapatan + pendapatanDU;
                                              return new Container(
                                                child: Text(
                                                    NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalPendapatan),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .display1
                                                        .copyWith(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Colors.black),

                                                ),
                                              );
                                          }
                                          return Container();

                                          // if (snapshot.hasData &&
                                          //     snapshot.connectionState == ConnectionState.done) {
                                          //   var pendapatan = snapshot.data['data']['detail']['PENDAPATAN']['total'];
                                          //   var pendapatanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                          //   var totalPendapatan = pendapatan + pendapatanDU;
                                          //   return new Container(
                                          //     child: Text(
                                          //         NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalPendapatan),
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .display1
                                          //             .copyWith(
                                          //             fontWeight: FontWeight.w500,
                                          //             fontSize: 20,
                                          //             color: Colors.black),
                                          //
                                          //     ),
                                          //   );
                                          // } else {
                                          //   return Center(
                                          //     child: CircularProgressIndicator(),
                                          //   );
                                          // }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Revenue",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //GARIS VERTICAL
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.grey,
                                ),

                                //TEXT CASH OUT
                                InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: getProfitLossLanda(nowGlobalService),
                                        builder: (BuildContext context, snapshot) {

                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(),

                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Container();
                                          }
                                          if (snapshot.hasData) {
                                            var beban = snapshot.data['data']['detail']['BEBAN']['total'];
                                            var bebanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                            var totalBeban = beban + bebanDU;
                                            return Container(
                                              child: Text(
                                                  NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalBeban),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black),

                                              ),
                                            );
                                          }
                                          return Container();

                                          // if (snapshot.hasData &&
                                          //     snapshot.connectionState == ConnectionState.done) {
                                          //   var beban = snapshot.data['data']['detail']['BEBAN']['total'];
                                          //   var bebanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                          //   var totalBeban = beban + bebanDU;
                                          //   return Container(
                                          //     child: Text(
                                          //         NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalBeban),
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .display1
                                          //             .copyWith(
                                          //             fontWeight: FontWeight.w500,
                                          //             fontSize: 20,
                                          //             color: Colors.black)),
                                          //   );
                                          // } else {
                                          //   return Center(
                                          //     child: CircularProgressIndicator(),
                                          //   );
                                          // }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "Expense",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                ),
              ),


            ],
          ),
        ),


        //Cashflow
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
          // padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
            boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: Offset(0, 2), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
            ],
          ),
          child: ClipRRect(
            child: Container(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnPressedCashFlowLanda()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //TEXT CASHFLOW
                        Container(
                          color: Colors.grey.withOpacity(0.8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(25, 20 , 9 ,20),
                                    child: Text(
                                      "Cashflow (IDR)",
                                      style: Theme.of(context).textTheme.display1.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),


                              //GARIS PERTAMA INKWELL 4
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.5),
                                child: Container(
                                  height: 1.5,
                                  width: double.maxFinite,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //TEXT OVERALL BALANCE
                        InkWell(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 8),
                                child: FutureBuilder(
                                  future: getCashFlowTotalLanda(nowGlobalService),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.connectionState == ConnectionState.done) {
                                      if(snapshot.data[0]['data']['data']['total'].length == 0){

                                        return Container(
                                          child: Text(
                                              "Rp. 0",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 25,
                                                  color: Colors.teal)),
                                        );
                                      } else{
                                        var penerimaan = snapshot.data[0]['data']['data']['total']['debit'];
                                        var pengeluaran = snapshot.data[1]['data']['data']['total']['kredit'];
                                        var total = penerimaan - pengeluaran;
                                        if(total > 0){
                                          return Container(
                                            child: Text(
                                                NumberFormat.currency(locale: 'id',
                                                    symbol: "Rp. ",
                                                    decimalDigits: 0).format(
                                                    total),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25,
                                                    color: Colors.teal)),
                                          );
                                        }else{
                                          return Container(
                                            child: Text(
                                                NumberFormat.currency(locale: 'id',
                                                    symbol: "Rp. ",
                                                    decimalDigits: 0).format(
                                                    total),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 25,
                                                    color: Colors.deepOrangeAccent)),
                                          );
                                        }
                                      }
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),

                                      );
                                      }
                                  },
                                ),
                              ),



                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Overall Balance",
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //ROW 3
                        Container(
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //TEXT CASH IN
                                InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: FutureBuilder(
                                          future: getCashflowPenerimaanLanda(nowGlobalService),
                                          builder: (BuildContext context, snapshot) {

                                            if (snapshot.hasData &&
                                                snapshot.connectionState == ConnectionState.done) {
                                              if(snapshot.data['data']['data']['total'].length == 0){
                                                return Container(
                                                  child: Text(
                                                      "Rp. 0",
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,
                                                          color: Colors.green)),
                                                );
                                              } else {
                                                var penerimaan =
                                                snapshot
                                                    .data['data']['data']['total']['debit'];
                                                return Container(
                                                  child: Text(
                                                      NumberFormat.currency(locale: 'id',
                                                          symbol: "Rp. ",
                                                          decimalDigits: 0).format(
                                                          penerimaan),
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,
                                                          color: Colors.black)),
                                                );
                                              }
                                            } else {
                                              return Container(
                                                margin: EdgeInsets.all(10),
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(),

                                              );
                                            }

                                          }
                                        ),
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          "Cash In",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //GARIS VERTICAL
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.grey,
                                ),

                                //TEXT CASH OUT
                                InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: FutureBuilder(
                                          future: getCashflowPengeluaranLanda(nowGlobalService),
                                          builder: (BuildContext context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.data['data']['data']['total'].length == 0) {
                                                return Container(
                                                  child: Text(
                                                      "Rp. 0",
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,
                                                          color: Colors.deepOrange)),
                                                );
                                              } else {
                                                var penerimaan =
                                                snapshot
                                                    .data['data']['data']['total']['debit'];
                                                return Container(
                                                  child: Text(
                                                      NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: "Rp. ",
                                                          decimalDigits: 0).format(
                                                          penerimaan),
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .display1
                                                          .copyWith(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20,
                                                          color: Colors.black)),
                                                );
                                              }
                                            } else {
                                              return Container(
                                                margin: EdgeInsets.all(10),
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(),

                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          "Cash Out",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

            ),
          ),
        ),

        //Neraca
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 10),
          // padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Column(

            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Container(
                     child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            //TEXT Neraca (IDR)
                            Container(
                              color: Colors.grey.withOpacity(0.8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(25, 20, 0, 20),
                                        child: Text(
                                          "Neraca (IDR)",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //GARIS PERTAMA INKWELL 4
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0.5),
                                    child: Container(
                                      height: 1.5,
                                      width: double.maxFinite,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //TEXT PROFIT THIS MONTH
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OnPressedHartaLanda()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[


                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 8),
                                    child:
                                    FutureBuilder(
                                      future: getnNeracaLanda(nowGlobalService),
                                      builder: (BuildContext context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState == ConnectionState.done) {
                                          var saldo = snapshot.data['data']['modelHarta']['total'];
                                          if(saldo > 0){
                                            return Container(
                                              child: Text(
                                                  NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                  style: Theme.of(context).textTheme.display1.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.teal)),
                                            );
                                          }else{
                                            return Container(
                                              child: Text(
                                                  NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                  style: Theme.of(context).textTheme.display1.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 25,
                                                      color: Colors.deepOrangeAccent)),
                                            );
                                          }

                                        } else {
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),

                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "Assets",
                                      style: Theme.of(context).textTheme.display1.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //ROW 3
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //TEXT CASH IN
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ModalLanda()));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: getnNeracaLanda(nowGlobalService),
                                        builder: (BuildContext context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.connectionState == ConnectionState.done) {
                                            var saldo = snapshot.data['data']['modelModal']['total'];
                                            return Container(
                                              child: Text(
                                                  NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            );
                                          } else {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(),

                                            );
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          "Equity",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //GARIS VERTICAL
                                Container(
                                  width: 1,
                                  height: 45,
                                  color: Colors.grey,
                                ),

                                //TEXT CASH OUT
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HutangLanda()));
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: getnNeracaLanda(nowGlobalService),
                                        builder: (BuildContext context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.connectionState == ConnectionState.done) {
                                            var saldo = snapshot.data['data']['modelKewajiban']['total'];
                                            return Container(
                                              child: Text(
                                                  NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.black)),
                                            );
                                          } else {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(),

                                            );
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          "Liabilities",
                                          style: Theme.of(context).textTheme.display1.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                ),
              ),


            ],
          ),
        ),

      ],
    );
  }

}

// class Constans{
//   static const namaBulan = {
//     "01": "Januari",
//     "02": "Februari",
//     "03": "Maret",
//     "04": "April",
//     "05": "Mei",
//     "06": "Juni",
//     "07": "Juli",
//     "08": "Agustus",
//     "09": "September",
//     "10": "Oktober",
//     "11": "November",
//     "12": "Desember",
//   };
//
// }
//
// class BulanConstans{
//   static const bulan = {
//     "01": "01",
//     "02": "02",
//     "03": "03",
//     "04": "04",
//     "05": "05",
//     "06": "06",
//     "07": "07",
//     "08": "08",
//     "09": "09",
//     "10": "10",
//     "11": "11",
//     "12": "12",
//
//   };
// }

