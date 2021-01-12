import 'dart:io';
import 'package:app/components/appbar.dart';
import 'package:app/components/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import '../classes/FileUtils.dart';

class AddIssue extends StatefulWidget {
  _AddIssue createState() => _AddIssue();
}

class _AddIssue extends State<AddIssue> {
  File _image;
  final picker = ImagePicker();
  var file = new FileUtils();
  @override
  Widget build(BuildContext context) {
    void checkGPS() async{
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        await Geolocator.requestPermission();
      }
    }
    checkGPS();
    return new Scaffold(
      appBar: getAppBar(context),
      bottomNavigationBar: CustomBottonNavbar().getNavbar(1, context),
      body: Center(
        child: Column(
          children: [
            new Text("Issue melden!"),
            new Text("Bitte wählen sie eine Quelle aus."),
            new FlatButton(onPressed: shotImage, child: Text("Kamera"))
          ],
        ),
      ),
    );
  }

  Future shotImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  StreamSubscription<Position> positionStream = Geolocator.getPositionStream().listen((Position position) {});
}