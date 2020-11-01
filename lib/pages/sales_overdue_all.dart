import 'package:flutter/material.dart';

class SalesOverDueAll extends StatefulWidget {
  @override
  SalesOverDueAllState createState() => SalesOverDueAllState();


}

class SalesOverDueAllState extends State<SalesOverDueAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Overdue Data"),
          backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Text("Data Sales Overdue"),
      ),
    );
  }

}