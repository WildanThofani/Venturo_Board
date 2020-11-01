import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';


class HutangWajibBaca extends StatefulWidget {
  @override
  HutangWajibBacaState createState() => HutangWajibBacaState();


}


class HutangWajibBacaState extends State<HutangWajibBaca> {
  var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];


  Future ambilHutang(DateTime dt) async {
    var data = await http.get('https://accwb.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
        'tanggal=2020-' + bulanInt + '-31');

    var decoded = jsonDecode(data.body);
    print(" ambilHutang Decoded${decoded["data"]["modelKewajiban"]["list"]["10"]["detail"]}");//iso le
    var subdata =  decoded["data"]["modelKewajiban"]["list"]["10"]["detail"];
    print("\nforEach");
    subdata.forEach((v){
      print(v);
      print("------");
    });
    return subdata;

  }

  _getTotal(DateTime dt) async {
    print("BulanInt $bulanInt");

    var response = await http.get(
        'https://accwb.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&'
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
        ambilHutang(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        ambilHutang(now);
      }
    });
  }

  @override
  void initState() {
    ambilHutang(now);
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
            title: Text("Liabilities"),
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
                            "Wajib Baca",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    //201 - HUTANG LANCAR
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.grey.withOpacity(0.2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
                                  child: Text(
                                    "210 - Hutang Lancar",
                                    style: Theme.of(context).textTheme.display1.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.only(right: 25, bottom: 20, top: 20),
                                  child: FutureBuilder(
                                    future: _getTotal(now),
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.hasData) {
                                        var total = snapshot.data["data"]["modelKewajiban"]["total"];
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
                          ),


                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: FutureBuilder(
                                    future: ambilHutang(now),
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.hasData) {
                                        print("hutang ${snapshot.data}");
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
                                                        "hutang length ${snapshot.data.length}");
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