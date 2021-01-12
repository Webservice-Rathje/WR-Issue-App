import 'dart:convert';
import 'dart:io';
import '../classes/FileUtils.dart';
import 'package:http/http.dart' as http;


class APICommunication {
  String baseUrl = "https://api.wr-issue.de/beta/";
  String APIVersion = "v1/";
  var file = new FileUtils();
  checkKey() async{
    var data = await file.read();
    if(await file.checkJSON(data) == true){
      var dataDecode = jsonDecode(data);
      if(dataDecode["key"] == null){
        String url = baseUrl + APIVersion + "mobile/generateKey";
        try {
          var resp = await http.get(url);
          String ans = resp.body;
          var ansDecode = jsonDecode(ans);
          var toWrite = {
            "key": ansDecode["key"],
            "token": null
          };
          file.write(jsonEncode(toWrite));
          print("key added");
        }
        catch(e){
          print(e);
        }
      }
      else{
        print("key already set");
      }
    }
    else{
      String url = baseUrl + APIVersion + "mobile/generateKey";
      try {
        var resp = await http.get(url);
        String ans = resp.body;
        var ansDecode = jsonDecode(ans);
        var toWrite = {
          "key": ansDecode["key"],
          "token": null
        };
        file.write(jsonEncode(toWrite));
        print("key added");
      }
      catch(e){
        print(e);
      }
    }
  }
  getToken() async{
    var data = await file.read();
    if(await file.checkJSON(data) == true){
      var dataDecode = jsonDecode(data);
      if(dataDecode["token"] == false){
        delToken();
      }
      String url = baseUrl + APIVersion + "mobile/getToken";
      try{
        var resp = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'key': dataDecode["key"],
            })
        );
        var ans = resp.body;
        var ansDecode = jsonDecode(ans);
        print(ansDecode['token']);
        var to_save = {
          'key': dataDecode["key"],
          'token': ansDecode['token'],
        };
        var encode_to_save = jsonEncode(to_save);
        file.write(encode_to_save);
        print("token set");
      }
      catch(e){
        print("e");
      }
    }
    else{
      print("!!!ERROR!!!");
    }
  }
  delToken() async{
    var data = await file.read();
    var dataDecode = jsonDecode(data);
    String url = baseUrl + APIVersion + "mobile/deleteToken";
    try{
      var resp = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'key': dataDecode["key"],
            'token': dataDecode["token"]
          })
      );
      print(resp.body);
      var to_save = {
        "key": dataDecode["key"],
        "token": null
      };
      file.write(jsonEncode(to_save));
      print("token deleted");
    }
    catch(e){
      print(e);
    }
  }
  sendinfo(lat, long, text) async{
    var data = await file.read();
    if(await file.checkJSON(data) == true){
      var dataDecode = jsonDecode(data);
      String url = baseUrl + APIVersion + "mobile/sendInformation";
      var body = {
        'key': dataDecode["key"],
        'token': dataDecode["token"],
        'information': {
          'lat': lat,
          'long': long,
          'text': text,
        }
      };
      try {
        var resp = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(body)
        );
        var ans = resp.body;
        var ansDecode = jsonDecode(ans);
        print(ansDecode["image_handshake"]);
      }
      catch(e){
        print(e);
      }
    }
    else{
      return("!!!ERROR!!!");
    }
  }
  imageUpload(handshake) async{

  }
}