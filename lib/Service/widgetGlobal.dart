import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wajib_baca/pages/contentLanda/profitLoss.dart';
import 'package:wajib_baca/pages/contentLanda/saldoKas.dart';
import 'package:wajib_baca/pages/contentLanda/salesOverdue.dart';
import 'package:wajib_baca/pages/contentProperty/profitLoss.dart';
import 'package:wajib_baca/pages/contentProperty/saldoKas.dart';
import 'package:wajib_baca/pages/contentProperty/salesOverdue.dart';
import 'package:wajib_baca/pages/contentVenturo/profitLoss.dart';
import 'package:wajib_baca/pages/contentVenturo/saldoKas.dart';
import 'package:wajib_baca/pages/contentVenturo/salesOverdue.dart';
import 'package:wajib_baca/pages/contentWajibBaca/profitLoss.dart';
import 'package:wajib_baca/pages/contentWajibBaca/saldoKas.dart';
import 'package:wajib_baca/pages/contentWajibBaca/salesOverdue.dart';

enum WidgetMarker { landa, wajibBaca, venturo, property }
WidgetMarker selectedWidgetMarker = WidgetMarker.landa;
WidgetMarker selectedAppBarMarker = WidgetMarker.landa;





Widget getCustomContainer(BuildContext context){
  switch(selectedWidgetMarker) {
    case WidgetMarker.landa:
      return landaFull(context);
    case WidgetMarker.wajibBaca:
      return wajibBacaFull(context);
    case WidgetMarker.venturo:
      return venturoFull(context);
    case WidgetMarker.property:
      return propertyFull(context);
  }
}

Widget getCustomAppBar(BuildContext context){
  switch(selectedWidgetMarker) {
    case WidgetMarker.landa:
      return landaAppBar(context);
    case WidgetMarker.wajibBaca:
      return wajibBacaAppBar(context);
    case WidgetMarker.venturo:
      return venturoAppBar(context);
    case WidgetMarker.property:
      return propertyAppBar(context);
  }
}

Widget landaAppBar(BuildContext context){
  return Container(
    child: Text(
      "LANDA",
      style: Theme.of(context).textTheme.display1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white),
    ),
  );
}

Widget wajibBacaAppBar(BuildContext context){
  return Container(
    child: Text(
      "WAJIB BACA",
      style: Theme.of(context).textTheme.display1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white),
    ),
  );
}

Widget venturoAppBar(BuildContext context){
  return Container(
    child: Text(
      "VENTURO",
      style: Theme.of(context).textTheme.display1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white),
    ),
  );
}

Widget propertyAppBar(BuildContext context){
  return Container(
    child: Text(
      "PROPERTY",
      style: Theme.of(context).textTheme.display1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.white),
    ),
  );
}

Widget landaFull(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 60),
    child: Column(
      children: <Widget>[
        SaldoKasLanda(),
        SalesOverdueLanda(),
        ProfitLossLanda(),
      ],
    ),
  );
}

Widget wajibBacaFull(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 60),
    child: Column(
      children: <Widget>[
        SaldoKasWajibBaca(),
        SalesOverdueWajibBaca(),
        ProfitLossWajibBaca(),
      ],
    ),
  );
}

Widget venturoFull(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 60),
    child: Column(
      children: <Widget>[
        SaldoKasVenturo(),
        SalesOverdueVenturo(),
        ProfitLossVenturo(),
      ],
    ),
  );
}

Widget propertyFull(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 60),
    child: Column(
      children: <Widget>[
        SaldoKasProperty(),
        SalesOverdueProperty(),
        ProfitLossProperty(),
      ],
    ),
  );
}