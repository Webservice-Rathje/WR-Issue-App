
import 'package:flutter/material.dart';

AppBar getAppBar() {
  return new AppBar(
    title: Text("WR-Issue",
      style: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),),
    centerTitle: true,
    backgroundColor: Colors.blueAccent,
  );
}