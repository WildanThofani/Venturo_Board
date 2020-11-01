import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import '../sales_overdue_all.dart';
import 'onPressedSalesOverdue/onPressedSalesOverdue.dart';

class SalesOverdueLanda extends StatefulWidget {
  SalesOverdueLanda({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SalesOverdueLandaState createState() => _SalesOverdueLandaState();
}

_getSalesOverdue() async{
  var response = await http.get(
      "https://2019.landa.co.id/api/laporanpiutang/index?status_lunas=belum_lunas"
  );
  return jsonDecode(response.body);
}


class _SalesOverdueLandaState extends State<SalesOverdueLanda> {

  @override
  void initState() {
    _getSalesOverdue();
    super.initState();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
      width: double.infinity,
      decoration: BoxDecoration( //decoration for the outer wrapper
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), //border radius exactly to ClipRRect
        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2), // changes position of shadow
          ),
          //you can set more BoxShadow() here
        ],
      ) ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          child: Container(
            child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //ROW PERTAMA INKWELL 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        //TEXT SALESOVERDUE
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 8, 5),
                          child: Text(
                            "Sales Overdue",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),

                        //BUTTON SEE ALL
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 2, 5),
                          child: FlatButton(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "See All",
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 15,
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnPressedSalesOverdueLanda()));
                            },
                          ),
                        )
                      ],
                    ),

                    //GARIS PERTAMA INKWELL 2
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.5),
                      child: Container(
                        height: 1.5,
                        width: double.maxFinite,
                        color: Colors.grey,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //TEXT Sales overdue
                        Padding(
                          padding: const EdgeInsets.only(right: 85),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 2),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot) {

                                    if(snapshot.hasData) {
                                      var totalOverdue = snapshot.data['data']['totalItems'];
                                      return Container(
                                        child: Text(
                                            "$totalOverdue",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 23,
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
                                  }

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1, bottom: 10),
                                child: Text(
                                  "Sales Overdue",
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //GARIS VERTICAL
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: 1,
                            height: size.height * 0.050,
                            color: Colors.grey,
                          ),
                        ),

                        //TEXT TOTAL 0
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[



                                    Padding(
                                      padding: EdgeInsets.only(top: 10, bottom: 2),
                                      child: FutureBuilder(
                                          future: _getSalesOverdue(),
                                          builder: (BuildContext context, snapshot) {
                                            if(snapshot.hasData) {
                                              var BKDSampang = snapshot.data['data']['listSumTagihan']['BKD Sampang'];
                                              var a = int.parse(BKDSampang);

                                              var kafilah = snapshot.data['data']['listSumTagihan']['Kafilah'];
                                              var b = int.parse(kafilah);

                                              var masterPrima = snapshot.data['data']['listSumTagihan']['Master Prima'];
                                              var c = int.parse(masterPrima);

                                              var pasarKotaPondokGede = snapshot.data['data']['listSumTagihan']['Pasar Kota Pondok Gede'];
                                              var d = int.parse(pasarKotaPondokGede);

                                              var ptAmakFirdausUtomo = snapshot.data['data']['listSumTagihan']['PT. Amak Firdaus Utomo'];
                                              var e = int.parse(ptAmakFirdausUtomo);

                                              var smkYP17Pare = snapshot.data['data']['listSumTagihan']['SMK YP 17 Pare'];
                                              var f = int.parse(smkYP17Pare);

                                              var ummiMALANG = snapshot.data['data']['listSumTagihan']['UMMI MALANG'];
                                              var g = int.parse(ummiMALANG);

                                              var yayasanSunniyahSalafiah = snapshot.data['data']['listSumTagihan']['Yayasan Sunniyah Salafiah'];
                                              var h = int.parse(yayasanSunniyahSalafiah);

                                              var listSumTagihan = a + b + c + d + e + f + g + h;
                                              return Container(
                                                child: Text(
                                                    NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(listSumTagihan),
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .display1
                                                        .copyWith(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 15,
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
                                          }

                                      ),
                                    ),
                              Padding(
                                padding: EdgeInsets.only(top: 2, bottom: 10),
                                child: Text(
                                  "Total",
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
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
    );
  }
}

//Widget salesOverdueWidgetLanda(BuildContext context) {
//  var size = MediaQuery.of(context).size;
//
//  return Container(
//    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
//    padding: EdgeInsets.all(5),
//    width: double.infinity,
//    decoration: BoxDecoration(
//        color: Colors.white, borderRadius: BorderRadius.circular(20)),
//    child: InkWell(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          //ROW PERTAMA INKWELL 2
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.fromLTRB(15, 20, 8, 20),
//                child: Text(
//                  "Sales Overdue",
//                  style: Theme.of(context).textTheme.display1.copyWith(
//                      fontWeight: FontWeight.w700,
//                      fontSize: 18,
//                      color: Colors.black),
//                ),
//              ),
//              FlatButton(
//                child: Row(
//                  children: <Widget>[
//                    Text(
//                      "See All",
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                          fontWeight: FontWeight.w700,
//                          fontSize: 14,
//                          color: Colors.grey[500]),
//                    ),
//                    Icon(
//                      Icons.arrow_forward_ios,
//                      color: Colors.grey[500],
//                      size: 15,
//                    )
//                  ],
//                ),
//                onPressed: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SalesOverDueAll()));
//                },
//              )
//            ],
//          ),
//
//          //GARIS PERTAMA INKWELL 2
//          Padding(
//            padding: EdgeInsets.symmetric(horizontal: 0.5),
//            child: Container(
//              height: 1.5,
//              width: double.maxFinite,
//              color: Colors.grey[200],
//            ),
//          ),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              //TEXT Sales overdue
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(top: 10, bottom: 5),
//                    child: Text(
//                      "0",
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                          fontWeight: FontWeight.w700,
//                          fontSize: 20,
//                          color: Colors.deepOrangeAccent),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top: 5, bottom: 10),
//                    child: Text(
//                      "Sales Overdue",
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                          fontWeight: FontWeight.w700,
//                          fontSize: 13,
//                          color: Colors.grey[500]),
//                    ),
//                  ),
//                ],
//              ),
//
//              //GARIS VERTICAL
//              Container(
//                width: 1,
//                height: size.height * 0.050,
//                color: Colors.grey[500],
//              ),
//
//              //TEXT TOTAL 0
//              Column(
////                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(top: 10, bottom: 5),
//                    child: Text(
//                      "Total",
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                          fontWeight: FontWeight.w700,
//                          fontSize: 15,
//                          color: Colors.grey[500]),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top: 8, bottom: 10),
//                    child: Text(
//                      "Rp. 0",
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                          fontWeight: FontWeight.w700,
//                          fontSize: 20,
//                          color: Colors.black),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    ),
//  );
//}
