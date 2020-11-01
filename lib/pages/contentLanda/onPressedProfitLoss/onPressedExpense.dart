import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';

enum WidgetMarkerProfitLoss { revenue, expense }

class ExpenseLanda extends StatefulWidget {
  @override
  ExpenseLandaState createState() => ExpenseLandaState();


}


class ExpenseLandaState extends State<ExpenseLanda> {
  WidgetMarkerProfitLoss selectedWidgetMarker = WidgetMarkerProfitLoss.revenue;
  var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];



  Future ambilBeban(DateTime dt) async {
    var data = await http.get('https://accventuro.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' + bulanInt + '-31'
        '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'startDate=2020-' + bulanInt + '-01');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["detail"]["BEBAN"]["detail"]);//iso le
    var subdata =  decoded["data"]["detail"]["BEBAN"]["detail"];
    print("\nforEach");
    subdata.forEach((k,v){
      print(k);
      print(v);
      print("------");
    });
    return subdata;

  }


  Future ambilBebanDiluarUsaha(DateTime dt) async {
    var data = await http.get('https://accventuro.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' + bulanInt + '-31'
        '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'startDate=2020-' + bulanInt + '-01');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["detail"]["BEBAN_DILUAR_USAHA"]["detail"]);//iso le
    var subdata =  decoded["data"]["detail"]["BEBAN_DILUAR_USAHA"]["detail"];
    print("\nforEach");
    subdata.forEach((k,v){
      print(k);
      print(v);
      print("------");
    });
    return subdata;
  }

  _getProfitLoss(DateTime dt) async {
    print("BulanInt $bulanInt");

    var response = await http.get(
        "https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?endDate=2020-" +
            bulanInt +
//            "07" +
            "-31&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&startDate=2020-" +
            bulanInt +
//                "07" +
            "-01");
    print("BulanString $bulanString");
    print("responBody ${response.body}");
    return jsonDecode(response.body);
  }

  Future ambil(DateTime dt) async {
    var data = await http.get('https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' + bulanInt + '-31'
        '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'startDate=2020-' + bulanInt + '-01');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["detail"]["PENDAPATAN"]["detail"]);//iso le
    var subdata =  decoded["data"]["detail"]["PENDAPATAN"]["detail"];
//    print("\nforEach");
//    subdata.forEach((k,v){
//      print(k);
//      print(v);
//      print("------");
//    });
    return subdata;

  }

  Future ambilPendapatanDiluarUsaha(DateTime dt) async {
    var data = await http.get('https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' + bulanInt + '-31'
        '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'startDate=2020-' + bulanInt + '-01');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["detail"]["PENDAPATAN_DILUAR_USAHA"]["detail"]);//iso le
    var subdata =  decoded["data"]["detail"]["PENDAPATAN_DILUAR_USAHA"]["detail"];
//    print("\nforEach");
//    subdata.forEach((k,v){
//      print(k);
//      print(v);
//      print("------");
//    });
    return subdata;
  }

  _getTotal(DateTime dt) async {
    print("BulanInt $bulanInt");

    var response = await http.get(
        'https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
            'endDate=2020-' + bulanInt + '-31'
            '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
            'startDate=2020-' + bulanInt + '-01');
    return jsonDecode(response.body);
  }


  Future _getRevenue(DateTime dt) async {
    var data = await http
        .get('https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' +
        bulanInt +
        '-31'
            '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
            'startDate=2020-' +
        bulanInt +
        '-01');

    var decoded = jsonDecode(data.body);
    var subdata = decoded["data"]["detail"]["PENDAPATAN"]["detail"];
//  print("\nforEach");
//  subdata.forEach((k,v){
//    print(k);
//    print(v);
//    print("------");
//  });
    return subdata;
  }

  Future _getExpense(DateTime dt) async {
    var data = await http
        .get('https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
        'endDate=2020-' +
        bulanInt +
        '-31'
            '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
            'startDate=2020-' +
        bulanInt +
        '-01');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["detail"]["BEBAN"]["detail"]); //iso le
    var subdata = decoded["data"]["detail"]["BEBAN"]["detail"];
//  print("\nforEach");
//  subdata.forEach((k,v){
//    print(k);
//    print(v);
//    print("------");
//  });
    return subdata;
  }



  nextIntBulan(int i){
    setState(() {
      if (i == 1) {
        var bln = Jiffy(now).add(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).add(months: 1);
        ambilBeban(now);
        ambilBebanDiluarUsaha(now);
        ambilPendapatanDiluarUsaha(now);
        _getProfitLoss(now);
        ambil(now);
        _getTotal(now);
        _getRevenue(now);
        _getExpense(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        ambilBeban(now);
        ambilBebanDiluarUsaha(now);
        ambilPendapatanDiluarUsaha(now);
        _getProfitLoss(now);
        ambil(now);
        _getTotal(now);
        _getRevenue(now);
        _getExpense(now);
      }
    });
  }


  @override
  void initState() {
    ambilBeban(now);
    selectedCategory.add(category1);
    super.initState();
  }

  List<String> selectedCategory = new List<String>();
  String category1 = 'category 1';
  String category2 = 'category 2';



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.redAccent,
            title: Text("Profit & Loss"),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.redAccent,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      nextIntBulan(2);
                    });

                  },
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: Text(
                    bulanString,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      nextIntBulan(1);
                    });

                  },
                ),
              ],
            ),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
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
                            child: Container(

                              child: InkWell(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    Container(
                                      width: double.maxFinite,
                                      color: Colors.grey.withOpacity(0.8),
                                      child: InkWell(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[


                                            Padding(
                                              padding: const EdgeInsets.only(top: 15, bottom: 8),
                                              child:
                                              FutureBuilder(
                                                future: _getProfitLoss(now),
                                                builder: (BuildContext context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    var saldo = snapshot.data['data']['data']['total'];
                                                    if(saldo > 0){
                                                      return Container(
                                                        child: Text(
                                                            NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                            style: Theme.of(context).textTheme.display1.copyWith(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 25,
                                                                color: Colors.teal,
                                                                shadows: <Shadow>[
                                                                  Shadow(
                                                                    offset: Offset(0.8, 0.5),
                                                                    blurRadius: 0.0,
                                                                    color: Colors.white,
                                                                  ),

                                                                ])),
                                                      );
                                                    }else{
                                                      return Container(
                                                        child: Text(
                                                            NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                            style: Theme.of(context).textTheme.display1.copyWith(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 25,
                                                                color: Colors.deepOrangeAccent,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(1.0, 1.0),
                                                                blurRadius: 1.0,
                                                                color: Colors.white,
                                                              ),
                                                            ])),
                                                      );
                                                    }

                                                  } else {
                                                    return Container();
                                                  }

                                                },

                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20.0),
                                              child: FutureBuilder(
                                                future:   _getProfitLoss(now),
                                                builder: (BuildContext context, snapshot) {
                                                  if(snapshot.hasData) {
                                                    if (snapshot.data['data']['data']['total'] > 0) {
                                                      return Container(
                                                        child: Text(
                                                          "Profit This Month",
                                                          style: Theme.of(context).textTheme.display1.copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15,
                                                              color: Colors.white),
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
                                                                color: Colors.white),
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
                                                            color: Colors.white),
                                                      ),
                                                    );
                                                  }


                                                },

                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    //ROW 3
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //TEXT CASH IN
                                              Container(

                                                child: InkWell(
                                                splashColor: Colors.blue[100],
                                                onTap: (){
                                                  selectedCategory = new List<String>();
                                                  selectedCategory.add(category1);
                                                  setState(() {
                                                    selectedWidgetMarker = WidgetMarkerProfitLoss.revenue;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 13.0),
                                                  width: size.width/2,
                                                  decoration: BoxDecoration(
                                                    color: selectedCategory.contains(category1) ? Colors.white : Colors.grey.withOpacity(0.3),
                                                    // borderRadius: BorderRadius.only(
                                                    //   // topLeft: Radius.circular(5),
                                                    //   topRight: Radius.circular(5),
                                                    // ),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      FutureBuilder(
                                                        future: _getProfitLoss(now),
                                                        builder: (BuildContext context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            var pendapatan = snapshot.data['data']['detail']['PENDAPATAN']['total'];
                                                            var pendapatanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                                            var totalPendapatan = pendapatan + pendapatanDU;
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalPendapatan),
                                                                      style: Theme.of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 19,
                                                                          color: Colors.black)),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                    child: Text(
                                                                      "Revenue",
                                                                      style: Theme.of(context).textTheme.display1.copyWith(
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 15,
                                                                          color: Colors.black),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else {
                                                            return Container();
                                                          }
                                                        },
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                            ),
                                              ),

                                              InkWell(
                                              splashColor: Colors.blue[100],
                                              onTap: (){
                                                selectedCategory = new List<String>();
                                                selectedCategory.add(category2);
                                                print("selectedCate $category2");
                                                setState(() {
                                                  selectedWidgetMarker = WidgetMarkerProfitLoss.expense;
                                                });
                                              },

                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 13.0),
                                                width: size.width / 2,
                                                decoration: BoxDecoration(
                                                  color: selectedCategory.contains(category2) ? Colors.white : Colors.grey.withOpacity(0.3),
                                                  // borderRadius: BorderRadius.only(
                                                  //   topLeft: Radius.circular(5),
                                                  //   // topRight: Radius.circular(5),
                                                  // ),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    FutureBuilder(
                                                      future: _getProfitLoss(now),
                                                      builder: (BuildContext context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          var beban = snapshot.data['data']['detail']['BEBAN']['total'];
                                                          var bebanDU = snapshot.data['data']['detail']['PENDAPATAN_DILUAR_USAHA']['total'];
                                                          var totalBeban = beban + bebanDU;
                                                          return Container(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(totalBeban),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .display1
                                                                        .copyWith(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 19,
                                                                        color: Colors.black)),

                                                                Padding(
                                                                  padding: EdgeInsets.only(bottom: 5),
                                                                  child: Text(
                                                                    "Expense",
                                                                    style: Theme.of(context).textTheme.display1.copyWith(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 15,
                                                                        color: Colors.black),
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
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

                    Container(
                      child: getCustomContainer(),
                    )





                  ],
                ),

              ],
            ),
          )
      ),
    );
  }

  Widget getCustomContainer(){
    switch(selectedWidgetMarker) {
      case WidgetMarkerProfitLoss.revenue:
        return revenue();
      case WidgetMarkerProfitLoss.expense:
        return expense();
    }
  }

  Widget revenue() {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          //401 - PENDAPATAN USAHA
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 0, 20),
                        child: Text(
                          "401 - Pendapatan Usaha",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                    ),

                    //TOTAL
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 25, bottom: 0),
                      child: FutureBuilder(
                        future: _getTotal(now),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            var total = snapshot.data["data"]["detail"]
                            ["PENDAPATAN"]["total"];
                            if(total == 0) {
                              return Container();
                            }
                            return Container(
                              child: Text(
                                  NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Rp. ",
                                      decimalDigits: 0)
                                      .format(total),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                            );
                          } else {
                            return Container(
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: FutureBuilder(
                          future: _getRevenue(now),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length == 0) {
                                return Container(
                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListView.separated(
                                        separatorBuilder: (context, index) => Divider(
                                          color: Colors.black,
                                        ),
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          print(
                                              "expense length ${snapshot.data.length}");
                                          var key = snapshot.data.keys
                                              .toList()[index];
                                          var kode =
                                          snapshot.data[key]['kode'];
                                          var nama =
                                          snapshot.data[key]['nama2'];
                                          var nominal =
                                          snapshot.data[key]['nominal'];
                                          return Container(
                                            child: InkWell(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(

                                                        child: InkWell(
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                            child: Text(
                                                                kode,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .display1
                                                                    .copyWith(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Colors.black)
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                        child: Text(
                                                            "-",
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .display1
                                                                .copyWith(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                                color: Colors.black)
                                                        ),
                                                      ),

                                                      Container(
                                                        width: size.width * .45,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                          child: Text(
                                                              "$nama",
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: Colors.black)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 15, 25, 10),
                                                    child: Text(
                                                        NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(nominal),

                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Colors.black)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }
                            } else {
                              return Container(
                                height: size.height / 2, //70.0,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),


                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.black,
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),

          //405 - Pendapatan Luar Usaha
          Container(
            color : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 0, 20),
                        child: Text(
                          "405 - Pendapatan Diluar Usaha",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                    ),

                    //TOTAL
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 25, bottom: 20, top: 20),
                      child: FutureBuilder(
                        future: _getTotal(now),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            var total = snapshot.data["data"]["detail"]
                            ["PENDAPATAN_DILUAR_USAHA"]["total"];
                            if (total == 0) {
                              return Container();
    }
                            return Container(
                              child: Text(
                                  NumberFormat.currency(
                                      locale: 'id',
                                      symbol: "Rp. ",
                                      decimalDigits: 0)
                                      .format(total),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black)),
                            );
                          } else {
                            return Container(
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),


                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: FutureBuilder(
                          future: ambilPendapatanDiluarUsaha(now),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length == 0) {
                                return Container(


                                );
                              } else {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListView.separated(
                                        separatorBuilder: (context, index) => Divider(
                                          color: Colors.black,
                                        ),
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          print(
                                              "expense length ${snapshot.data.length}");
                                          var key = snapshot.data.keys
                                              .toList()[index];
                                          var kode =
                                          snapshot.data[key]['kode'];
                                          var nama =
                                          snapshot.data[key]['nama2'];
                                          var nominal =
                                          snapshot.data[key]['nominal'];
                                          return Container(
                                            child: InkWell(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: InkWell(
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                            child: Text(
                                                                kode,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .display1
                                                                    .copyWith(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Colors.black)
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                        child: Text(
                                                            "-",
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .display1
                                                                .copyWith(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 15,
                                                                color: Colors.black)
                                                        ),
                                                      ),

                                                      Container(
                                                        width: size.width * .45,
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                          child: Text(
                                                              nama,
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: Colors.black)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 15, 25, 10),
                                                    child: Text(
                                                        NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(nominal),

                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .display1
                                                            .copyWith(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 15,
                                                            color: Colors.black)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }
                            } else {
                              return Container(
                              );
                            }
                          },
                        ),
                      ),


                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.black,
                          ),

                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

  Widget expense() {
    var size = MediaQuery.of(context).size;
    return Container(
      color : Colors.white,
        child: Column(
          children: [
            //500 - Beban Usaha
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20, 0, 20),
                          child: Text(
                            "500 - Beban Usaha",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                      ),


                      //TOTAL
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 25, bottom: 20),
                        child: FutureBuilder(
                          future: _getTotal(now),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              var total = snapshot.data["data"]["detail"]
                              ["BEBAN"]["total"];
                              if(total == 0) {
                                return Container();
                              }
                              return Container(
                                child: Text(
                                    NumberFormat.currency(
                                        locale: 'id',
                                        symbol: "Rp. ",
                                        decimalDigits: 0)
                                        .format(total),
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black)),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),


                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: FutureBuilder(
                            future: _getExpense(now),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container();
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            print(
                                                "expense length ${snapshot.data.length}");
                                            var key = snapshot.data.keys
                                                .toList()[index];
                                            var kode =
                                            snapshot.data[key]['kode'];
                                            var nama =
                                            snapshot.data[key]['nama2'];
                                            var nominal =
                                            snapshot.data[key]['nominal'];
                                            return Container(
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(

                                                          child: InkWell(
                                                            child: Padding(
                                                              padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                              child: Text(
                                                                  kode,
                                                                  style: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .display1
                                                                      .copyWith(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 15,
                                                                      color: Colors.black)
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                          child: Text(
                                                              "-",
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: Colors.black)
                                                          ),
                                                        ),

                                                        Container(
                                                          width: size.width * .45,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                            child: Text(
                                                                nama,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .display1
                                                                    .copyWith(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Colors.black)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 15, 25, 10),
                                                      child: Text(
                                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(nominal),

                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .display1
                                                              .copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15,
                                                              color: Colors.black)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  );
                                }
                              } else {
                                return Container(
                                  height: size.height / 2, //70.0,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),


                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              height: 1,
                              width: double.maxFinite,
                              color: Colors.black,
                            ),

                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),

            //550 - Beban Diluar Usaha
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20, 0, 20),
                          child: Text(
                            "550 - Beban Diluar Usaha",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                      ),


                      //TOTAL
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 25, bottom: 20),
                        child: FutureBuilder(
                          future: _getTotal(now),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              var total = snapshot.data["data"]["detail"]
                              ["BEBAN_DILUAR_USAHA"]["total"];
                              if(total == 0) {
                                return Container();
                              }
                              return Container(
                                child: Text(
                                    NumberFormat.currency(
                                        locale: 'id',
                                        symbol: "Rp. ",
                                        decimalDigits: 0)
                                        .format(total),
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black)),
                              );
                            } else {
                              return Container();

                            }
                          },
                        ),
                      ),
                    ],
                  ),


                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: FutureBuilder(
                            future: ambilBebanDiluarUsaha(now),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length == 0) {
                                  return Container();
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            print(
                                                "expense length ${snapshot.data.length}");
                                            var key = snapshot.data.keys
                                                .toList()[index];
                                            var kode =
                                            snapshot.data[key]['kode'];
                                            var nama =
                                            snapshot.data[key]['nama2'];
                                            var nominal =
                                            snapshot.data[key]['nominal'];
                                            return Container(
                                              child: InkWell(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          child: InkWell(
                                                            child: Padding(
                                                              padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                              child: Text(
                                                                  kode,
                                                                  style: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .display1
                                                                      .copyWith(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 15,
                                                                      color: Colors.black)
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                          child: Text(
                                                              "-",
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .display1
                                                                  .copyWith(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 15,
                                                                  color: Colors.black)
                                                          ),
                                                        ),

                                                        Container(
                                                          width: size.width * .45,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(8, 15, 0, 10),
                                                            child: Text(
                                                                nama,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .display1
                                                                    .copyWith(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Colors.black)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 15, 25, 10),
                                                      child: Text(
                                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(nominal),

                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .display1
                                                              .copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15,
                                                              color: Colors.black)
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  );
                                }
                              } else {
                                return Container(
                                  height: size.height / 2, //70.0,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),


                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              height: 1,
                              width: double.maxFinite,
                              color: Colors.black,
                            ),

                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );

  }

}