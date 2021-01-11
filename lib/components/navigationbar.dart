

import 'package:app/pages/addIssue.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

class CustomBottonNavbar {

  BuildContext ctx;

  void onTabClicked(int index) {
    BuildContext context = this.ctx;
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Home(),
            transitionDuration: Duration(seconds: 0)

        ));
        break;
      case 1:
        Navigator.pushReplacement(context, PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => AddIssue(),
            transitionDuration: Duration(seconds: 0)

        ));
        break;
    }
  }

  BottomNavigationBar getNavbar(int activeEntry, BuildContext ctx) {
    this.ctx = ctx;
    return new BottomNavigationBar(
      currentIndex: activeEntry,
      onTap: onTabClicked,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.add_box_rounded),
          title: new Text('Issue hinzufügen'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Verlauf')
        )
      ],
    );
  }
}