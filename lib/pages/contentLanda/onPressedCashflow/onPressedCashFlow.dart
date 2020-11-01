

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';
import 'package:wajib_baca/Service/widgetGlobal.dart';

import '../profitLoss.dart';


enum WidgetMarkerCashFlow { pemasukan, pengeluaran }


class OnPressedCashFlowLanda extends StatefulWidget{
  OnPressedCashFlowLanda({Key key}) : super(key: key);

  @override
  _OnPressedCashFlowLandaState createState() => _OnPressedCashFlowLandaState();
}

class _OnPressedCashFlowLandaState extends State<OnPressedCashFlowLanda> {
  var now = DateTime.now();
  WidgetMarkerCashFlow selectedWidgetMarker = WidgetMarkerCashFlow.pemasukan;
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  int loading = 0;


  Future ambilPenerimaan(DateTime dt) async {
    var data = await http.get(
        'https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?'
            'endDate=2020-' + bulanInt + '-31'
            '&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&'
            'startDate=2020-' + bulanInt + '-01'
            '&tipe=penerimaan');
    return jsonDecode(data.body);
  }

  Future ambilPengeluaran(DateTime dt) async {
    var data = await http.get(
        'https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?'
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
                                                                color: Colors.teal,
                                                                shadows: <Shadow>[
                                                                  Shadow(
                                                                    offset: Offset(1.0, 1.0),
                                                                    blurRadius: 1.0,
                                                                    color: Colors.white,
                                                                  ),
                                                                ])),
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
                                                                  color: Colors.teal,
                                                                  shadows: <Shadow>[
                                                                    Shadow(
                                                                      offset: Offset(1.0, 1.0),
                                                                      blurRadius: 1.0,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ])),
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
                                                    color: Colors.white),
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
                                                selectedWidgetMarker = WidgetMarkerCashFlow.pemasukan;
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
                                                      future: getCashflowPenerimaanLanda(nowGlobalService),
                                                      builder: (BuildContext context, snapshot) {

                                                        if (snapshot.hasData &&
                                                            snapshot.connectionState == ConnectionState.done) {
                                                          if(snapshot.data['data']['data']['total'].length == 0){
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      "Rp. 0",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 20,
                                                                          color: Colors.green)),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                    child: Text(
                                                                      "Cash In",
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
                                                            var penerimaan =
                                                            snapshot
                                                                .data['data']['data']['total']['debit'];
                                                            return Container(
                                                              child: Column(
                                                                children: [
                                                                  Text(
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

                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                    child: Text(
                                                                      "Cash In",
                                                                      style: Theme.of(context).textTheme.display1.copyWith(
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 15,
                                                                          color: Colors.black),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
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
                                              selectedWidgetMarker = WidgetMarkerCashFlow.pengeluaran;
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
                                                  future: getCashflowPengeluaranLanda(nowGlobalService),
                                                  builder: (BuildContext context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.connectionState == ConnectionState.done) {
                                                      if (snapshot.data['data']['data']['total'].length == 0) {
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "Rp. 0",
                                                                  style: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .display1
                                                                      .copyWith(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 20,
                                                                      color: Colors.deepOrange)),
                                                              Padding(
                                                                padding: EdgeInsets.only(bottom: 5),
                                                                child: Text(
                                                                  "Cash Out",
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
                                                        var penerimaan =
                                                        snapshot
                                                            .data['data']['data']['total']['debit'];
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              Text(
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

                                                              Padding(
                                                                padding: EdgeInsets.only(bottom: 5),
                                                                child: Text(
                                                                  "Cash Out",
                                                                  style: Theme.of(context).textTheme.display1.copyWith(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 15,
                                                                      color: Colors.black),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
    switch(selectedWidgetMarker){
      case WidgetMarkerCashFlow.pemasukan:
        return pemasukan();
      case WidgetMarkerCashFlow.pengeluaran:
        return pengeluaran();
    }
  }

  Widget pemasukan() {
    var size = MediaQuery.of(context).size;
    //Pemasukan
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   width: double.maxFinite,
          //   padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
          //   child: Text(
          //     "Pemasukan",
          //     style: Theme.of(context).textTheme.display1.copyWith(
          //         fontWeight: FontWeight.w700,
          //         fontSize: 17,
          //         color: Colors.black),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: FutureBuilder(
              future: ambilPenerimaan(now),
              builder: (BuildContext context, snapshot){
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
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
    );

  }

  Widget pengeluaran() {
    var size = MediaQuery.of(context).size;
    //PENGELURAN
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // Container(
          //   color: Colors.grey.withOpacity(0.2),
          //   width: double.maxFinite,
          //   padding:  const EdgeInsets.fromLTRB(25, 20, 0, 20),
          //   child: Text(
          //     "Pengeluaran",
          //     style: Theme.of(context).textTheme.display1.copyWith(
          //         fontWeight: FontWeight.w700,
          //         fontSize: 17,
          //         color: Colors.black),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: FutureBuilder(
              future: ambilPengeluaran(now),
              builder: (BuildContext context, snapshot){
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
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
    );
  }

}