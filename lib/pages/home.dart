import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: getNavbar(0),
    );
  }
  
}