import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';


class RevenueLanda extends StatefulWidget {
  @override
  RevenueLandaState createState() => RevenueLandaState();


}

class RevenueLandaState extends State<RevenueLanda> {
  var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];


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

  nextIntBulan(int i){
    setState(() {
      if (i == 1) {
        var bln = Jiffy(now).add(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).add(months: 1);
        ambil(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        ambil(now);
      }
    });
  }

  @override
  void initState() {
    ambil(now);
    ambilPendapatanDiluarUsaha(now);
    super.initState();
  }

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
            title: Text("Revenue"),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 3),
                      child: Text(
                        "Landa System",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 3),
                      child: Text(
                        "Laporan Revenue",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 10),
                      child: Text(
                        "Periode 01 $bulanString 2020 s/d 30 $bulanString 2020",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                          onPressed: () {
                            nextIntBulan(2);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(7),
                          child: Text(
                            bulanString,
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          onPressed: () {
                            nextIntBulan(1);
                          },
                        ),
                      ],
                    ),


                    //401 - Pendapatan Usaha
                    ExpansionTile(
                      title: Text(
                        "401 - Pendapatan Usaha",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: FutureBuilder(
                                  future: ambil(now),
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
                                            ListView.builder(
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
//                                              height: size.height / 6 ,
                                                    child: InkWell(
                                                      child: Container(
                                                        decoration: BoxDecoration( //decoration for the outer wrapper
                                                          color: Colors.deepOrangeAccent,
                                                          borderRadius: BorderRadius.circular(30), //border radius exactly to ClipRRect
                                                          boxShadow:[
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5), //color of shadow
                                                              spreadRadius: 5, //spread radius
                                                              blurRadius: 7, // blur radius
                                                              offset: Offset(0, 2), // changes position of shadow
                                                              //first paramerter of offset is left-right
                                                              //second parameter is top to down
                                                            ),
                                                            //you can set more BoxShadow() here
                                                          ],
                                                        ) ,
                                                        height: size.height / 8 ,
//                                                  width: 50,
                                                        padding: EdgeInsets.only(left: 20),
                                                        margin: EdgeInsets.all(10),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(30),
                                                          child: Container(
                                                            child: Stack(
                                                              children: <Widget>[

                                                                Positioned( //positioned helps to position widget wherever we want.
                                                                    top:-20, left:-50, //position of the widget
                                                                    child:Container(
                                                                        height:250,
                                                                        width:250,
                                                                        decoration:BoxDecoration(
                                                                            shape:BoxShape.circle,
                                                                            color:Colors.orange.withOpacity(0.5) //background color with opacity
                                                                        )
                                                                    )
                                                                ),

                                                                Positioned(
                                                                    right:-80,top:-50,
                                                                    child:Container(
                                                                        height:180,
                                                                        width:180,
                                                                        decoration:BoxDecoration(
                                                                            shape:BoxShape.circle,
                                                                            color:Colors.redAccent.withOpacity(0.5)
                                                                        )
                                                                    )
                                                                ),




                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: <Widget>[

                                                                    //KODE
                                                                    Container(
                                                                      height: 60,
                                                                      width: 60,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Colors.white
                                                                      ),

                                                                      child: InkWell(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .all(5),
                                                                              child: Text(
                                                                                kode,
                                                                                style: Theme.of(
                                                                                    context)
                                                                                    .textTheme
                                                                                    .display1
                                                                                    .copyWith(
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w800,
                                                                                    fontSize: 15,
                                                                                    color: Colors
                                                                                        .redAccent),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: <Widget>[
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              top: 5,
                                                                              bottom: 5,
                                                                              left: 15),
                                                                          child: Text(
                                                                            nama,
                                                                            style: Theme.of(
                                                                                context)
                                                                                .textTheme
                                                                                .display1
                                                                                .copyWith(
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                                fontSize:
                                                                                15,
                                                                                color: Colors
                                                                                    .white),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              top: 5,
                                                                              bottom: 5,
                                                                              left: 15),
                                                                          child: Text(
                                                                            NumberFormat.currency(
                                                                                locale:
                                                                                'id',
                                                                                symbol:
                                                                                "Rp. ",
                                                                                decimalDigits:
                                                                                0)
                                                                                .format(
                                                                                nominal),
                                                                            style: Theme.of(
                                                                                context)
                                                                                .textTheme
                                                                                .display1
                                                                                .copyWith(
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                                fontSize:
                                                                                15,
                                                                                color: Colors
                                                                                    .white),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 15, bottom: 30),
                                    child: Text("Total - ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 25, bottom: 30),
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
                                                    fontSize: 13,
                                                    color: Colors.black)),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    //405 - Pendapatan Luar Usaha
                    ExpansionTile(
                      title: Text(
                        "405 - Pendapatan Luar Usaha",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15),
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
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
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
//                                              height: size.height / 6 ,
                                                    child: InkWell(
                                                      child: Container(
                                                        decoration: BoxDecoration( //decoration for the outer wrapper
                                                          color: Colors.deepOrangeAccent,
                                                          borderRadius: BorderRadius.circular(30), //border radius exactly to ClipRRect
                                                          boxShadow:[
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5), //color of shadow
                                                              spreadRadius: 5, //spread radius
                                                              blurRadius: 7, // blur radius
                                                              offset: Offset(0, 2), // changes position of shadow
                                                              //first paramerter of offset is left-right
                                                              //second parameter is top to down
                                                            ),
                                                            //you can set more BoxShadow() here
                                                          ],
                                                        ) ,
                                                        height: size.height / 8 ,
//                                                  width: 50,
                                                        padding: EdgeInsets.only(left: 20),
                                                        margin: EdgeInsets.all(10),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(30),
                                                          child: Container(
                                                            child: Stack(
                                                              children: <Widget>[

                                                                Positioned( //positioned helps to position widget wherever we want.
                                                                    top:-20, left:-50, //position of the widget
                                                                    child:Container(
                                                                        height:250,
                                                                        width:250,
                                                                        decoration:BoxDecoration(
                                                                            shape:BoxShape.circle,
                                                                            color:Colors.orange.withOpacity(0.5) //background color with opacity
                                                                        )
                                                                    )
                                                                ),

                                                                Positioned(
                                                                    right:-80,top:-50,
                                                                    child:Container(
                                                                        height:180,
                                                                        width:180,
                                                                        decoration:BoxDecoration(
                                                                            shape:BoxShape.circle,
                                                                            color:Colors.redAccent.withOpacity(0.5)
                                                                        )
                                                                    )
                                                                ),




                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: <Widget>[

                                                                    //KODE
                                                                    Container(
                                                                      height: 60,
                                                                      width: 60,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: Colors.white
                                                                      ),

                                                                      child: InkWell(
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .all(5),
                                                                              child: Text(
                                                                                kode,
                                                                                style: Theme.of(
                                                                                    context)
                                                                                    .textTheme
                                                                                    .display1
                                                                                    .copyWith(
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w800,
                                                                                    fontSize: 15,
                                                                                    color: Colors
                                                                                        .redAccent),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: <Widget>[
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              top: 5,
                                                                              bottom: 5,
                                                                              left: 15),
                                                                          child: Text(
                                                                            nama,
                                                                            style: Theme.of(
                                                                                context)
                                                                                .textTheme
                                                                                .display1
                                                                                .copyWith(
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                                fontSize:
                                                                                15,
                                                                                color: Colors
                                                                                    .white),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              top: 5,
                                                                              bottom: 5,
                                                                              left: 15),
                                                                          child: Text(
                                                                            NumberFormat.currency(
                                                                                locale:
                                                                                'id',
                                                                                symbol:
                                                                                "Rp. ",
                                                                                decimalDigits:
                                                                                0)
                                                                                .format(
                                                                                nominal),
                                                                            style: Theme.of(
                                                                                context)
                                                                                .textTheme
                                                                                .display1
                                                                                .copyWith(
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w500,
                                                                                fontSize:
                                                                                15,
                                                                                color: Colors
                                                                                    .white),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 15, bottom: 30),
                                    child: Text("Total - ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: Colors.black)),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 25, bottom: 30),
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
                                                    fontSize: 13,
                                                    color: Colors.black)),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

}