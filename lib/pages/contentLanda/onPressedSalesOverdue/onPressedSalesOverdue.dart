import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';

class OnPressedSalesOverdueLanda extends StatefulWidget {
  @override
  OnPressedSalesOverdueLandaState createState() =>
      OnPressedSalesOverdueLandaState();
}

class OnPressedSalesOverdueLandaState extends State<OnPressedSalesOverdueLanda> {
  var now = DateTime.now();
  String bulanString =
      Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt =
      BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];

  Future ambilDetailOverDue() async {
    var data = await http.get(
        'https://2019.landa.co.id/api/laporanpiutang/index?status_lunas=belum_lunas');

    var decoded = jsonDecode(data.body);
    print(decoded["data"]["list"]);
    var subdata = decoded["data"]["list"];

//    print("\nforEach");
//    subdata.forEach((k,v){
//      print(k);
//      print(v);
//      print("------");
//    });
    return subdata;
  }


  _getSalesOverdue() async{
    var response = await http.get(
        "https://2019.landa.co.id/api/laporanpiutang/index?status_lunas=belum_lunas"
    );
    return jsonDecode(response.body);
  }




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return DefaultTabController(
      length: 9,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
            backgroundColor: Colors.redAccent,
            title: Text('Sales Overdue'),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      // Tab(
                      //   child: FutureBuilder(
                      //     future: ambilDetailOverDue(),
                      //     builder: (BuildContext context, snapshot) {
                      //       if(snapshot.hasData) {
                      //         return ListView.separated(
                      //             itemCount: snapshot.data.length,
                      //             itemBuilder: (BuildContext context, index){
                      //               var key = snapshot.data.keys.toList()[index];
                      //               var nama = snapshot.data[key]["nama"];
                      //               var kunci = snapshot.data[key];
                      //               return Text(
                      //                 nama
                      //               );
                      //             });
                      //       } else{
                      //         return Container();
                      //       }
                      //     },
                      //   ),
                      // ),
                      Tab(
                            child: Text('BKD Sampang'),
                      ),

                      Tab(
                            child: Text('UMMI MALANG'),
                      ),
                      Tab(
                            child: Text('Pasar Kota Pondok Gede'),
                      ),
                      Tab(
                            child: Text('Kafilah'),
                      ),
                      Tab(
                            child: Text('Master Prima'),
                      ),
                      Tab(
                            child: Text('Yayasan Sunniyah Salafiah'),
                      ),
                      Tab(
                            child: Text('SMK YP 17 Pare'),
                      ),
                      Tab(
                            child: Text('PT. Amak Firdaus Utomo'),
                      ),
                      Tab(
                            child: Text('PT Adhi Persada Property (Taman Melati Suraba)')
                      ),
                    ]),
                preferredSize: Size.fromHeight(50.0),
            ),
            // actions: <Widget>[
            //
            // ],
          ),
          body: Container(
            child: TabBarView(
              children: <Widget>[

                //BKD Sampang
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70),
                            ),
                          ),
                          child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                        "Total - ",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.white)
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: FutureBuilder(
                                        future: _getSalesOverdue(),
                                      builder: (BuildContext context, snapshot){
                                          if(snapshot.hasData) {
                                            var BKDSampang = snapshot.data['data']['listSumTagihan']['BKD Sampang'];
                                            var total = int.parse(BKDSampang);
                                            if(total == 0) {
                                              return Container(
                                                child: Text("0"),
                                              );
                                            } else {
                                              return Container(
                                                child: Text(
                                                    NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .display1
                                                        .copyWith(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 15,
                                                        color: Colors.white)),
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
                              ),
                          ),

                        Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["BKD Sampang"]['detail_fix'].length,
                                    itemBuilder: (BuildContext context, index) {
                                      var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["BKD Sampang"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["BKD Sampang"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["BKD Sampang"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["BKD Sampang"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["BKD Sampang"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["BKD Sampang"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["BKD Sampang"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                    },
                                    );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                        ),
                      ],
                    ),
                  ),
                ),

                //UMMI MALANG
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['UMMI MALANG'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["UMMI MALANG"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["UMMI MALANG"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["UMMI MALANG"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["UMMI MALANG"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["UMMI MALANG"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["UMMI MALANG"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["UMMI MALANG"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["UMMI MALANG"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //Pasar Kota Pondok Gede
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['Pasar Kota Pondok Gede'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["Pasar Kota Pondok Gede"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["Pasar Kota Pondok Gede"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //Kafilah
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['Kafilah'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["Kafilah"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["Kafilah"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["Kafilah"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["Kafilah"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["Kafilah"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["Kafilah"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["Kafilah"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["Kafilah"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //Master Prima
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['Master Prima'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Container(
                            child: FutureBuilder(
                              future: ambilDetailOverDue(),
                              builder: (BuildContext context, snapshot){
                                if(snapshot.hasData){
                                  return ListView.separated(
                                    separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data["Master Prima"]['detail_fix'].length,
                                    itemBuilder: (BuildContext context, index) {
                                      var key = snapshot.data.keys.toList()[index];
                                      if (snapshot.hasData) {
                                        return   ListView.separated(
                                            separatorBuilder: (context, index) => Divider(
                                              color: Colors.black,
                                            ),
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data["Master Prima"]['detail_fix'].length,
                                            itemBuilder: (BuildContext context, index) {
                                              var kode = snapshot.data["Master Prima"]['detail_fix'][index]['kode'];
                                              var tanggal = snapshot.data["Master Prima"]['detail_fix'][index]['format_tanggal'];
                                              var deskripsi =snapshot.data ["Master Prima"]['detail_fix'][index]['deskripsi'];
                                              var total = snapshot.data["Master Prima"]['detail_fix'][index]['total'];
                                              var bayar = snapshot.data["Master Prima"]['detail_fix'][index]['bayar'];
                                              var tanggal_bayar = snapshot.data["Master Prima"]['detail_fix'][index]['tanggal_bayar'];
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                          child: Text(
                                                              "Kode                 : ",
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
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                      ],
                                                    ),
                                                  ),

                                                  //KETERANGAN
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              "Keterangan      : ",
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
                                                          width: size.width * .65,
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Text(
                                                                deskripsi,
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
                                                  ),

                                                  //TANGGAL
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              "Tanggal            : ",
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
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Text(
                                                                tanggal,
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
                                                  ),

                                                  //TOTAL
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              "Total                 : ",
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
                                                          child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Text(
                                                                NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                  ),

                                                  //BAYAR
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              "Bayar                : ",
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
                                                          child: Padding(
                                                              padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                              child: Builder(
                                                                builder: (context){
                                                                  if (bayar == null) {
                                                                    return Text(
                                                                        " - ",
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15,
                                                                            color: Colors.black)
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                        NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15,
                                                                            color: Colors.black)
                                                                    );
                                                                  }
                                                                },
                                                              )
                                                            // Text(
                                                            //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  //TANGGAL BAYAR
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              "Tanggal Bayar : ",
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
                                                          child: Padding(
                                                              padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                              child: Builder(
                                                                builder: (context){
                                                                  if (tanggal_bayar == "") {
                                                                    return Text(
                                                                        " - ",
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15,
                                                                            color: Colors.black)
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                        "$tanggal_bayar",
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .display1
                                                                            .copyWith(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15,
                                                                            color: Colors.black)
                                                                    );
                                                                  }
                                                                },
                                                              )
                                                            // Text(
                                                            //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),



                                                ],
                                              );
                                            }
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  );



                                } else {
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            )
                        ),

                    ],
                  ),
                ),

                //Yayasan Sunniyah Salafiah
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['Yayasan Sunniyah Salafiah'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["Yayasan Sunniyah Salafiah"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //SMK YP 17 Pare
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['SMK YP 17 Pare'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["SMK YP 17 Pare"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["SMK YP 17 Pare"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["SMK YP 17 Pare"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["SMK YP 17 Pare"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["SMK YP 17 Pare"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["SMK YP 17 Pare"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["SMK YP 17 Pare"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["SMK YP 17 Pare"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //PT. Amak Firdaus Utomo
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['PT. Amak Firdaus Utomo'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["PT. Amak Firdaus Utomo"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["PT. Amak Firdaus Utomo"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),

                //PT Adhi Persada Properti (Taman Melati Suraba
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    "Total - ",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.white)
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8),
                                child: FutureBuilder(
                                  future: _getSalesOverdue(),
                                  builder: (BuildContext context, snapshot){
                                    if(snapshot.hasData) {
                                      var BKDSampang = snapshot.data['data']['listSumTagihan']['PT Adhi Persada Properti (Taman Melati Suraba'];
                                      var total = int.parse(BKDSampang);
                                      if(total == 0) {
                                        return Container(
                                          child: Text("0"),
                                        );
                                      } else {
                                        return Container(
                                          child: Text(
                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .display1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white)),
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
                        ),
                      ),

                      Center(
                          child: FutureBuilder(
                            future: ambilDetailOverDue(),
                            builder: (BuildContext context, snapshot){
                              if(snapshot.hasData){
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'].length,
                                  itemBuilder: (BuildContext context, index) {
                                    var key = snapshot.data.keys.toList()[index];
                                    if (snapshot.hasData) {
                                      return   ListView.separated(
                                          separatorBuilder: (context, index) => Divider(
                                            color: Colors.black,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'].length,
                                          itemBuilder: (BuildContext context, index) {
                                            var kode = snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['kode'];
                                            var tanggal = snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['format_tanggal'];
                                            var deskripsi =snapshot.data ["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['deskripsi'];
                                            var total = snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['total'];
                                            var bayar = snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['bayar'];
                                            var tanggal_bayar = snapshot.data["PT Adhi Persada Properti (Taman Melati Suraba"]['detail_fix'][index]['tanggal_bayar'];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[

                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
                                                        child: Text(
                                                            "Kode                 : ",
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
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
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
                                                    ],
                                                  ),
                                                ),

                                                //KETERANGAN
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Keterangan      : ",
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
                                                        width: size.width * .65,
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              deskripsi,
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
                                                ),

                                                //TANGGAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal            : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              tanggal,
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
                                                ),

                                                //TOTAL
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Total                 : ",
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
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                          child: Text(
                                                              NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                ),

                                                //BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Bayar                : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (bayar == null) {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //TANGGAL BAYAR
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                        child: Text(
                                                            "Tanggal Bayar : ",
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
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                                            child: Builder(
                                                              builder: (context){
                                                                if (tanggal_bayar == "") {
                                                                  return Text(
                                                                      " - ",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "$tanggal_bayar",
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 15,
                                                                          color: Colors.black)
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          // Text(
                                                          //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
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
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            );
                                          }
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                );



                              } else {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          )
                      ),
                    ],
                  ),
                ),


              ],
            ),
          )),
    );




    // return MaterialApp(
    //   home: Scaffold(
    //       appBar: AppBar(
    //         leading: IconButton(
    //           icon: Icon(Icons.arrow_back, color: Colors.white),
    //           onPressed: () => Navigator.of(context).pop(),
    //         ),
    //         backgroundColor: Colors.redAccent,
    //         title: Text("Sales Overdue"),
    //       ),
    //       body: Container(
    //         child: ListView(
    //           children: <Widget>[
    //             Column(
    //               children: <Widget>[
    //                 //HEADER
    //                 Container(
    //                   width: double.maxFinite,
    //                   color: Colors.grey.withOpacity(0.8),
    //                   child: Center(
    //                     child: Padding(
    //                       padding: EdgeInsets.only(top: 15, bottom: 15),
    //                       child: Text(
    //                         "Landa System",
    //                         style: Theme.of(context).textTheme.display1.copyWith(
    //                             fontWeight: FontWeight.w700,
    //                             fontSize: 20,
    //                             color: Colors.white),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //
    //                 Container(
    //                       child: Column(
    //                         children: <Widget>[
    //                           Padding(
    //                             padding: const EdgeInsets.all(0),
    //                             child: FutureBuilder(
    //                               future:ambilDetailOverDue(),
    //                               builder: (BuildContext context, snapshot) {
    //                                 if (snapshot.hasData) {
    //                                   if (snapshot.data.length == 0) {
    //                                     return Container();
    //                                   } else {
    //                                     return Column(
    //                                       mainAxisSize: MainAxisSize.min,
    //                                       children: <Widget>[
    //                                         ListView.separated(
    //                                             separatorBuilder: (context, index) => Divider(
    //                                               color: Colors.black,
    //
    //                                             ),
    //                                             shrinkWrap: true,
    //                                             physics: NeverScrollableScrollPhysics(),
    //                                             itemCount: snapshot.data.length,
    //                                             itemBuilder: (BuildContext context, index) {
    //                                               var key = snapshot.data.keys.toList()[index];
    //                                               var nama = snapshot.data[key]["nama"];
    //                                               var kunci = snapshot.data[key];
    //
    //
    //                                           return Column(
    //                                             mainAxisAlignment: MainAxisAlignment.start,
    //                                             crossAxisAlignment: CrossAxisAlignment.start,
    //                                             children: [
    //                                           Container(
    //                                             width: double.maxFinite,
    //                                             color: Colors.grey.withOpacity(0.2),
    //                                             child: Padding(
    //                                                   padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
    //                                                   child: Text(
    //                                                       nama,
    //                                                       style: Theme
    //                                                           .of(context)
    //                                                           .textTheme
    //                                                           .display1
    //                                                           .copyWith(
    //                                                           fontWeight: FontWeight.w500,
    //                                                           fontSize: 17,
    //                                                           color: Colors.black)
    //                                                   ),
    //                                                 ),
    //                                           ),
    //                                               ListView.separated(
    //                                                 separatorBuilder: (context, index) => Divider(
    //                                                   color: Colors.black,
    //                                                 ),
    //                                                   shrinkWrap: true,
    //                                                   physics: NeverScrollableScrollPhysics(),
    //                                                   itemCount: snapshot.data[key]['detail_fix'].length,
    //                                                   itemBuilder: (BuildContext context, index) {
    //                                                     var kode = snapshot.data[key]['detail_fix'][index]['kode'];
    //                                                     var tanggal = snapshot.data[key]['detail_fix'][index]['format_tanggal'];
    //                                                     var deskripsi =snapshot.data [key]['detail_fix'][index]['deskripsi'];
    //                                                     var total = snapshot.data[key]['detail_fix'][index]['total'];
    //                                                     var bayar = snapshot.data[key]['detail_fix'][index]['bayar'];
    //                                                     var tanggal_bayar = snapshot.data[key]['detail_fix'][index]['tanggal_bayar'];
    //                                                     return Column(
    //                                                           mainAxisAlignment: MainAxisAlignment.start,
    //                                                           crossAxisAlignment: CrossAxisAlignment.start,
    //                                                           children: <Widget>[
    //
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 10, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Kode                 : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         kode,
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //                                                             //KETERANGAN
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Keterangan      : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Container(
    //                                                                     width: size.width * .65,
    //                                                                     child: Padding(
    //                                                                       padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                       child: Text(
    //                                                                           deskripsi,
    //                                                                           style: Theme
    //                                                                               .of(context)
    //                                                                               .textTheme
    //                                                                               .display1
    //                                                                               .copyWith(
    //                                                                               fontWeight: FontWeight.w500,
    //                                                                               fontSize: 15,
    //                                                                               color: Colors.black)
    //                                                                       ),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //                                                             //TANGGAL
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Tanggal            : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Container(
    //                                                                     child: Padding(
    //                                                                       padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                       child: Text(
    //                                                                           tanggal,
    //                                                                           style: Theme
    //                                                                               .of(context)
    //                                                                               .textTheme
    //                                                                               .display1
    //                                                                               .copyWith(
    //                                                                               fontWeight: FontWeight.w500,
    //                                                                               fontSize: 15,
    //                                                                               color: Colors.black)
    //                                                                       ),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //                                                             //TOTAL
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Total                 : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Container(
    //                                                                     child: Padding(
    //                                                                       padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                       child: Text(
    //                                                                           NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                                                           style: Theme
    //                                                                               .of(context)
    //                                                                               .textTheme
    //                                                                               .display1
    //                                                                               .copyWith(
    //                                                                               fontWeight: FontWeight.w500,
    //                                                                               fontSize: 15,
    //                                                                               color: Colors.black)
    //                                                                       ),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //                                                             //BAYAR
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Bayar                : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Container(
    //                                                                     child: Padding(
    //                                                                       padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                       child: Builder(
    //                                                                         builder: (context){
    //                                                                           if (bayar == null) {
    //                                                                             return Text(
    //                                                                               " - ",
    //                                                                                 style: Theme
    //                                                                                     .of(context)
    //                                                                                     .textTheme
    //                                                                                     .display1
    //                                                                                     .copyWith(
    //                                                                                     fontWeight: FontWeight.w500,
    //                                                                                     fontSize: 15,
    //                                                                                     color: Colors.black)
    //                                                                             );
    //                                                                           } else {
    //                                                                             return Text(
    //                                                                                 NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
    //                                                                                 style: Theme
    //                                                                                     .of(context)
    //                                                                                     .textTheme
    //                                                                                     .display1
    //                                                                                     .copyWith(
    //                                                                                     fontWeight: FontWeight.w500,
    //                                                                                     fontSize: 15,
    //                                                                                     color: Colors.black)
    //                                                                             );
    //                                                                           }
    //                                                                         },
    //                                                                       )
    //                                                                       // Text(
    //                                                                       //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                                                       //     style: Theme
    //                                                                       //         .of(context)
    //                                                                       //         .textTheme
    //                                                                       //         .display1
    //                                                                       //         .copyWith(
    //                                                                       //         fontWeight: FontWeight.w500,
    //                                                                       //         fontSize: 15,
    //                                                                       //         color: Colors.black)
    //                                                                       // ),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //                                                             //TANGGAL BAYAR
    //                                                             Container(
    //                                                               child: Row(
    //                                                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                                                 children: [
    //                                                                   Padding(
    //                                                                     padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                     child: Text(
    //                                                                         "Tanggal Bayar : ",
    //                                                                         style: Theme
    //                                                                             .of(context)
    //                                                                             .textTheme
    //                                                                             .display1
    //                                                                             .copyWith(
    //                                                                             fontWeight: FontWeight.w500,
    //                                                                             fontSize: 15,
    //                                                                             color: Colors.black)
    //                                                                     ),
    //                                                                   ),
    //                                                                   Container(
    //                                                                     child: Padding(
    //                                                                         padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                                                         child: Builder(
    //                                                                           builder: (context){
    //                                                                             if (tanggal_bayar == "") {
    //                                                                               return Text(
    //                                                                                   " - ",
    //                                                                                   style: Theme
    //                                                                                       .of(context)
    //                                                                                       .textTheme
    //                                                                                       .display1
    //                                                                                       .copyWith(
    //                                                                                       fontWeight: FontWeight.w500,
    //                                                                                       fontSize: 15,
    //                                                                                       color: Colors.black)
    //                                                                               );
    //                                                                             } else {
    //                                                                               return Text(
    //                                                                                  "$tanggal_bayar",
    //                                                                                   style: Theme
    //                                                                                       .of(context)
    //                                                                                       .textTheme
    //                                                                                       .display1
    //                                                                                       .copyWith(
    //                                                                                       fontWeight: FontWeight.w500,
    //                                                                                       fontSize: 15,
    //                                                                                       color: Colors.black)
    //                                                                               );
    //                                                                             }
    //                                                                           },
    //                                                                         )
    //                                                                       // Text(
    //                                                                       //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                                                       //     style: Theme
    //                                                                       //         .of(context)
    //                                                                       //         .textTheme
    //                                                                       //         .display1
    //                                                                       //         .copyWith(
    //                                                                       //         fontWeight: FontWeight.w500,
    //                                                                       //         fontSize: 15,
    //                                                                       //         color: Colors.black)
    //                                                                       // ),
    //                                                                     ),
    //                                                                   ),
    //                                                                 ],
    //                                                               ),
    //                                                             ),
    //
    //
    //
    //                                                       ],
    //                                                     );
    //                                                 }
    //                                               ),
    //                                             ],
    //                                           );
    //
    //
    //                                               // return Column(
    //                                               //   mainAxisAlignment: MainAxisAlignment.start,
    //                                               //   crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //   children: <Widget>[
    //                                               //     Padding(
    //                                               //       padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
    //                                               //       child: Text(
    //                                               //           nama,
    //                                               //           style: Theme
    //                                               //               .of(context)
    //                                               //               .textTheme
    //                                               //               .display1
    //                                               //               .copyWith(
    //                                               //               fontWeight: FontWeight.w500,
    //                                               //               fontSize: 17,
    //                                               //               color: Colors.black)
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //       //KODE
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Kode                 : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 kode,
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //     //KETERANGAN
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Keterangan      : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Container(
    //                                               //             width: size.width * .65,
    //                                               //             child: Padding(
    //                                               //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //               child: Text(
    //                                               //                   deskripsi,
    //                                               //                   style: Theme
    //                                               //                       .of(context)
    //                                               //                       .textTheme
    //                                               //                       .display1
    //                                               //                       .copyWith(
    //                                               //                       fontWeight: FontWeight.w500,
    //                                               //                       fontSize: 15,
    //                                               //                       color: Colors.black)
    //                                               //               ),
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //     //TANGGAL
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Tanggal            : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Container(
    //                                               //             child: Padding(
    //                                               //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //               child: Text(
    //                                               //                   tanggal,
    //                                               //                   style: Theme
    //                                               //                       .of(context)
    //                                               //                       .textTheme
    //                                               //                       .display1
    //                                               //                       .copyWith(
    //                                               //                       fontWeight: FontWeight.w500,
    //                                               //                       fontSize: 15,
    //                                               //                       color: Colors.black)
    //                                               //               ),
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //     //TOTAL
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Total                 : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Container(
    //                                               //             child: Padding(
    //                                               //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //               child: Text(
    //                                               //                   NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                               //                   style: Theme
    //                                               //                       .of(context)
    //                                               //                       .textTheme
    //                                               //                       .display1
    //                                               //                       .copyWith(
    //                                               //                       fontWeight: FontWeight.w500,
    //                                               //                       fontSize: 15,
    //                                               //                       color: Colors.black)
    //                                               //               ),
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //     //BAYAR
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Bayar                : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Container(
    //                                               //             child: Padding(
    //                                               //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //               child: Builder(
    //                                               //                 builder: (context){
    //                                               //                   if (bayar == null) {
    //                                               //                     return Text(
    //                                               //                       " - ",
    //                                               //                         style: Theme
    //                                               //                             .of(context)
    //                                               //                             .textTheme
    //                                               //                             .display1
    //                                               //                             .copyWith(
    //                                               //                             fontWeight: FontWeight.w500,
    //                                               //                             fontSize: 15,
    //                                               //                             color: Colors.black)
    //                                               //                     );
    //                                               //                   } else {
    //                                               //                     return Text(
    //                                               //                         NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
    //                                               //                         style: Theme
    //                                               //                             .of(context)
    //                                               //                             .textTheme
    //                                               //                             .display1
    //                                               //                             .copyWith(
    //                                               //                             fontWeight: FontWeight.w500,
    //                                               //                             fontSize: 15,
    //                                               //                             color: Colors.black)
    //                                               //                     );
    //                                               //                   }
    //                                               //                 },
    //                                               //               )
    //                                               //               // Text(
    //                                               //               //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                               //               //     style: Theme
    //                                               //               //         .of(context)
    //                                               //               //         .textTheme
    //                                               //               //         .display1
    //                                               //               //         .copyWith(
    //                                               //               //         fontWeight: FontWeight.w500,
    //                                               //               //         fontSize: 15,
    //                                               //               //         color: Colors.black)
    //                                               //               // ),
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //     //TANGGAL BAYAR
    //                                               //     Container(
    //                                               //       child: Row(
    //                                               //         mainAxisAlignment: MainAxisAlignment.start,
    //                                               //         crossAxisAlignment: CrossAxisAlignment.start,
    //                                               //         children: [
    //                                               //           Padding(
    //                                               //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //             child: Text(
    //                                               //                 "Tanggal Bayar : ",
    //                                               //                 style: Theme
    //                                               //                     .of(context)
    //                                               //                     .textTheme
    //                                               //                     .display1
    //                                               //                     .copyWith(
    //                                               //                     fontWeight: FontWeight.w500,
    //                                               //                     fontSize: 15,
    //                                               //                     color: Colors.black)
    //                                               //             ),
    //                                               //           ),
    //                                               //           Container(
    //                                               //             child: Padding(
    //                                               //                 padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
    //                                               //                 child: Builder(
    //                                               //                   builder: (context){
    //                                               //                     if (tanggal_bayar == "") {
    //                                               //                       return Text(
    //                                               //                           " - ",
    //                                               //                           style: Theme
    //                                               //                               .of(context)
    //                                               //                               .textTheme
    //                                               //                               .display1
    //                                               //                               .copyWith(
    //                                               //                               fontWeight: FontWeight.w500,
    //                                               //                               fontSize: 15,
    //                                               //                               color: Colors.black)
    //                                               //                       );
    //                                               //                     } else {
    //                                               //                       return Text(
    //                                               //                          tanggal_bayar,
    //                                               //                           style: Theme
    //                                               //                               .of(context)
    //                                               //                               .textTheme
    //                                               //                               .display1
    //                                               //                               .copyWith(
    //                                               //                               fontWeight: FontWeight.w500,
    //                                               //                               fontSize: 15,
    //                                               //                               color: Colors.black)
    //                                               //                       );
    //                                               //                     }
    //                                               //                   },
    //                                               //                 )
    //                                               //               // Text(
    //                                               //               //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
    //                                               //               //     style: Theme
    //                                               //               //         .of(context)
    //                                               //               //         .textTheme
    //                                               //               //         .display1
    //                                               //               //         .copyWith(
    //                                               //               //         fontWeight: FontWeight.w500,
    //                                               //               //         fontSize: 15,
    //                                               //               //         color: Colors.black)
    //                                               //               // ),
    //                                               //             ),
    //                                               //           ),
    //                                               //         ],
    //                                               //       ),
    //                                               //     ),
    //                                               //
    //                                               //   ],
    //                                               // );
    //
    //
    //                                             }),
    //                                       ],
    //                                     );
    //                                   }
    //                                 } else {
    //                                   return Container(
    //                                     height: size.height / 2, //70.0,
    //                                     child: Center(
    //                                       child: CircularProgressIndicator(),
    //                                     ),
    //                                   );
    //                                 }
    //                               },
    //                             ),
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: <Widget>[
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     right: 15, bottom: 30),
    //                                 child: Text("Total - ",
    //                                     style: Theme.of(context)
    //                                         .textTheme
    //                                         .display1
    //                                         .copyWith(
    //                                             fontWeight: FontWeight.w700,
    //                                             fontSize: 13,
    //                                             color: Colors.black)),
    //                               ),
    //
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //
    //               ],
    //             ),
    //           ],
    //         ),
    //       )),
    // );
  }
}
