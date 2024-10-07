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

  String settingsPath = '';

  @override
  void initState() {
    super.initState();

    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][extensionIndex];

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: surfaceCol,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 8,
                width: width / 2.25,
                child: TextField(
                  controller: TextEditingController(text: publisherName),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: onSurfaceCol, width: 2),
                    ),
                    labelText: 'Publisher Name',
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (text) async {
                    publisherName = text;

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
                      storageAddress,
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
                height: height / 8,
                width: width / 4.8,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: surfaceCol,
                  border: Border.all(color: onSurfaceCol, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(surfaceCol),
                    overlayColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () async {
                    String? result =
                        await FilePicker.platform.getDirectoryPath();

                    if (result != null) {
                      Map<String, dynamic> dataRaw = {
                        "outputDirectory": result,
                      };
                      var data = jsonEncode(dataRaw);
                      writeData(
                        data,
                        storageAddress,
                        'settings.json',
                      ).then((value) {});
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Text(
                    "Select Output Directory",
                    style: TextStyle(
                        color: onSurfaceCol, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: height / 8,
                width: width / 4.8,
                margin: const EdgeInsets.only(top: 50, left: 10),
                decoration: BoxDecoration(
                  color: surfaceCol,
                  border: Border.all(color: onSurfaceCol, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(surfaceCol),
                    overlayColor:
                        WidgetStateProperty.all<Color>(Colors.transparent),
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
                  child: Text(
                    "Go To Output Directory",
                    style: TextStyle(
                        color: onSurfaceCol, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: height / 8,
            width: width / 2.25,
            margin: const EdgeInsets.only(top: 50, left: 10),
            decoration: BoxDecoration(
              color: surfaceCol,
              border: Border.all(color: onSurfaceCol, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(surfaceCol),
                overlayColor:
                    WidgetStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: () async {},
              child: Text(
                "Set Current Parameters As Template",
                style:
                    TextStyle(color: onSurfaceCol, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 8),
            child: Transform.scale(
              scale: 1.5,
              child: Switch(
                value: isDark,
                onChanged: (bool newValue) {
                  setState(() {
                    isDark = newValue;
                    surfaceCol = isDark
                        ? const Color(0xFF332E3C)
                        : const Color(0xFFEDF6F9);
                    primaryCol = isDark
                        ? const Color(0xff1F1F1F)
                        : const Color(0xffefefef);
                    secondaryCol = isDark
                        ? const Color(0xff434343)
                        : const Color(0xffcccccc);
                    onSurfaceCol = isDark
                        ? const Color(0xFFD8D6F2)
                        : const Color(0xFF006d77);
                    onPrimaryCol = isDark
                        ? const Color(0xffFFFFFF)
                        : const Color(0xff000000);
                    onSecondaryCol = isDark
                        ? const Color(0xffFFFFFF)
                        : const Color(0xff000000);
                  });
                },
                thumbColor: WidgetStateProperty.all<Color>(primaryCol),
                inactiveThumbColor: primaryCol,
                activeTrackColor: onSurfaceCol,
                inactiveTrackColor: onSurfaceCol,
                trackOutlineColor: WidgetStateProperty.all<Color>(onSurfaceCol),
                thumbIcon: WidgetStateProperty.all<Icon?>(
                  Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny,
                    color: onSurfaceCol,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
