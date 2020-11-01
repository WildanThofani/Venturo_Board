
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wajib_baca/pages/contentLanda/onPressedProfitLoss/onPressedProfitLoss.dart';
import 'package:wajib_baca/pages/contentLanda/profitLoss.dart';
import 'package:wajib_baca/pages/contentLanda/saldoKas.dart';
import 'package:wajib_baca/pages/contentLanda/salesOverdue.dart';

import '../dashboard_page.dart';

class LandaHomePage extends StatefulWidget {
  LandaHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandaHomePageState createState() => _LandaHomePageState();
}

class _LandaHomePageState extends State<LandaHomePage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SaldoKasLanda(),
                SalesOverdueLanda(),
                ProfitLossLanda(),
//              cashFlowWidgetLanda(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
