
import 'package:flutter/material.dart';

AppBar getAppBar(BuildContext context) {
  return new AppBar(
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () { print("Opening settings menu"); },
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