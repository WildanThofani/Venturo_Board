import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';


class OnpressedSaldoKasProperty extends StatefulWidget {
  @override
  OnpressedSaldoKasPropertyState createState() => OnpressedSaldoKasPropertyState();


}

class OnpressedSaldoKasPropertyState extends State<OnpressedSaldoKasProperty> {
  var now = DateTime.now();
  String bulanString =
  Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt =
  BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  var tahun =
  TahunConstans.tahun[DateFormat('MM').format(DateTime.now())];

  Future ambilHeaderSaldoKas(DateTime dt) async {
    var data = await http
        .get('https://accproptech.landa.co.id/api/acc/l_buku_besar/laporan?'
        'endDate=2020-' +
        bulanInt +
        '-31'
            '&export=0&m_akun_id=25&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&'
            'startDate=2020-' +
        bulanInt +
        '-01');
    return jsonDecode(data.body);
  }

  Future ambil(DateTime dt) async {
    var data = await http
        .get('https://accproptech.landa.co.id/api/acc/l_buku_besar/laporan?'
        'endDate=2020-' +
        bulanInt +
        '-31'
            '&export=0&m_akun_id=25&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&'
            'startDate=2020-' +
        bulanInt +
        '-01');
    print("saldokas onpressed api ${data.body}");
    var decoded = jsonDecode(data.body);
    var subdata = decoded["data"]["detail"][0]["detail"];
    return subdata;
  }

  nextIntBulan(int i) {
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

    super.initState();
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
            title: Text("Saldo Kas"),
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
          body: ListView(
            children: <Widget>[
              Container(

                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.grey.withOpacity(0.8),
                      width: double.maxFinite,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Property",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [




                          //ATAS NAMA
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
                                child: Text(
                                  "Atas Nama       :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 25, 0),
                                child: Text(
                                  "Yulianto Frandi",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),

                          //NO REKENING
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                                child: Text(
                                  "No. Rekening   :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                                child: Text(
                                  "315-0786-303",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                height: 2,
                                width: double.maxFinite,
                                color: Colors.black54,
                              ),

                            ),
                          ),

                          //SALDO AWAL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                                child: Text(
                                  "Saldo Awal       :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 25, 0),
                                child: FutureBuilder(
                                  future: ambilHeaderSaldoKas(now),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData){
                                      var saldoAwal = snapshot.data['data']['detail'][0]['saldo_awal'];
                                      return Text(
                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldoAwal),
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: Colors.black));
                                    } else{
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),

                          //MUTASI KREDIT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                                child: Text(
                                  "Mutasi Kredit   :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 25, 0),
                                child: FutureBuilder(
                                  future: ambilHeaderSaldoKas(now),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData){
                                      var saldoAwal = snapshot.data['data']['detail'][0]['total_kredit'];
                                      return Text(
                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldoAwal),
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.black));
                                    } else{
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),

                          //MUTASI DEBIT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                                child: Text(
                                  "Mutasi Debit    :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 25, 0),
                                child: FutureBuilder(
                                  future: ambilHeaderSaldoKas(now),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData){
                                      var saldoAwal = snapshot.data['data']['detail'][0]['total_debit'];
                                      return Text(
                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldoAwal),
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: Colors.black));
                                    } else{
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),

                          //SALDO AKHIR
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                                child: Text(
                                  "Saldo akhir       :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 25, 20),
                                child: FutureBuilder(
                                  future: ambilHeaderSaldoKas(now),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData){
                                      var saldoAwal = snapshot.data['data']['detail'][0]['total_saldo'];
                                      return Text(
                                          NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldoAwal),
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: Colors.black));
                                    } else{
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FutureBuilder(
                        future: ambil(now),
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
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        print(
                                            "saldokas length ${snapshot.data.length}");
                                        print(
                                            "saldokas onpressed ${snapshot.data}");
                                        var key =
                                        snapshot.data.keys.toList()[index];
                                        var kode = snapshot.data[key]["kode"];
                                        var tanggal =
                                        snapshot.data[key]['tanggal'];
                                        var debit = snapshot.data[key]['debit'];
                                        var kredit =
                                        snapshot.data[key]['kredit'];
                                        var tipe =
                                        snapshot.data[key]['tipe'];
                                        var totalSaldo =
                                        snapshot.data[key]['total_saldo'];
                                        var totalKredit =
                                        snapshot.data[key]['total_kredit'];
                                        var totalDebit =
                                        snapshot.data[key]['total_debit'];
                                        var ket =
                                        snapshot.data[key]['keterangan'];
                                        DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(tanggal);
                                        var date = new DateFormat("dd MMM yyyy").format(tempDate);
                                        // DateTime date = new DateFormat("dd-MM-yyyy").format(tempDate);
                                        return Container(
                                          child: InkWell(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            //TANGGAL
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                                                              child: Text(
                                                                  "$date",
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
                                                            //KODE
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
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
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                                                              child: SizedBox(
                                                                width: size.width * .55,
                                                                child: Text(
                                                                    ket,
                                                                    style: Theme
                                                                        .of(context)
                                                                        .textTheme
                                                                        .display1
                                                                        .copyWith(
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 15,
                                                                        color: Colors.black)
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),



                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(0, 15, 25, 0),
                                                              child: Builder(
                                                                builder: (context){
                                                                  if (tipe == "kredit") {
                                                                    return Text(
                                                                        NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(kredit),
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 17,
                                                                            color: Colors.green)
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                        NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(debit),
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 17,
                                                                            color: Colors.pinkAccent)
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(0, 5, 25, 0),
                                                              child: Builder(
                                                                builder: (context){
                                                                  if (tipe == "kredit") {
                                                                    return Text(
                                                                        "CR",
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 15,
                                                                            color: Colors.green)
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                        "DB",
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 15,
                                                                            color: Colors.pinkAccent)
                                                                    );
                                                                  }
                                                                },
                                                              ),

                                                              // Text(
                                                              //     tipe,
                                                              //     style: Theme
                                                              //         .of(context)
                                                              //         .textTheme
                                                              //         .display1
                                                              //         .copyWith(
                                                              //         fontWeight: FontWeight.w500,
                                                              //         fontSize: 15,
                                                              //         color: Colors.black)
                                                              // ),

                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
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
              ),
            ],
          )),
    );
  }
}