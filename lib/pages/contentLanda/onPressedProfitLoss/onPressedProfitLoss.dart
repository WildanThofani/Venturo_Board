import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';

class OnPressedProfitLossLanda extends StatefulWidget {
  OnPressedProfitLossLanda({Key key}) : super(key: key);

  @override
  _OnPressedProfitLossLandaState createState() =>
      _OnPressedProfitLossLandaState();
}

var now = DateTime.now();
String bulanString =
    Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
int loading = 0;

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

_getTotal(DateTime dt) async {
  print("BulanInt $bulanInt");

  var response = await http
      .get('https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?'
              'endDate=2020-' +
          bulanInt +
          '-31'
              '&export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
              'startDate=2020-' +
          bulanInt +
          '-01');
  return jsonDecode(response.body);
}

Future ambilPendapatanDiluarUsaha(DateTime dt) async {
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
  print(decoded["data"]["detail"]["PENDAPATAN_DILUAR_USAHA"]["detail"]); //iso le
  var subdata = decoded["data"]["detail"]["PENDAPATAN_DILUAR_USAHA"]["detail"];
//  print("\nforEach");
//  subdata.forEach((k,v){
//    print(k);
//    print(v);
//    print("------");
//  });
  return subdata;
}


Future ambilBebanDiluarUsaha(DateTime dt) async {
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
  print(decoded["data"]["detail"]["BEBAN_DILUAR_USAHA"]["detail"]); //iso le
  var subdata = decoded["data"]["detail"]["BEBAN_DILUAR_USAHA"]["detail"];
//  print("\nforEach");
//  subdata.forEach((k,v){
//    print(k);
//    print(v);
//    print("------");
//  });
  return subdata;
}

class _OnPressedProfitLossLandaState extends State<OnPressedProfitLossLanda> {
  nextIntBulan(int i) {
    setState(() {
      if (i == 1) {
        var bln = Jiffy(now).add(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).add(months: 1);
        _getRevenue(now);
        _getExpense(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        _getRevenue(now);
        _getExpense(now);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
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
                onPressed: () => nextIntBulan(2),
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
                onPressed: () => nextIntBulan(1),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white10
          ),
          child: ListView(
            children: <Widget>[
              Container(

                //HEADER
                child: InkWell(
                  child: Center(
                    child: Column(
                      children: <Widget>[

                        //HEADER
                        Container(
                          width: double.maxFinite,
                          color: Colors.grey.withOpacity(0.8),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20 , bottom: 20),
                                child: Text(
                                  "Landa System",
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(top: 3, bottom: 10),
                              //   child: Text(
                              //     "Periode 01 $bulanString 2020 s/d 30 $bulanString 2020",
                              //     style: Theme.of(context).textTheme.display1.copyWith(
                              //         fontWeight: FontWeight.w500,
                              //         fontSize: 12,
                              //         color: Colors.black),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                     

                      ],
                    ),
                  ),
                ),
              ),

              //401 - PENDAPATAN USAHA
              Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                            child: Text(
                            "401 - Pendapatan Usaha",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.black),
                             ),
                          ),
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
                                        return Column(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 200,
                                              height: 150,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/empty_data.png'),
                                                width: size.width,
                                                height: size.width,
                                              ),
                                            ),
                                            Text("Data Kosong",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .display1
                                                    .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                    color: Colors.black87))
                                          ],
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
                                                            children: [
                                                              Container(
                                                                width: size.width *.17,
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
                                                                padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
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
                                      return Center(
                                        child: SizedBox(
                                            height: 25,
                                            width:25,
                                            child: CircularProgressIndicator()),
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


                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15, left: 25, bottom: 20),
                                    child: Text("TOTAL",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black)),
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
                                          ["PENDAPATAN"]["total"];
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
                                          return Center(
                                            child: SizedBox(
                                                height: 20,
                                                width:20,
                                                child: CircularProgressIndicator()),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

              //405 - Pendapatan Luar Usaha
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                        child: Text(
                          "405 - Pendapatan Diluar Usaha",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
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
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200,
                                          height: 150,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/empty_data.png'),
                                            width: size.width,
                                            height: size.width,
                                          ),
                                        ),
                                        Text("Data Kosong",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colors.black87))
                                      ],
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
                                                        children: [
                                                          Container(
                                                            width: size.width *.17,
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
                                                            padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
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
                                  return Center(
                                    child: SizedBox(
                                        height: 25,
                                        width:25,
                                        child: CircularProgressIndicator()),
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


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 15, left: 25, bottom: 20),
                                child: Text("TOTAL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black)),
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
                                      ["PENDAPATAN_DILUAR_USAHA"]["total"];
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
                                      return Center(
                                        child: SizedBox(
                                            height: 20,
                                            width:20,
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //500 - Beban Usaha
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                        child: Text(
                          "500 - Beban Usaha",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
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
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200,
                                          height: 150,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/empty_data.png'),
                                            width: size.width,
                                            height: size.width,
                                          ),
                                        ),
                                        Text("Data Kosong",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colors.black87))
                                      ],
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
                                                        children: [
                                                          Container(
                                                            width: size.width *.17,
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
                                                            padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
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
                                  return Center(
                                    child: SizedBox(
                                        height: 25,
                                        width:25,
                                        child: CircularProgressIndicator()),
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


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 15, left: 25, bottom: 20),
                                child: Text("TOTAL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black)),
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
                                      return Center(
                                        child: SizedBox(
                                            height: 20,
                                            width:20,
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
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
                    Container(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                        child: Text(
                          "550 - Beban Diluar Usaha",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
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
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 200,
                                          height: 150,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/empty_data.png'),
                                            width: size.width,
                                            height: size.width,
                                          ),
                                        ),
                                        Text("Data Kosong",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1
                                                .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colors.black87))
                                      ],
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
                                                        children: [
                                                          Container(
                                                            width: size.width *.17,
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
                                                            padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
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
                                  return Center(
                                    child: SizedBox(
                                        height: 25,
                                        width:25,
                                        child: CircularProgressIndicator()),
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


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 15, left: 25, bottom: 20),
                                child: Text("TOTAL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black)),
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
                                      return Center(
                                        child: SizedBox(
                                            height: 20,
                                            width:20,
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
