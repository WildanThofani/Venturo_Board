import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wajib_baca/Service/globalService.dart';

import '../profitLoss.dart';

class OnPressedSalesOverdueVenturo extends StatefulWidget {
  @override
  OnPressedSalesOverdueVenturoState createState() =>
      OnPressedSalesOverdueVenturoState();
}

class OnPressedSalesOverdueVenturoState extends State<OnPressedSalesOverdueVenturo> {
  var now = DateTime.now();
  String bulanString =
  Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt =
  BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];

  Future ambilDetailOverDue() async {
    var data = await http.get(
        'https://2019-venturo.landa.co.id/api/laporanpiutang/index?status_lunas=belum_lunas');

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




  @override
  void initState() {
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
            title: Text("Sales Overdue"),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    //HEADER
                    Container(
                      width: double.maxFinite,
                      color: Colors.grey.withOpacity(0.8),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Venturo",
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: FutureBuilder(
                              future:ambilDetailOverDue(),
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
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context, index) {
                                              var key = snapshot.data.keys.toList()[index];
                                              var nama = snapshot.data[key]["nama"];
                                              var kunci = snapshot.data[key];


                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: double.maxFinite,
                                                    color: Colors.grey.withOpacity(0.2),
                                                    child: Padding(
                                                      padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                                      child: Text(
                                                          nama,
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .display1
                                                              .copyWith(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 17,
                                                              color: Colors.black)
                                                      ),
                                                    ),
                                                  ),
                                                  ListView.separated(
                                                      separatorBuilder: (context, index) => Divider(
                                                        color: Colors.black,
                                                      ),
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: snapshot.data[key]['detail_fix'].length,
                                                      itemBuilder: (BuildContext context, index) {
                                                        var kode = snapshot.data[key]['detail_fix'][index]['kode'];
                                                        var tanggal = snapshot.data[key]['detail_fix'][index]['format_tanggal'];
                                                        var deskripsi =snapshot.data [key]['detail_fix'][index]['deskripsi'];
                                                        var total = snapshot.data[key]['detail_fix'][index]['total'];
                                                        var bayar = snapshot.data[key]['detail_fix'][index]['bayar'];
                                                        var tanggal_bayar = snapshot.data[key]['detail_fix'][index]['tanggal_bayar'];
                                                        return Column(
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
                                                  ),
                                                ],
                                              );


                                              // return Column(
                                              //   mainAxisAlignment: MainAxisAlignment.start,
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              //   children: <Widget>[
                                              //     Padding(
                                              //       padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                                              //       child: Text(
                                              //           nama,
                                              //           style: Theme
                                              //               .of(context)
                                              //               .textTheme
                                              //               .display1
                                              //               .copyWith(
                                              //               fontWeight: FontWeight.w500,
                                              //               fontSize: 17,
                                              //               color: Colors.black)
                                              //       ),
                                              //     ),
                                              //
                                              //       //KODE
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Kode                 : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 kode,
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //     //KETERANGAN
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Keterangan      : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             width: size.width * .65,
                                              //             child: Padding(
                                              //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //               child: Text(
                                              //                   deskripsi,
                                              //                   style: Theme
                                              //                       .of(context)
                                              //                       .textTheme
                                              //                       .display1
                                              //                       .copyWith(
                                              //                       fontWeight: FontWeight.w500,
                                              //                       fontSize: 15,
                                              //                       color: Colors.black)
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //     //TANGGAL
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Tanggal            : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             child: Padding(
                                              //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //               child: Text(
                                              //                   tanggal,
                                              //                   style: Theme
                                              //                       .of(context)
                                              //                       .textTheme
                                              //                       .display1
                                              //                       .copyWith(
                                              //                       fontWeight: FontWeight.w500,
                                              //                       fontSize: 15,
                                              //                       color: Colors.black)
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //     //TOTAL
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Total                 : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             child: Padding(
                                              //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //               child: Text(
                                              //                   NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              //                   style: Theme
                                              //                       .of(context)
                                              //                       .textTheme
                                              //                       .display1
                                              //                       .copyWith(
                                              //                       fontWeight: FontWeight.w500,
                                              //                       fontSize: 15,
                                              //                       color: Colors.black)
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //     //BAYAR
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Bayar                : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             child: Padding(
                                              //               padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //               child: Builder(
                                              //                 builder: (context){
                                              //                   if (bayar == null) {
                                              //                     return Text(
                                              //                       " - ",
                                              //                         style: Theme
                                              //                             .of(context)
                                              //                             .textTheme
                                              //                             .display1
                                              //                             .copyWith(
                                              //                             fontWeight: FontWeight.w500,
                                              //                             fontSize: 15,
                                              //                             color: Colors.black)
                                              //                     );
                                              //                   } else {
                                              //                     return Text(
                                              //                         NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(bayar),
                                              //                         style: Theme
                                              //                             .of(context)
                                              //                             .textTheme
                                              //                             .display1
                                              //                             .copyWith(
                                              //                             fontWeight: FontWeight.w500,
                                              //                             fontSize: 15,
                                              //                             color: Colors.black)
                                              //                     );
                                              //                   }
                                              //                 },
                                              //               )
                                              //               // Text(
                                              //               //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              //               //     style: Theme
                                              //               //         .of(context)
                                              //               //         .textTheme
                                              //               //         .display1
                                              //               //         .copyWith(
                                              //               //         fontWeight: FontWeight.w500,
                                              //               //         fontSize: 15,
                                              //               //         color: Colors.black)
                                              //               // ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //     //TANGGAL BAYAR
                                              //     Container(
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.start,
                                              //         children: [
                                              //           Padding(
                                              //             padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //             child: Text(
                                              //                 "Tanggal Bayar : ",
                                              //                 style: Theme
                                              //                     .of(context)
                                              //                     .textTheme
                                              //                     .display1
                                              //                     .copyWith(
                                              //                     fontWeight: FontWeight.w500,
                                              //                     fontSize: 15,
                                              //                     color: Colors.black)
                                              //             ),
                                              //           ),
                                              //           Container(
                                              //             child: Padding(
                                              //                 padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
                                              //                 child: Builder(
                                              //                   builder: (context){
                                              //                     if (tanggal_bayar == "") {
                                              //                       return Text(
                                              //                           " - ",
                                              //                           style: Theme
                                              //                               .of(context)
                                              //                               .textTheme
                                              //                               .display1
                                              //                               .copyWith(
                                              //                               fontWeight: FontWeight.w500,
                                              //                               fontSize: 15,
                                              //                               color: Colors.black)
                                              //                       );
                                              //                     } else {
                                              //                       return Text(
                                              //                          tanggal_bayar,
                                              //                           style: Theme
                                              //                               .of(context)
                                              //                               .textTheme
                                              //                               .display1
                                              //                               .copyWith(
                                              //                               fontWeight: FontWeight.w500,
                                              //                               fontSize: 15,
                                              //                               color: Colors.black)
                                              //                       );
                                              //                     }
                                              //                   },
                                              //                 )
                                              //               // Text(
                                              //               //     NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(total),
                                              //               //     style: Theme
                                              //               //         .of(context)
                                              //               //         .textTheme
                                              //               //         .display1
                                              //               //         .copyWith(
                                              //               //         fontWeight: FontWeight.w500,
                                              //               //         fontSize: 15,
                                              //               //         color: Colors.black)
                                              //               // ),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //
                                              //   ],
                                              // );


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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 30),
                                child: Text("Total - ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                        color: Colors.black)),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          )),
    );
  }
}
