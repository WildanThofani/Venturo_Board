import 'package:flutter/cupertino.dart';

class SaldoKasModel {
  String nama;
  String saldoNama;
  int total;

  SaldoKasModel(
    String nama,
    String saldoNama,
    int total,
  ) {
    this.nama = nama;
    this.saldoNama = saldoNama;
    this.total = total;
  }

  SaldoKasModel.fromJson(Map json)
      : nama = json['data']['data']['detail']['nama'].toString(),
        saldoNama = json['data']['data']['detail']['total'].toString(),
        total = json['data']['data']['total'].toInt();

  Map toJson() {
    return {'nama': nama, '1': saldoNama, 'total': total};
  }
}

//class SaldoKasModel {
//  final String nama;
//  final String saldoNama;
//  final String total;
//
//  SaldoKasModel({
//    @required this.nama,
//    @required this.saldoNama,
//    @required this.total,
//  });
//
//  factory SaldoKasModel.fromJson(Map<String, dynamic> json) {
//    return SaldoKasModel(
//      nama: json['data']['data']['detail']['nama'] as String,
//      saldoNama: json['title'] as String,
//      total: json['data']['data']['total'] as String,
//    );
//  }
//}
