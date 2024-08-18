import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

Future<File> writeData(data, String path, String fileName) async {
  final file = File('$path/$fileName');
  if(file.existsSync()) {
  }
  else {
    await file.create(recursive: true);
  }

  // Write the file
  return file.writeAsString(data);
}