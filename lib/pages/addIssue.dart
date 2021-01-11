
import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';

class AddIssue extends StatefulWidget {
  _AddIssue createState() => _AddIssue();
}

class _AddIssue extends State<AddIssue> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: getAppBar(),
      bottomNavigationBar: CustomBottonNavbar().getNavbar(1, context),
      body: Text("Sieg heil mein Freund"),
    );
  }

}