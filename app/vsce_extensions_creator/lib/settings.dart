import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';

import 'functionals/functions.dart';
import 'functionals/constants.dart';

import 'package:file_picker/file_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.extensionIndex});

  final int extensionIndex;

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState(extensionIndex: extensionIndex);
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState({required this.extensionIndex});

  int extensionIndex;

  String currentName = '';
  String currentDescription = '';
  String currentVersion = '';
  int selectedCategory = 0;
  String publisherName = '';
  String extensionFileName = '';

  List<String> categories = [
    "Programming Languages",
    "Themes",
    // "Snippets",
    // "Linters",
    // "Debuggers",
    // "Formatters",
    // "Keymaps",
    // "SCM Providers",
    // "Other",
    // "Extension Packs",
    // "Language Packs",
    // "Data Science",
    // "Machine Learning",
    // "Visualization",
    // "Notebooks",
    // "Education",
    // "Testing"
  ];
  final dir = Directory.current.path;

  String settingsPath = '';

  @override
  void initState() {
    super.initState();

    File extensionsFile = DEBUG
        ? File("$dir/lib/storage/extensions_list.json")
        : File("$dir/data/flutter_assets/lib/storage/extensions_list.json");
    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][extensionIndex];

    File settingsFile = DEBUG
        ? File("$dir/lib/storage/settings.json")
        : File("$dir/data/flutter_assets/lib/storage/settings.json");
    var settingsData = json.decode(settingsFile.readAsStringSync());

    setState(() {
      currentName = extensionData['name'];
      currentDescription = extensionData['description'];
      currentVersion = extensionData['version'];
      selectedCategory = categories.indexOf(extensionData['category']);
      publisherName = extensionData['publisher'];
      extensionFileName = extensionData['extensionFileName'];

      settingsPath = settingsData['outputDirectory'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: TextEditingController(text: publisherName),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Publisher Name',
                ),
                onChanged: (text) async {
                  publisherName = text;

                  String dir = Directory.current.path;
                  File extensionsFile = DEBUG
                      ? File("$dir/lib/storage/extensions_list.json")
                      : File(
                          "$dir/data/flutter_assets/lib/storage/extensions_list.json");
                  var extensionsData =
                      json.decode(extensionsFile.readAsStringSync());
                  Map<String, dynamic> data = {
                    'name': currentName,
                    'description': currentDescription,
                    'version': currentVersion,
                    'category': categories[selectedCategory],
                    'lastUpdated': DateTime.now().toString(),
                    'publisher': publisherName,
                    'extensionFileName': extensionFileName,
                  };
                  extensionsData['extensions'][extensionIndex] = data;
                  String datas = jsonEncode(extensionsData);
                  await writeData(
                    datas,
                    DEBUG
                        ? '../vsce_extensions_creator/lib/storage'
                        : '$dir/data/flutter_assets/lib/storage',
                    'extensions_list.json',
                  ).then((value) {});
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade300),
                ),
                onPressed: () async {
                  String? result = await FilePicker.platform.getDirectoryPath();

                  if (result != null) {
                    Map<String, dynamic> dataRaw = {
                      "outputDirectory": result,
                    };
                    var data = jsonEncode(dataRaw);
                    writeData(
                      data,
                      DEBUG
                          ? '../vsce_extensions_creator/lib/storage'
                          : '$dir/data/flutter_assets/lib/storage',
                      'settings.json',
                    ).then((value) {});
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Text(
                  "Select Output Directory",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.grey.shade300),
                ),
                onPressed: () async {
                  if (settingsPath != '') {
                    if (Platform.isWindows) {
                      await Process.run('explorer', [settingsPath]);
                    } else if (Platform.isMacOS) {
                      await Process.run('open', [settingsPath]);
                    } else if (Platform.isLinux) {
                      await Process.run('xdg-open', [settingsPath]);
                    }
                  }
                },
                child: const Text(
                  "Go To Output Directory",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
