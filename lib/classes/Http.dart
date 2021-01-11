import 'dart:convert';
import 'dart:io';

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