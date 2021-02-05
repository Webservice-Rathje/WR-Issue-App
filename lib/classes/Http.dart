import 'dart:convert';
import 'dart:io';
import '../classes/FileUtils.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;


class APICommunication {
  String baseUrl = "https://api.wr-issue.de/beta/";
  String APIVersion = "v1/";
  var file = new FileUtils();

  APICommunication() {}

  Future<void> checkKey() async {
    print("checking key...");
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

  Future<void> getToken() async {
    print("checking token...");
    var data = await file.read();
    if(await file.checkJSON(data) == true){
      var dataDecode = jsonDecode(data);
      await delToken();
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
    } else{
      print("!!!ERROR!!!");
    }
  }

  Future<void> delToken() async{
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

  Future<void> sendInfo(String lat,String long,String text, File pic) async{
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
        print(resp.body);
        var ansDecode = jsonDecode(ans);
        print(ansDecode["image_handshake"]);
        print("fertig");
        await imageUpload(ansDecode["image_handshake"], pic);
      }
      catch(e){
        print(e);
      }
    }
    else{
      return("!!!ERROR!!!");
    }
  }

  Future<void> imageUpload(String handshake, File pic) async{
    print(pic.path);
    dio.FormData data = dio.FormData.fromMap({
      "document": await dio.MultipartFile.fromFile(
        pic.path,
      ),
    });
    dio.Dio req = new dio.Dio();
    String url = baseUrl + APIVersion + "mobile/uploadImage/" + handshake;
    req.post(url, data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }
}
class Startup {
  ping() async{
    try{
      var google = await http.get("https://google.de");
      var api = await http.get("https://api.wr-issue.de");
      if(api.statusCode.toString() == "200" && google.statusCode.toString() == "200"){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      return false;
    }
  }
}