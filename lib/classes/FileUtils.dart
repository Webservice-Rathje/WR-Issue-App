import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileUtils {
  String filename;
  String root;
  File file;

  Future<void> init(name) async {
    filename = name;
    final directory = await getApplicationDocumentsDirectory();
    root = directory.path;
    if (! await this.exists()){
      this.createFile();
    }
    file = File(root + filename);
  }

  Future<bool> exists() async {
    return await File(root + filename).exists();
  }

  Future<void> createFile() async {
    await File(root + filename).create(recursive: true);
  }

  Future<String> getContent() async {
    return await file.readAsString(encoding: utf8);
  }

  Future<void> writeData(data) async {
    await file.writeAsString(data, encoding: utf8, mode: FileMode.write);
  }

  Future<void> appendData(data) async {
    await file.writeAsString(data, encoding: utf8, mode: FileMode.append);
  }


}