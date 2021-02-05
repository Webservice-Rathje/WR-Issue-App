import 'package:app/classes/Http.dart';
import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  @override
  void initState() {
    var fetcher = new APICommunication();
    fetcher.checkKey().then((value) => null);
    print("Checked key");
    fetcher.getToken().then((value) => null);
    print("checked token");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: getAppBar(context),
      bottomNavigationBar: CustomBottonNavbar().getNavbar(0, context),
    );
  }
}