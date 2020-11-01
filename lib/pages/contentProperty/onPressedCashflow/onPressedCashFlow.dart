

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';



class OnPressedCashFlowProperty extends StatefulWidget{
  OnPressedCashFlowProperty({Key key}) : super(key: key);

  @override
  _OnPressedCashFlowPropertyState createState() => _OnPressedCashFlowPropertyState();
}

class _OnPressedCashFlowPropertyState extends State<OnPressedCashFlowProperty> {
  var now = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  int loading = 0;


  Future ambilPenerimaan(DateTime dt) async {
    var data = await http.get(
        'https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?'
            'endDate=2020-' + bulanInt + '-31'
            '&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&'
            'startDate=2020-' + bulanInt + '-01'
            '&tipe=penerimaan');
    return jsonDecode(data.body);
  }

  Future ambilPengeluaran(DateTime dt) async {
    var data = await http.get(
        'https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?'
            'endDate=2020-' + bulanInt + '-31'
            '&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&'
            'startDate=2020-' + bulanInt + '-01'
            '&tipe=pengeluaran');
    return jsonDecode(data.body);
  }

  nextIntBulan(int i){
    setState(() {
      if (i == 1) {
        var bln = Jiffy(now).add(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).add(months: 1);
        ambilPengeluaran(now);
      } else {
        var bln = Jiffy(now).subtract(months: 1);
        bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
        bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
        now = Jiffy(now).subtract(months: 1);
        ambilPengeluaran(now);
      }
    });
  }

  @override
  void initState() {
    ambilPengeluaran(now);

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
            title: Text("Cash Flow"),
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
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.grey.withOpacity(0.8),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Center(
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
                  //Pemasukan
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.grey.withOpacity(0.2),
                          width: double.maxFinite,
                          padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
                          child: Text(
                            "Pemasukan",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: FutureBuilder(
                            future: ambilPenerimaan(now),
                            builder: (BuildContext context, snapshot){
                              if (snapshot.hasData) {
                                if(snapshot.data['data']['kredit'].length == 0) {
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
                                          itemCount: snapshot.data['data']['kredit'].length,
                                          itemBuilder: (BuildContext context, index){
                                            print("expense length ${snapshot.data['data']['kredit'].length}");
                                            var kode = snapshot.data['data']['kredit'][index]['akun']['kode'];
                                            var nama = snapshot.data['data']['kredit'][index]['akun']['nama'];
                                            var tipeArus = snapshot.data['data']['kredit'][index]['akun']['tipe_arus'];
                                            var nominal = snapshot.data['data']['kredit'][index]['total'];
                                            var ket = snapshot.data['data']['kredit'][index]['keterangan'];
                                            return Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
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

                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
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

                                                              Container(
                                                                width: size.width *.45,
                                                                child: InkWell(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                                    child: Text(
                                                                        ket,
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

                                                            ],
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
                                                ],
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

                  //PENGELURAN
                  Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey.withOpacity(0.2),
                        width: double.maxFinite,
                        padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
                        child: Text(
                          "Pengeluaran",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: FutureBuilder(
                          future: ambilPengeluaran(now),
                          builder: (BuildContext context, snapshot){
                            if (snapshot.hasData) {
                              if(snapshot.data['data']['debit'].length == 0){
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
                                        itemCount: snapshot.data['data']['debit'].length,
                                        itemBuilder: (BuildContext context, index){
                                          print("expense length ${snapshot.data['data']['debit'].length}");
                                          var kode = snapshot.data['data']['debit'][index]['akun']['kode'];
                                          var nama = snapshot.data['data']['debit'][index]['akun']['nama'];
                                          var tipeArus = snapshot.data['data']['debit'][index]['akun']['tipe_arus'];
                                          var nominal = snapshot.data['data']['debit'][index]['total'];
                                          var ket = snapshot.data['data']['debit'][index]['keterangan'];

                                          print("Expense Kode $kode");
                                          print("Expense nama $nama");
                                          print("Expense tipeArus $tipeArus");
                                          print("Expense nominal $nominal");
                                          print("Expense ket $ket");
                                          return Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
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

                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
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

                                                            Container(
                                                              width: size.width *.45,
                                                              child: InkWell(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
                                                                  child: Text(
                                                                      ket,
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

                                                          ],
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
                                              ],
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
                    ],
                  ),
                ],
              ),

            ],
          )
      ),
    );
  }

}