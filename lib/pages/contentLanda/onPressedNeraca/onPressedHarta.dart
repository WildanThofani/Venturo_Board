import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';

enum WidgetMarkerNeraca { bank, piutang, asset }

class OnPressedHartaLanda extends StatefulWidget {
  OnPressedHartaLanda({Key key}) : super(key: key);

  @override
  _OnPressedHartaLandaState createState() =>
      _OnPressedHartaLandaState();
}


class _OnPressedHartaLandaState extends State<OnPressedHartaLanda> {
  WidgetMarkerNeraca selectedWidgetMarker = WidgetMarkerNeraca.bank;

  var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];


  Future ambilHartaBank(DateTime dt) async {
    var data = await http.get('https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'tanggal=2020-' + bulanInt + '-31');

    var decoded = jsonDecode(data.body);
    print(" ambilHarta Decoded${decoded["data"]["modelHarta"]["list"]["2"]["detail"]}");//iso le
    var subdata =  decoded["data"]["modelHarta"]["list"]["2"]["detail"];
    print("\nforEach");
    subdata.forEach((k){
      print(k);
      print("------");
    });
    return subdata;
  }

  Future ambilHartaPiutang(DateTime dt) async {
    var data = await http.get('https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'tanggal=2020-' + bulanInt + '-10');

    var decoded = jsonDecode(data.body);
    print(" ambilHarta Decoded${decoded["data"]["modelHarta"]["list"]["3"]["detail"]}");//iso le
    var subdata =  decoded["data"]["modelHarta"]["list"]["3"]["detail"];
    print("\nforEach");
    subdata.forEach((k){
      print(k);
      print("------");
    });
    return subdata;
  }

  Future ambilHartaAssetTetap(DateTime dt) async {
    var data = await http.get('https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'tanggal=2020-' + bulanInt + '-10');

    var decoded = jsonDecode(data.body);
    print(" ambilHarta Decoded${decoded["data"]["modelHarta"]["list"]["7"]["detail"]}");//iso le
    var subdata =  decoded["data"]["modelHarta"]["list"]["7"]["detail"];
    print("\nforEach");
    subdata.forEach((k){
      print(k);
      print("------");
    });
    return subdata;
  }

  _getTotal(DateTime dt) async {
    print("BulanInt $bulanInt");

    var response = await http.get(
        'https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
            'tanggal=2020-' + bulanInt + '-10');
    return jsonDecode(response.body);
  }

  nextIntBulan(int i){
    setState(() {
      if (i == 1) {
        var bln = Jiffy(now).add(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).add(months: 1);
        ambilHartaBank(now);
        ambilHartaPiutang(now);
        ambilHartaAssetTetap(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        ambilHartaBank(now);
        ambilHartaPiutang(now);
        ambilHartaAssetTetap(now);
      }
    });
  }

  @override
  void initState() {
    ambilHartaBank(now);
    selectedCategory.add(category1);
    super.initState();
  }

  List<String> selectedCategory = new List<String>();
  String category1 = 'category 1';
  String category2 = 'category 2';
  String category3 = 'category 3';

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
            title: Text("Assets"),
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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        bulanString + " 2020",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),

                  ],
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
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      color: Colors.grey.withOpacity(0.8),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Landa System",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

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
                                        onTap: (){
                                          selectedCategory = new List<String>();
                                          selectedCategory.add(category1);
                                          setState(() {
                                            selectedWidgetMarker = WidgetMarkerNeraca.bank;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 13.0),
                                          width: size.width / 2,
                                          decoration: BoxDecoration(
                                            color: selectedCategory.contains(category1) ? Colors.white : Colors.grey.withOpacity(0.3),
                                            // borderRadius: BorderRadius.only(
                                            //   topLeft: Radius.circular(5),
                                            //   // topRight: Radius.circular(5),
                                            // ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[


                                              Padding(
                                                padding: const EdgeInsets.only(top: 15, bottom: 8),
                                                child:
                                                FutureBuilder(
                                                  future: _getTotal(now),
                                                  builder: (BuildContext context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      var saldo = snapshot.data["data"]["modelHarta"]["list"]["2"]["total"];
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
                                                child: Text(
                                                  "BANK",
                                                  style: Theme.of(context).textTheme.display1.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                              ),

                                            ],
                                          ),
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
                                              selectedCategory.add(category2);
                                              setState(() {
                                                selectedWidgetMarker = WidgetMarkerNeraca.piutang;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 13.0),
                                              width: size.width/2,
                                              decoration: BoxDecoration(
                                                color: selectedCategory.contains(category2) ? Colors.white : Colors.grey.withOpacity(0.3),
                                                // borderRadius: BorderRadius.only(
                                                //   // topLeft: Radius.circular(5),
                                                //   topRight: Radius.circular(5),
                                                // ),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  FutureBuilder(
                                                    future: _getTotal(now),
                                                    builder: (BuildContext context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var total = snapshot.data["data"]["modelHarta"]["list"]["3"]["total"];
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
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 5),
                                                    child: Text(
                                                      "Piutang",
                                                      style: Theme.of(context).textTheme.display1.copyWith(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
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
                                            selectedCategory.add(category3);
                                            print("selectedCate $category2");
                                            setState(() {
                                              selectedWidgetMarker = WidgetMarkerNeraca.asset;
                                            });
                                          },

                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 13.0),
                                            width: size.width / 2,
                                            decoration: BoxDecoration(
                                              color: selectedCategory.contains(category3) ? Colors.white : Colors.grey.withOpacity(0.3),
                                              // borderRadius: BorderRadius.only(
                                              //   topLeft: Radius.circular(5),
                                              //   // topRight: Radius.circular(5),
                                              // ),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                FutureBuilder(
                                                  future: _getTotal(now),
                                                  builder: (BuildContext context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      var total = snapshot.data["data"]["modelHarta"]["list"]["7"]["total"];
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
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 5),
                                                  child: Text(
                                                    "Asset Tetap",
                                                    style: Theme.of(context).textTheme.display1.copyWith(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
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
  Widget getCustomContainer() {
    switch(selectedWidgetMarker) {
      case WidgetMarkerNeraca.bank:
        return bank();
      case WidgetMarkerNeraca.piutang:
        return piutang();
      case WidgetMarkerNeraca.asset:
        return asset();
    }
  }

  Widget bank() {
    var size = MediaQuery.of(context).size;
    //120 - Bank
   return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Container(
          //         padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
          //         child: Text(
          //           "120 - Bank",
          //           style: Theme.of(context).textTheme.display1.copyWith(
          //               fontWeight: FontWeight.w700,
          //               fontSize: 17,
          //               color: Colors.black),
          //         ),
          //       ),
          //       Padding(
          //         padding:
          //         const EdgeInsets.only(right: 25, bottom: 20, top: 20),
          //         child: FutureBuilder(
          //           future: _getTotal(now),
          //           builder: (BuildContext context, snapshot) {
          //             if (snapshot.hasData) {
          //               var total = snapshot.data["data"]["modelHarta"]["list"]["2"]["total"];
          //               return Container(
          //                 child: Text(
          //                     NumberFormat.currency(
          //                         locale: 'id',
          //                         symbol: "Rp. ",
          //                         decimalDigits: 0)
          //                         .format(total),
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .display1
          //                         .copyWith(
          //                         fontWeight: FontWeight.w700,
          //                         fontSize: 15,
          //                         color: Colors.black)),
          //               );
          //             } else {
          //               return Container(
          //
          //               );
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: FutureBuilder(
                    future: ambilHartaBank(now),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        print("modal ${snapshot.data}");
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
                                        "Modal length ${snapshot.data.length}");
//                                                  var key = snapshot.data.keys
//                                                      .toList()[index];
                                    var kode =
                                    snapshot.data[index]['kode'];
                                    var nama =
                                    snapshot.data[index]['nama'];
                                    var nominal =
                                    snapshot.data[index]['saldo'];


                                    return Container(
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget piutang() {
    var size = MediaQuery.of(context).size;
    //130 - Piutang
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Padding(
          //         padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
          //         child: Text(
          //           "130 - Piutang",
          //           style: Theme.of(context).textTheme.display1.copyWith(
          //               fontWeight: FontWeight.w700,
          //               fontSize: 17,
          //               color: Colors.black),
          //         ),
          //       ),
          //
          //       Padding(
          //         padding:
          //         const EdgeInsets.only(right: 25, bottom: 20, top: 20),
          //         child: FutureBuilder(
          //           future: _getTotal(now),
          //           builder: (BuildContext context, snapshot) {
          //             if (snapshot.hasData) {
          //               var total = snapshot.data["data"]["modelHarta"]["list"]["3"]["total"];
          //               return Container(
          //                 child: Text(
          //                     NumberFormat.currency(
          //                         locale: 'id',
          //                         symbol: "Rp. ",
          //                         decimalDigits: 0)
          //                         .format(total),
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .display1
          //                         .copyWith(
          //                         fontWeight: FontWeight.w700,
          //                         fontSize: 15,
          //                         color: Colors.black)),
          //               );
          //             } else {
          //               return Container();
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: FutureBuilder(
                    future: ambilHartaPiutang(now),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        print("modal ${snapshot.data}");
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
                                        "Modal length ${snapshot.data.length}");
//                                                  var key = snapshot.data.keys
//                                                      .toList()[index];
                                    var kode =
                                    snapshot.data[index]['kode'];
                                    var nama =
                                    snapshot.data[index]['nama'];
                                    var nominal =
                                    snapshot.data[index]['saldo'];
                                    return Container(
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                                  width: size.width * .43,
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
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget asset() {
    var size = MediaQuery.of(context).size;
    //170 - Asset Tetap
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Padding(
          //         padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
          //         child: Text(
          //           "170 - Asset Tetap",
          //           style: Theme.of(context).textTheme.display1.copyWith(
          //               fontWeight: FontWeight.w700,
          //               fontSize: 17,
          //               color: Colors.black),
          //         ),
          //       ),
          //
          //       Padding(
          //         padding:
          //         const EdgeInsets.only(right: 25, bottom: 20, top: 20),
          //         child: FutureBuilder(
          //           future: _getTotal(now),
          //           builder: (BuildContext context, snapshot) {
          //             if (snapshot.hasData) {
          //               var total = snapshot.data["data"]["modelHarta"]["list"]["7"]["total"];
          //               return Container(
          //                 child: Text(
          //                     NumberFormat.currency(
          //                         locale: 'id',
          //                         symbol: "Rp. ",
          //                         decimalDigits: 0)
          //                         .format(total),
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .display1
          //                         .copyWith(
          //                         fontWeight: FontWeight.w700,
          //                         fontSize: 15,
          //                         color: Colors.black)),
          //               );
          //             } else {
          //               return Container();
          //             }
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: FutureBuilder(
                    future: ambilHartaAssetTetap(now),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        print("modal ${snapshot.data}");
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
                                        "Modal length ${snapshot.data.length}");
//                                                  var key = snapshot.data.keys
//                                                      .toList()[index];
                                    var kode =
                                    snapshot.data[index]['kode'];
                                    var nama =
                                    snapshot.data[index]['nama'];
                                    var nominal =
                                    snapshot.data[index]['saldo'];
                                    return Container(
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                                  width: size.width * .43,
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
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
