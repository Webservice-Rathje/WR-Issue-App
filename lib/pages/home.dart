import 'dart:async';
import 'dart:io';

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
    super.initState();
    Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          } else {
            _showDialog(); // show dialog
          }
        }).catchError((error) {
          _showDialog(); // show dialog
        });
      } on SocketException catch (_) {
        _showDialog();
        print('not connected'); // show dialog
      }
    });
  }

  void _showDialog() {
    // dialog implementation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Internet needed!"),
        content: Text("You may want to exit the app here"),
        actions: <Widget>[FlatButton(child: Text("EXIT"), onPressed: () {})],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    init().then((value) => null);
    return new Scaffold(
      appBar: getAppBar(context),
      bottomNavigationBar: CustomBottonNavbar().getNavbar(0, context),
    );
  }

  Future<void> init() async {
    var fetcher = new Fetcher();
    await fetcher.generateKey();
  }
  
}