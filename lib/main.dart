import 'package:flutter/material.dart';
import 'package:wajib_baca/pages/dashboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Venturo Board',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardPage(),

    );
  }
}

