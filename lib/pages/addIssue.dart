import 'dart:async';
import 'dart:io';
import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


class AddIssue extends StatefulWidget {
  _AddIssue createState() => _AddIssue();
}

class _AddIssue extends State<AddIssue> {
  File _image;
  List<Widget> display;
  final picker = ImagePicker();
  bool PictureTaken = false;

  @override
  Widget build(BuildContext context) {
    void checkGPS() async{
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
      }
    }
    checkGPS();
    if (!PictureTaken) {
      InitDisplay();
    }
    return new Scaffold(
      appBar: getAppBar(context),
      bottomNavigationBar: CustomBottonNavbar().getNavbar(1, context),
      body: Center(
        child: Column(
          children: display,
        ),
      ),
    );
  }

  void InitDisplay() {
    display = [
      new Container(
        margin: EdgeInsets.only(top: 10),
        child: Text("Issue melden!", style: TextStyle(
          fontSize: 35,
        ), ),
      ),
      new Container(
        margin: EdgeInsets.only(top: 20),
        child: Text("Bitte wählen sie eine Quelle aus:", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Raleway",
            fontSize: 14
        ),),
      ),
      new RaisedButton(onPressed: shotImage, child: Text("Kamera", style: TextStyle(
          fontSize: 15
      ),),
        padding: EdgeInsets.only(right: 100, left: 100, top: 10, bottom: 10),),
      new RaisedButton(onPressed: selectFromLibary, child: Text("Galerie", style: TextStyle(
          fontSize: 15
      ),),
        padding: EdgeInsets.only(right: 100, left: 100, top: 10, bottom: 10),),
    ];
  }

  void InitAfterTookImage() {
    print("Irgendwas läuft schief mein Freund");
      setState(() {
        display = [
          new Text("nen random text")
        ];
      });
  }

  Future shotImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      InitAfterTookImage();
    });
  }

  Future selectFromLibary() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      InitAfterTookImage();
    });
  }
  StreamSubscription<Position> positionStream = Geolocator.getPositionStream().listen((Position position) {});
}