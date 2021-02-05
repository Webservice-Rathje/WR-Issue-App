import 'dart:async';
import 'dart:io';
import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../classes/Http.dart';


class AddIssue extends StatefulWidget {
  _AddIssue createState() => _AddIssue();
}

class _AddIssue extends State<AddIssue> {
  var api = new APICommunication();
  File _image;
  List<Widget> display;
  final picker = ImagePicker();
  bool PictureTaken = false;
  final TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void checkGPS() async{
      var startup = new Startup();
      print(await startup.ping());
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: display,
        ),
      ),
    );
  }

  void InitDisplay() {
    if(_image == null){
      display = [
        new Container(
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Text("Issue melden!", style: TextStyle(
            fontSize: 35,
          ), textAlign: TextAlign.center, ),
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
    else{
      display = [
        new Container(
          margin: EdgeInsets.only(top: 10),
          child: Text("Issue melden!", style: TextStyle(
            fontSize: 35,
          ), ),
        ),
        new Container(child: Image.file(_image, height: 300,), margin: EdgeInsets.only(top: 15),),
        new RaisedButton(onPressed: () async {
          setState(() {
            _image = null;
          });
        }, child: Text("erneut aufnehmen"),),
        new Container(
          margin: EdgeInsets.only(top: 20),
          child: Text("Bitte geben sie ihre Daten an:", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Raleway",
              fontSize: 14
          ),),
        ),
        new Container(
          margin: EdgeInsets.only(top: 5),
          child: TextFormField(controller: TextController, maxLines: null, maxLength: 1024, decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nachricht"
          ),),
        ),
        new RaisedButton(onPressed: () async{
          Position pos = await Geolocator.getLastKnownPosition();
          print("test");
          File pic = _image;
          String lat = pos.latitude.toString();
          String long = pos.longitude.toString();
          String msg = TextController.text;
          await api.checkKey();
          await api.getToken();
          await api.sendInfo(lat, long, msg, pic);

        }, child: Text("Fehler melden", style: TextStyle(color: Colors.white),), color: Colors.pink,)
      ];
    }

  }

  void InitAfterTookImage() {
      setState(() {});
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