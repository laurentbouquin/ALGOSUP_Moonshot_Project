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
  if (file.existsSync()) {
  } else {
    await file.create(recursive: true);
  }

  // Write the file
  return file.writeAsString(data);
}

Future<void> createBaseFilesContent(String path) async {
  List<String> files = [
    "commentsandstrings",
    "extensions_list",
    "format",
    "settings",
    "theming"
  ];

  final dir = Directory.current.path;
  final storagePath = "$dir/data/flutter_assets/lib/storage";
  for (int i = 0; i < files.length; i++) {
    File file = File("$storagePath/${files[i]}.json");
    if (!file.existsSync()) {
      file.createSync();
    }
  }
  File extensionsFile = File("$dir/data/flutter_assets/lib/storage/extensions_list.json");
  File commentsAndStringsFile =
      File("$dir/data/flutter_assets/lib/storage/commentsandstrings.json");
  File formatFile = File("$dir/data/flutter_assets/lib/storage/format.json");
  File settingsFile = File("$dir/data/flutter_assets/lib/storage/settings.json");
  File themingFile = File("$dir/data/flutter_assets/lib/storage/theming.json");

  extensionsFile.writeAsStringSync(
      '{"extensions":[{"name":"Template","description":"This extension is a simple template","version":"1.0.0","category":"Programming Languages","lastUpdated":"2024-08-27 13:12:09.776771","publisher":"temp","extensionFileName":"tmp"}]}');
  commentsAndStringsFile.writeAsStringSync('{"slc":0,"mlc":0,"quotes":2}');
  formatFile.writeAsStringSync(
      '{"keywords":["if","else"],"types":["int","string"]}');
  settingsFile.writeAsStringSync('{"outputDirectory":""}');
  themingFile.writeAsStringSync(
      '{"bgColor":1,"keywordColor":3,"functionColor":2,"variableColor":4,"stringColor":5,"commentColor":5,"commonColor":0}');
}
