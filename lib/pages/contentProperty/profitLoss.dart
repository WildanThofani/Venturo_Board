import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';
import 'package:wajib_baca/Service/profitLossAPI.dart';
import 'package:wajib_baca/classModel/profitLossModel.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedCashflow/onPressedCashFlow.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedCashflow/onPressedCashIn.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedCashflow/onPressedCashOut.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedNeraca/onPressedHarta.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedNeraca/onPressedHutang.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedNeraca/onPressedModal.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedProfitLoss/onPressedExpense.dart';
import 'package:wajib_baca/pages/contentProperty/salesOverdue.dart';

import 'onPressedProfitLoss/onPressedProfitLoss.dart';
import 'onPressedProfitLoss/onPressedRevenue.dart';

class ProfitLossProperty extends StatefulWidget {
  ProfitLossProperty({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfitLossPropertyState createState() => _ProfitLossPropertyState();
}

class _ProfitLossPropertyState extends State<ProfitLossProperty> {
//   var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  int loading = 0;
//  var bulann = DateFormat('MM').format(DateTime.now());


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
                              builder: (context) => ExpenseProperty()));
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
                                  future: getProfitLossProp(nowGlobalService),
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
                                  future: getProfitLossProp(nowGlobalService),
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
                                    future: getProfitLossProp(nowGlobalService),
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
                                    future: getProfitLossProp(nowGlobalService),
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
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnPressedCashFlowProperty()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 8),
                            child: FutureBuilder(
                              future: getCashFlowTotalProp(nowGlobalService),
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
                                    if(snapshot.data[0]['data']['data']['total'].length == 0
                                        && snapshot.data[1]['data']['data']['total'].length == 0) {
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
                                    }
                                    var penerimaan = snapshot.data[0]['data']['data']['total']['debit'];
                                    var penerimaan0 = snapshot.data[0]['data']['data']['total'].length == 0;
                                    var pengeluaran = snapshot.data[1]['data']['data']['total']['kredit'];
                                    var pengeluaran0 = snapshot.data[1]['data']['data']['total'].length == 0;

                                    print("penerimaan0 + pengeluaran0 $penerimaan0 $pengeluaran0");

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
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CashInProperty()));
                              },
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: FutureBuilder(
                                        future: getCashflowPenerimaanProp(nowGlobalService),
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
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CashOutProperty()));
                              },
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: FutureBuilder(
                                      future: getCashflowPengeluaranProp(nowGlobalService),
                                      builder: (BuildContext context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.connectionState == ConnectionState.done) {
                                          if (snapshot.data['data']['data']['total'][0].length == 0) {
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
                                    builder: (context) => OnPressedHartaProperty()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[


                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 8),
                                child:
                                FutureBuilder(
                                  future: getnNeracaProp(nowGlobalService),
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
                                        builder: (context) => ModalProperty()));
                              },
                              child: Column(
                                children: <Widget>[
                                  FutureBuilder(
                                    future: getnNeracaProp(nowGlobalService),
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
                                        builder: (context) => HutangProperty()));
                              },
                              child: Column(
                                children: <Widget>[
                                  FutureBuilder(
                                    future: getnNeracaProp(nowGlobalService),
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


