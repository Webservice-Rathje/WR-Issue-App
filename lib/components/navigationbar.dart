

import 'package:flutter/material.dart';

BottomNavigationBar getNavbar(int activeEntry) {
  return new BottomNavigationBar(
    currentIndex: activeEntry,
    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.stacked_bar_chart),
        title: new Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.add_box_rounded),
        title: new Text('Issue hinzufügen'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Einstellungen')
      )
    ],
  );
}