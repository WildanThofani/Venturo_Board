//
//
//import 'dart:convert';
//import 'dart:developer';
//
//import 'package:http/http.dart';
//import 'dart:convert' as convert;
//import 'package:http/http.dart' as http;
//import 'package:wajib_baca/classModel/profitLossModel.dart';
//
//
////class ProfitLossAPII {
//////  static String url = "https://accsystems.landa.co.id/api/site/getSaldoAkun";
////
////  static Future getProfitLoss() async {
////    final SharedPreferences sp = await SharedPreferences.getInstance();
////    var jsonResponse;
////    log(sp.getString('base64'));
////    try {
////      final http.Response response = await http.get(
////          "https://accsystems.landa.co.id/api/acc/l_arus_kas_custom/laporan",
////          headers: <String, String>{
////            'Content-Type': 'application/json; charset=UTF-8',
////            'Authorization': 'Bearer ' + sp.getString('base64') ?? ""
////          }
////      );
////      if (response.statusCode == 200) {
////        jsonResponse = convert.jsonDecode(response.body);
////        log(jsonResponse.toString());
////        log(response.body);
////      }
////    } catch (e) {
////      print(e);
////    }
////    return jsonResponse;
////  }
////}
//
//class ProfitLossAPI {
//  final String postsURL = "https://accsystems.landa.co.id/api/acc/l_arus_kas_custom/laporan";
//
////  Future<List<ProfitLossModel>> getProfitLosss() async {
////    Response res = await get(postsURL);
////
////    if (res.statusCode == 200) {
////      List<dynamic> body = jsonDecode(res.body);
////
////      List<ProfitLossModel> profit = body
////          .map(
////            (dynamic item) => ProfitLossModel.fromJson(item),
////      )
////          .toList();
////
////      return profit;
////    } else {
////      throw "Can't get posts.";
////    }
////  }
//
//
//  static Future getProfitLoss(String bulan,) async {
//    final SharedPreferences sp = await SharedPreferences.getInstance();
//
//    var jsonResponse;
//    try {
//      log("https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
//          "endDate=2020-" + bulan + "-31" +
//          "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
//          "startDate=2020-"+ bulan +"-010" +
//          "&tipe=penerimaan");
//      final http.Response response = await http.get(
//        "https://accsystems.landa.co.id/api/acc/l_jurnal_kas/laporan?" +
//            "endDate=2020-" + bulan + "-31" +
//            "&export=0&m_lokasi_id=1&nama_lokasi=Landa+System&print=0&" +
//            "startDate=2020-"+ bulan +"-010" +
//            "&tipe=penerimaan",
//        headers: <String, String>{
//          'Content-Type': 'application/json; charset=UTF-8',
//          'Authorization': 'Bearer ' + sp.getString('base64') ?? ""
//        },
//      );
//      if (response.statusCode == 200) {
//        jsonResponse = convert.jsonDecode(response.body);
//      }
//    } catch (e) {
//      print(e);
//    }
//
//    return jsonResponse;
//  }
//
//}