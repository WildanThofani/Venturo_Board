import 'package:flutter/cupertino.dart';

class ProfitLossModell {
  String totalPenerimaan;
  String totalPengeluaran;
  String saldoBiaya;

  ProfitLossModel(
      String total_penerimaan,
      String total_pengeluaran,
      String saldo_biaya,
      ) {
    this.totalPenerimaan = total_penerimaan;
    this.totalPengeluaran = total_pengeluaran;
    this.saldoBiaya = saldo_biaya;
  }

  ProfitLossModell.fromJson(Map json)
      : totalPenerimaan = json['data']['data']['total_penerimaan'].toString(),
        totalPengeluaran = json['data']['data']['total_pengeluaran'].toString(),
        saldoBiaya = json['data']['data']['saldo_biaya'].toString();

  Map toJson() {
    return {
      'total_penerimaan': totalPenerimaan,
      'total_pengeluaran': totalPengeluaran,
      'saldo_biaya': saldoBiaya
    };
  }
}


class ProfitLossModel {
  final int total_penerimaan;
  final int total_pengeluaran;
  final String saldo_biaya;

  ProfitLossModel({
    @required this.total_penerimaan,
    @required this.total_pengeluaran,
    @required this.saldo_biaya,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      total_penerimaan: json['data']['data']['total_penerimaan'] as int,
      total_pengeluaran: json['data']['data']['total_pengeluaran'] as int,
      saldo_biaya: json['data']['data']['saldo_biaya'] as String,
    );
  }
}