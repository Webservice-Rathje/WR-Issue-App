import 'package:app/classes/Http.dart';
import 'package:app/pages/addIssue.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  new Fetcher().checkConnection().then((value) => print(value));
  runApp(MaterialApp(
    title: "WR-Issue",
    home: Home(),
  ));
}
