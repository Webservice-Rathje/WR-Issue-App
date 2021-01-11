
import 'package:flutter/material.dart';

AppBar getAppBar() {
  return new AppBar(
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      )
    ],
    title: Text("WR-Issue",
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),),
    centerTitle: true,
    backgroundColor: Colors.blueAccent,
  );
}