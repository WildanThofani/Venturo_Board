
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wajib_baca/Service/globalService.dart';
import 'package:wajib_baca/Service/widgetGlobal.dart';
import 'package:wajib_baca/pages/contentLanda/profitLoss.dart';
import 'package:wajib_baca/pages/contentLanda/saldoKas.dart';
import 'package:wajib_baca/pages/contentLanda/salesOverdue.dart';
import 'package:wajib_baca/pages/contentWajibBaca/profitLoss.dart';
import 'package:wajib_baca/pages/contentWajibBaca/saldoKas.dart';
import 'package:wajib_baca/pages/contentWajibBaca/salesOverdue.dart';

import 'contentLanda/dashboard_Landa.dart';
import 'contentProperty/profitLoss.dart';
import 'contentProperty/saldoKas.dart';
import 'contentProperty/salesOverdue.dart';
import 'contentVenturo/profitLoss.dart';
import 'contentVenturo/saldoKas.dart';
import 'contentVenturo/salesOverdue.dart';
//import 'contentWajibBaca/dashboard_Property.dart';

// enum WidgetMarker { landa, wajibBaca, venturo, property }

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // WidgetMarker selectedWidgetMarker = WidgetMarker.landa;
  // WidgetMarker selectedAppBarMarker = WidgetMarker.landa;
  String _itemNull;
  int _selectedTabIndex = 0;



  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> menu = ["Landa", "Wajib Baca", "Venturo", "Property"];
    return menu.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int state = 1;
    final double height = MediaQuery.of(context).size.height * 0.2;

    void _showDialogGantiPerusahaan() {

      Alert(
        context: context,
        type: AlertType.none,
        title: "Pindah Perusahaan",

        content: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      height: 40,
                      decoration: new BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.95),
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Landa",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedWidgetMarker = WidgetMarker.landa;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      height: 40,
                      decoration: new BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.95),
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Wajib Baca",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedWidgetMarker = WidgetMarker.wajibBaca;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      height: 40,
                      decoration: new BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.95),
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Venturo",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedWidgetMarker = WidgetMarker.venturo;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      width: double.maxFinite,
                      height: 40,
                      decoration: new BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.95),
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Property",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.display1.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedWidgetMarker = WidgetMarker.property;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buttons: []
      ).show();


      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     // return object of type Dialog
      //     return AlertDialog(
      //       // title: new Column(
      //       //   mainAxisAlignment: MainAxisAlignment.end,
      //       //   crossAxisAlignment: CrossAxisAlignment.end,
      //       //   children: [
      //       //     Row(
      //       //       mainAxisAlignment: MainAxisAlignment.end,
      //       //       crossAxisAlignment: CrossAxisAlignment.end,
      //       //       children: [
      //       //         IconButton(
      //       //           icon: Icon(Icons.close),
      //       //           iconSize: 30,
      //       //           color: Colors.grey,
      //       //           onPressed: () {
      //       //             Navigator.pop(context);
      //       //           },
      //       //         )
      //       //       ],
      //       //     ),
      //       //
      //       //     Row(
      //       //       children: [
      //       //         Text("Pindah Perusahaan"),
      //       //       ],
      //       //     ),
      //       //   ],
      //       // ),
      //       content: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text("Pindah Perusahaan",
      //                   style: Theme.of(context).textTheme.display1.copyWith(
      //                       fontWeight: FontWeight.w500,
      //                       fontSize: 17,
      //                       color: Colors.black),
      //                 ),
      //                 IconButton(
      //                 icon: Icon(Icons.close),
      //                 iconSize: 30,
      //                 color: Colors.grey,
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //               ),
      //               ],
      //             ),
      //             Align(
      //               alignment: Alignment.centerLeft,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Row(
      //                     children: [
      //                       new FlatButton(
      //                         child: new Text(
      //                             "Landa System",
      //                           style: Theme.of(context).textTheme.display1.copyWith(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 13,
      //                               color: Colors.black),
      //                         ),
      //                         onPressed: () {
      //                           setState(() {
      //                             selectedWidgetMarker = WidgetMarker.landa;
      //                             Navigator.pop(context);
      //                           });
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //
      //                   new FlatButton(
      //                     child: new Text(
      //                         "Wajib Baca",
      //                       style: Theme.of(context).textTheme.display1.copyWith(
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: 13,
      //                           color: Colors.black),
      //                     ),
      //                     onPressed: () {
      //                       setState(() {
      //                         selectedWidgetMarker = WidgetMarker.wajibBaca;
      //                         Navigator.pop(context);
      //                       });
      //
      //                     },
      //                   ),
      //
      //                   new FlatButton(
      //                     child: new Text(
      //                       "Venturo",
      //                       style: Theme.of(context).textTheme.display1.copyWith(
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: 13,
      //                           color: Colors.black),
      //                     ),
      //                     onPressed: () {
      //                       setState(() {
      //                         selectedWidgetMarker = WidgetMarker.venturo;
      //                         Navigator.pop(context);
      //                       });
      //
      //                     },
      //                   ),
      //
      //                   new FlatButton(
      //                     child: new Text(
      //                         "Property",
      //                       style: Theme.of(context).textTheme.display1.copyWith(
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: 13,
      //                           color: Colors.black),
      //                     ),
      //                     onPressed: () {
      //                       setState(() {
      //                         selectedWidgetMarker = WidgetMarker.property;
      //                         Navigator.pop(context);
      //                       });
      //
      //                     },
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //     );
      //   },
      // );
    }

    return Scaffold(
         backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  nextIntBulan(2);
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: Text(
                bulanString,
                style: Theme.of(context).textTheme.display1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                size: 15,
                color: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  nextIntBulan(1);
                });

              },
            ),
          ],
        ),
      ),
          body: Container(
            child: ListView(
               children: [
                 Stack(
                   children: <Widget>[
                     Container(
                       child: ClipPath(
                         clipper: CustomShape(),
                         child: Container(
                           height: 250,
                           width: double.infinity,
                           color: Colors.redAccent,
                         ),
                       ),
                     ),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         //Perusahaan
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Padding(
                               padding: EdgeInsets.fromLTRB(10,10,3,10),
                               child: FlatButton(
                                 child: Row(
                               children: [
                                getCustomAppBar(context),
                                 Icon(
                                   Icons.keyboard_arrow_down,
                                     size: 18,
                                     color: Colors.white
                                 ),
                                ],
                               ),
                                 onPressed: (){
                                   _showDialogGantiPerusahaan();
                                 },
                               )
                             ),

                           ],
                         ),

                         //Profile
                         Padding(
                           padding: const EdgeInsets.only(right: 5),
                           child: IconButton(
                             icon: Icon(
                               Icons.account_circle,
                                 size: 30,
                                 color: Colors.white
                             ),
                             onPressed: () {},
                           ),
                         )
                       ],
                     ),
                     Container(
                       child: getCustomContainer(context),
                     )
                   ],
                 )
               ],
            ),
          ),
      );

  }


  // Widget getCustomContainer(){
  //   switch(selectedWidgetMarker) {
  //     case WidgetMarker.landa:
  //       return landaFull();
  //     case WidgetMarker.wajibBaca:
  //       return wajibBacaFull();
  //     case WidgetMarker.venturo:
  //       return venturoFull();
  //     case WidgetMarker.property:
  //       return propertyFull();
  //   }
  // }
  //
  // Widget getCustomAppBar(){
  //   switch(selectedWidgetMarker) {
  //     case WidgetMarker.landa:
  //       return landaAppBar();
  //     case WidgetMarker.wajibBaca:
  //       return wajibBacaAppBar();
  //     case WidgetMarker.venturo:
  //       return venturoAppBar();
  //     case WidgetMarker.property:
  //       return propertyAppBar();
  //   }
  // }
  //
  // Widget landaAppBar(){
  //   return Container(
  //     child: Text(
  //       "LANDA",
  //       style: Theme.of(context).textTheme.display1.copyWith(
  //           fontWeight: FontWeight.w700,
  //           fontSize: 15,
  //           color: Colors.white),
  //     ),
  //   );
  // }
  //
  // Widget wajibBacaAppBar(){
  //   return Container(
  //     child: Text(
  //       "WAJIB BACA",
  //       style: Theme.of(context).textTheme.display1.copyWith(
  //           fontWeight: FontWeight.w700,
  //           fontSize: 15,
  //           color: Colors.white),
  //     ),
  //   );
  // }
  //
  // Widget venturoAppBar(){
  //   return Container(
  //     child: Text(
  //       "VENTURO",
  //       style: Theme.of(context).textTheme.display1.copyWith(
  //           fontWeight: FontWeight.w700,
  //           fontSize: 15,
  //           color: Colors.white),
  //     ),
  //   );
  // }
  //
  // Widget propertyAppBar(){
  //   return Container(
  //     child: Text(
  //       "PROPERTY",
  //       style: Theme.of(context).textTheme.display1.copyWith(
  //           fontWeight: FontWeight.w700,
  //           fontSize: 15,
  //           color: Colors.white),
  //     ),
  //   );
  // }
  //
  // Widget landaFull(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 60),
  //     child: Column(
  //       children: <Widget>[
  //         SaldoKasLanda(),
  //         SalesOverdueLanda(),
  //         ProfitLossLanda(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget wajibBacaFull() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 60),
  //     child: Column(
  //       children: <Widget>[
  //         SaldoKasWajibBaca(),
  //         SalesOverdueWajibBaca(),
  //         ProfitLossWajibBaca(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget venturoFull(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 60),
  //     child: Column(
  //       children: <Widget>[
  //         SaldoKasVenturo(),
  //         SalesOverdueVenturo(),
  //         ProfitLossVenturo(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget propertyFull(){
  //   return Container(
  //     margin: EdgeInsets.only(top: 60),
  //     child: Column(
  //       children: <Widget>[
  //         SaldoKasProperty(),
  //         SalesOverdueProperty(),
  //         ProfitLossProperty(),
  //       ],
  //     ),
  //   );
  // }

}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
