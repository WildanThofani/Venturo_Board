//
//
//import 'dart:convert';
//import 'dart:developer';
//
//import 'package:http/http.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;
//import 'package:wajib_baca/classModel/saldoKasModel.dart';
//
//
//class SaldoKasAPI {
//
//  static Future getSaldoKass() async {
//
//    final SharedPreferences sp = await SharedPreferences.getInstance();
//    var jsonResponse;
//    log(sp.getString('base64'));
//    try {
//      final http.Response response = await http.get(
//      "https://accsystems.landa.co.id/api/site/getSaldoAkun",
//          headers: <String, String>{
//            'Content-Type': 'application/json; charset=UTF-8',
//            'Authorization': 'Bearer ' + sp.getString('base64') ?? ""
//          }
//    );
//      if (response.statusCode == 200) {
//        jsonResponse = convert.jsonDecode(response.body);
//        log(jsonResponse.toString());
//      }
//    } catch (e) {
//      print(e);
//    }
//    print(jsonResponse.body);
//    return jsonResponse;
//  }
//
////  Future<List<SaldoKasModel>> getSaldoKas() async {
////    Response res = await get(url);
////
////    if (res.statusCode == 200) {
////      List<dynamic> body = jsonDecode(res.body);
////
////      List<SaldoKasModel> saldoKas = body
////          .map(
////            (dynamic item) => SaldoKasModel.fromJson(item),
////      )
////          .toList();
////
////      return saldoKas;
////    } else {
////      throw "Can't get posts.";
////    }
////  }
//}