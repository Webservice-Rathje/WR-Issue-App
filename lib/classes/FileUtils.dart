import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
class FileUtils{
  Future<String> get _localPath async {
    try {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } catch (e){
      print(e);
    }
    return null;
  }
  Future<File> get _localFile async {
    try {
      final path = await _localPath;
      if (!File('$path/data.json').existsSync()) {
        await File('$path/data.json').create(recursive: true);
      }
      return File('$path/data.json');
    } catch (e){
      print(e);
    }
    return null;
  }
  Future read() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print(e);
    }
  }
  Future write(data) async {
    final file = await _localFile;
    file.writeAsString(data);
  }
  Future checkJSON(data) async{
    try{
      jsonDecode(data);
      return true;
    }
    catch(e){
      return false;
    }
  }
}