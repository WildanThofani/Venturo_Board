import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wajib_baca/Service/globalService.dart';
import 'package:wajib_baca/Service/saldoKasAPI.dart';
import 'package:wajib_baca/classModel/saldoKasModel.dart';
import 'package:http/http.dart' as http;
import 'package:wajib_baca/pages/contentLanda/profitLoss.dart';
import 'package:wajib_baca/pages/contentProperty/onPressedSaldoKas/onPressedSaldoKas.dart';

class SaldoKasProperty extends StatefulWidget {
  SaldoKasProperty({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SaldoKasPropertyState createState() => _SaldoKasPropertyState();
}

class _SaldoKasPropertyState extends State<SaldoKasProperty> {
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    _getSaldoKas() async {
      var response = await http.get(
          "https://accproptech.landa.co.id/api/site/getSaldoAkun");
      return jsonDecode(response.body);
    }


    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      // padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), //border radius exactly to ClipRRect
        boxShadow:[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          child :InkWell(
            child: Column(
              children: <Widget>[
                //ROW PERTAMA SALDO KAS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
                      child: SizedBox(
                        width: size.width * .32,
                        child: Text(
                          "Saldo Kas & Bank",
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                      child: Text("Per 12 $bulanString 2020",
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black)),
                    ),
                  ],
                ),

                //GARIS PERTAMA
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    height: 2,
                    width: double.maxFinite,
                    color: Colors.grey,
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: FutureBuilder(
                          future: _getSaldoKas(),
                          builder: (BuildContext context, snapshot){
                            print('_getSaldoKas ${snapshot.data}');
                            if(snapshot.hasData) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListView.separated(
                                      separatorBuilder: (context, index) => Divider(
                                        color: Colors.black,

                                      ),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data['data']['data']['detail'].length,
                                      itemBuilder: (BuildContext context, int index){
                                        var nama = snapshot.data['data']['data']['detail'][index]['nama'];
                                        var saldo = snapshot.data['data']['data']['detail'][index]['total'];
                                        print("nama $nama");
                                        print("saldo $saldo");
                                        return Container(
                                          child: Column(
                                            children: [

                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                  child: Container(
                                                    child: Stack(
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => OnpressedSaldoKasProperty()));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                child: SizedBox(
                                                                  width: size.width * .40,
                                                                  child: Text(nama,

                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 13,
                                                                          color: Colors.black)
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                  child: new Text(
                                                                      NumberFormat.currency(locale: 'id', symbol: "Rp. ", decimalDigits: 0).format(saldo),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .display1
                                                                          .copyWith(
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 14,

                                                                          color: Colors.black)),
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              );

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

                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: 2,
                      width: double.maxFinite,
                      color: Colors.grey,
                    ),

                  ),
                ),

                // ROW 3 CONTAINER BIRU
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Text(
                          "TOTAL",
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1
                              .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: FutureBuilder(
                          future: _getSaldoKas(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              var total =
                              snapshot.data['data']['data']['total'];
                              return Container(
                                child: Text(
                                    NumberFormat.currency(locale: 'id',
                                        symbol: "Rp. ",
                                        decimalDigits: 0).format(total),
                                    style: Theme
                                        .of(context)
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
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator()
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
            ),
          ),

        ),
      ),
    );
  }


}
