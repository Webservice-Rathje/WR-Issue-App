import 'dart:convert';
import 'dart:io';
import '../classes/FileUtils.dart';
import 'package:http/http.dart' as http;


class Fetcher {
  String baseURL = "https://api.wr-issue.de/beta";

  Future<void> generateKey() async {
      String url = baseURL + "/v1/mobile/generateKey";
      print(url);
      var response = await http.get("https://github.com/MathisBurger/fussball_trainer_managing_app/blob/master/lib/AddingViaActionButton.dart");
      print("after async");
      print("Key: " + response.body);
      //Map<String, dynamic> json = jsonDecode(response.toString());
  }

  Future<bool> checkInternetPerm() async {

  }

  Future<bool> checkConnection() async {
    print("AAACTIVE");
    try {
      final result = await InternetAddress.lookup('google.com');
      print("Älter und fetter");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("yee buster");
        return true;
      }
    } on SocketException catch (err) {
      print(err);
      print("fat fat");
      return false;
    }
  }
}
class APICommunication {
  String baseUrl = "https://api.wr-issue.de/beta/";
  String APIVersion = "v1/";
  var file = new FileUtils();
  checkKey() async{
    String data = await file.read().toString();
    if(!data.contains("key")){
      String url = baseUrl + APIVersion + "mobile/generateKey";
      try {
        var resp = await http.get(url);
        String ans = resp.body;
        var ansDecode = jsonDecode(ans);
        data = '{"key": "' + ansDecode["key"] + '"}';
        file.write(data);
        return "key added";
      }
      catch(e){
        print(e);
      }
    }
    else{
      return "key already set";
    }
  }
  getToken() async{
    var data = await file.read();
    if(!data.toString().contains("token")){
      var dataDecode = jsonDecode(data);
      String key = dataDecode["key"];
      String url = baseUrl + APIVersion + "mobile/getToken";
      try{
        var resp = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'key': key,
            })
        );
        var ans = resp.body;
        print(ans);
        var ansDecode = jsonDecode(ans);
        var to_save = {
          'key': key,
          'token': ansDecode['token'],
        };
        var encode_to_save = jsonEncode(to_save);
        file.write(encode_to_save);
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("token already set");
    }
  }
  delToken() async{
    var data = await file.read();
    var dataDecode = jsonDecode(data);
    String key = dataDecode["key"];
    String token = dataDecode["token"];
    try{
      String url = baseUrl + APIVersion + "mobile/deleteToken";
      var resp = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'key': key,
            'token': token
          })
      );
      print(resp.body);
      data = '{"key": "' + key + '"}';
      file.write(data);
    }
    catch(e){
      print(e);
    }
  }
}