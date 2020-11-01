
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


  var nowGlobalService = DateTime.now();
  String bulanString = Constans.namaBulan[DateFormat('MM').format(DateTime.now())];
  String bulanInt = BulanConstans.bulan[DateFormat('MM').format(DateTime.now())];
  int loading = 0;


  


  //LANDA
  getProfitLossLanda(DateTime dt) async {
    print("BulanInt $bulanInt");

    https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?
    // endDate=2020-09-30&export=0&is_detail=1&lokasi_nama=Landa+System&
    // m_lokasi_id=1&print=0&startDate=2020-09-01

    var response = await http.get(
        "https://accsystems.landa.co.id/api/acc/l_laba_rugi/laporan?endDate=2020-" +
            bulanInt +
//            "07" +
            "-31&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&startDate=2020-" +
            bulanInt +
//                "07" +
            "-01");
    print("BulanString $bulanString");
    print("responBody ${response.body}");
    return jsonDecode(response.body);
  }

  getCashflowPenerimaanLanda(DateTime dt) async {
    var response = await http.get(
        "https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
            "endDate=2020-"+ bulanInt + "-31" +
            "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
            "startDate=2020-"+ bulanInt +"-01" +
            "&tipe=penerimaan");
    return jsonDecode(response.body);
  }

  getCashflowPengeluaranLanda(DateTime dt) async {
    var response = await http.get(
        "https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
            "endDate=2020-"+ bulanInt + "-31" +
            "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
            "startDate=2020-"+ bulanInt +"-01" +
            "&tipe=pengeluaran");
    return jsonDecode(response.body);
  }

  getnNeracaLanda(DateTime dt) async {
    var response = await http.get(
        "https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
            "tanggal=2020-" + bulanInt + "-31");
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> getCashFlowTotalLanda(DateTime dt) async {
    var value = <Map<String, dynamic>>[];
    var penerimaan = http.get("https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
        "endDate=2020-"+ bulanInt + "-31" +
        "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
        "startDate=2020-"+ bulanInt +"-01" +
        "&tipe=penerimaan");
    var pengeluaran = http.get("https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
        "endDate=2020-"+ bulanInt + "-31" +
        "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
        "startDate=2020-"+ bulanInt + "-01" +
        "&tipe=pengeluaran");
    var results = await Future.wait([penerimaan, pengeluaran]); // list of Responses
    for (var response in results) {
      print("StatusCode _getCashFLowTotal${response.statusCode}");
      // todo - parse the response - perhaps JSON
      value.add(json.decode(response.body));
    }
    print("valueGetTotal $value");
    return value;
  }

  //WAJIB BACA
  getProfitLossWB(DateTime dt) async {
    print("BulanInt $bulanInt");

    var response = await http.get(
        "https://accwb.landa.co.id/api/acc/l_laba_rugi/laporan?endDate=2020-" +
            bulanInt +
//            "07" +
            "-31&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&startDate=2020-" +
            bulanInt +
//                "07" +
            "-01");
    print("BulanString $bulanString");
    print("responBody ${response.body}");
    return jsonDecode(response.body);
  }

  getneracaWB(DateTime dt) async {
    var response = await http.get(
        "https://accwb.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
            "tanggal=2020-" + bulanInt + "-10");
    return jsonDecode(response.body);
  }

  getCashflowPenerimaanWB(DateTime dt) async {
    var response = await http.get(
        "https://accwb.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
            "endDate=2020-"+ bulanInt + "-31" +
            "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
            "startDate=2020-"+ bulanInt +"-01" +
            "&tipe=penerimaan");
    return jsonDecode(response.body);
  }

  getCashflowPengeluaranWB(DateTime dt) async {
    var response = await http.get(
        "https://accwb.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
            "endDate=2020-"+ bulanInt + "-31" +
            "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
            "startDate=2020-"+ bulanInt + "-01" +
            "&tipe=pengeluaran");
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> getCashFlowTotalWB(DateTime dt) async {
    var value = <Map<String, dynamic>>[];
    var penerimaan = http.get("https://accwb.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
        "endDate=2020-"+ bulanInt + "-31" +
        "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
        "startDate=2020-"+ bulanInt +"-01" +
        "&tipe=penerimaan");
    var pengeluaran = http.get("https://accwb.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
        "endDate=2020-"+ bulanInt + "-31" +
        "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
        "startDate=2020-"+ bulanInt + "-01" +
        "&tipe=pengeluaran");
    var results = await Future.wait([penerimaan, pengeluaran]); // list of Responses
    for (var response in results) {
      print(response.statusCode);
      // todo - parse the response - perhaps JSON
      value.add(json.decode(response.body));
    }
    print("valueGetTotal $value");
    return value;
  }

getnNeracaWB(DateTime dt) async {
  var response = await http.get(
      "https://accsystems.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
          "tanggal=2020-" + bulanInt + "-31");
  return jsonDecode(response.body);
}



//PROPERTY
getProfitLossProp(DateTime dt) async {
  print("BulanInt $bulanInt");

  var response = await http.get(
      "https://accproptech.landa.co.id/api/acc/l_laba_rugi/laporan?endDate=2020-" +
          bulanInt +
//            "07" +
          "-31&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&startDate=2020-" +
          bulanInt +
//                "07" +
          "-01");
  print("BulanString $bulanString");
  print("responBody ${response.body}");
  return jsonDecode(response.body);
}

getneracaProp(DateTime dt) async {
  var response = await http.get(
      "https://accproptech.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
          "tanggal=2020-" + bulanInt + "-10");
  return jsonDecode(response.body);
}

getCashflowPenerimaanProp(DateTime dt) async {
  var response = await http.get(
      "https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
          "endDate=2020-"+ bulanInt + "-31" +
          "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
          "startDate=2020-"+ bulanInt +"-01" +
          "&tipe=penerimaan");
  return jsonDecode(response.body);
}

getCashflowPengeluaranProp(DateTime dt) async {
  var response = await http.get(
      "https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
          "endDate=2020-"+ bulanInt + "-31" +
          "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
          "startDate=2020-"+ bulanInt + "-01" +
          "&tipe=pengeluaran");
  return jsonDecode(response.body);
}

Future<List<Map<String, dynamic>>> getCashFlowTotalProp(DateTime dt) async {
  var value = <Map<String, dynamic>>[];
  var penerimaan = http.get("https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
      "endDate=2020-"+ bulanInt + "-31" +
      "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
      "startDate=2020-"+ bulanInt +"-01" +
      "&tipe=penerimaan");
  var pengeluaran = http.get("https://accproptech.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
      "endDate=2020-"+ bulanInt + "-31" +
      "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
      "startDate=2020-"+ bulanInt + "-01" +
      "&tipe=pengeluaran");
  var results = await Future.wait([penerimaan, pengeluaran]); // list of Responses
  for (var response in results) {
    print(response.statusCode);
    // todo - parse the response - perhaps JSON
    value.add(json.decode(response.body));
  }
  print("valueGetTotal $value");
  return value;
}

getnNeracaProp(DateTime dt) async {
  var response = await http.get(
      "https://accproptech.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
          "tanggal=2020-" + bulanInt + "-31");
  return jsonDecode(response.body);
}

//VENTURO
getProfitLossVen(DateTime dt) async {
  print("BulanInt $bulanInt");

  var response = await http.get(
      "https://accventuro.landa.co.id/api/acc/l_laba_rugi/laporan?endDate=2020-" +
          bulanInt +
//            "07" +
          "-31&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&startDate=2020-" +
          bulanInt +
//                "07" +
          "-01");
  print("BulanString $bulanString");
  print("responBody ${response.body}");
  return jsonDecode(response.body);
}

getneracaVen(DateTime dt) async {
  var response = await http.get(
      "https://accventuro.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
          "tanggal=2020-" + bulanInt + "-10");
  return jsonDecode(response.body);
}

getCashflowPenerimaanVen(DateTime dt) async {
  var response = await http.get(
      "https://accventuro.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
          "endDate=2020-"+ bulanInt + "-31" +
          "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
          "startDate=2020-"+ bulanInt +"-01" +
          "&tipe=penerimaan");
  return jsonDecode(response.body);
}

getCashflowPengeluaranVen(DateTime dt) async {
  var response = await http.get(
      "https://accventuro.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
          "endDate=2020-"+ bulanInt + "-31" +
          "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
          "startDate=2020-"+ bulanInt + "-01" +
          "&tipe=pengeluaran");
  return jsonDecode(response.body);
}

Future<List<Map<String, dynamic>>> getCashFlowTotalVen(DateTime dt) async {
  var value = <Map<String, dynamic>>[];
  var penerimaan = http.get("https://accventuro.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
      "endDate=2020-"+ bulanInt + "-31" +
      "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
      "startDate=2020-"+ bulanInt +"-01" +
      "&tipe=penerimaan");
  var pengeluaran = http.get("https://accventuro.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
      "endDate=2020-"+ bulanInt + "-31" +
      "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
      "startDate=2020-"+ bulanInt + "-01" +
      "&tipe=pengeluaran");
  var results = await Future.wait([penerimaan, pengeluaran]); // list of Responses
  for (var response in results) {
    print(response.statusCode);
    // todo - parse the response - perhaps JSON
    value.add(json.decode(response.body));
  }
  print("valueGetTotal $value");
  return value;
}

getnNeracaVen(DateTime dt) async {
  var response = await http.get(
      "https://accventuro.landa.co.id/api/acc/l_neraca/laporan?export=0&is_detail=1&lokasi_nama=Landa+System&m_lokasi_id=1&print=0&" +
          "tanggal=2020-" + bulanInt + "-31");
  return jsonDecode(response.body);
}


nextIntBulan(int i){
    if (i == 1) {
      var bln = Jiffy(nowGlobalService).add(months: 1);
      bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
      bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
      nowGlobalService = Jiffy(nowGlobalService).add(months: 1);
      getProfitLossLanda(nowGlobalService);
      getCashFlowTotalLanda(nowGlobalService);
      getCashflowPengeluaranLanda(nowGlobalService);
      getCashflowPenerimaanLanda(nowGlobalService);
      getnNeracaLanda(nowGlobalService);
    } else {
      var bln = Jiffy(nowGlobalService).subtract(months: 1);
      bulanInt = BulanConstans.bulan[DateFormat('MM').format(bln)];
      bulanString = Constans.namaBulan[DateFormat('MM').format(bln)];
      nowGlobalService = Jiffy(nowGlobalService).subtract(months: 1);
      getProfitLossLanda(nowGlobalService);
      getCashFlowTotalLanda(nowGlobalService);
      getCashflowPengeluaranLanda(nowGlobalService);
      getCashflowPenerimaanLanda(nowGlobalService);
      getnNeracaLanda(nowGlobalService);
    }
}


class Constans{
  static const namaBulan = {
    "01": "Januari",
    "02": "Februari",
    "03": "Maret",
    "04": "April",
    "05": "Mei",
    "06": "Juni",
    "07": "Juli",
    "08": "Agustus",
    "09": "September",
    "10": "Oktober",
    "11": "November",
    "12": "Desember",
  };

}

class BulanConstans{
  static const bulan = {
    "01": "01",
    "02": "02",
    "03": "03",
    "04": "04",
    "05": "05",
    "06": "06",
    "07": "07",
    "08": "08",
    "09": "09",
    "10": "10",
    "11": "11",
    "12": "12",

  };
}

class TahunConstans{
  static const tahun = {
    "01": "2019",
    "02": "2020",
    "03": "2021",
  };
}