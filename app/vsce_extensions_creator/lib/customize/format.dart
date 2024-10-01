import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';

import '../functionals/functions.dart';
import '../functionals/constants.dart';
import 'dart:convert';
import 'dart:io';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key, required this.extensionIndex});

  final int extensionIndex;

  @override
  State<FormatPage> createState() => _FormatPageState(extensionIndex);
}

class _FormatPageState extends State<FormatPage> {
  _FormatPageState(this.extensionIndex);
  final _formKey = GlobalKey<FormState>();

  int extensionIndex;

  String currentKeyword = '';

  List<String> keywords = [];
  List<String> types = [];

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

  int selectedCategory = 0;

  String currentVersion = '1.0.0';

  String currentDescription = '';

  String currentName = '';

  String publisher = '';

  String extensionFileName = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController extensionController = TextEditingController();

  Color nameColor = Colors.green;
  Color descriptionColor = Colors.green;
  Color versionColor = Colors.green;
  final dir = Directory.current.path;

  @override
  void initState() {
    super.initState();
    File jsonFile = DEBUG
        ? File("$dir/lib/storage/format.json")
        : File("$dir/data/flutter_assets/lib/storage/format.json");
    var jsonData = json.decode(jsonFile.readAsStringSync());

    File extensionsFile = DEBUG
        ? File("$dir/lib/storage/extensions_list.json")
        : File("$dir/data/flutter_assets/lib/storage/extensions_list.json");
    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][extensionIndex];

    setState(() {
      keywords = jsonData['keywords'].cast<String>();
      types = jsonData['types'].cast<String>();
      currentName = extensionData['name'];
      currentDescription = extensionData['description'];
      currentVersion = extensionData['version'];
      selectedCategory = categories.indexOf(extensionData['category']);
      publisher = extensionData['publisher'];
      extensionFileName = extensionData['extensionFileName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Center(
                      child: Text(
                        'keywords:',
                        style: TextStyle(
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < keywords.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: keywords[i].length * 10.0,
                          child: TextField(
                            readOnly: true,
                            controller:
                                TextEditingController(text: keywords[i]),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            ),
                            onChanged: (value) {
                              keywords[i] = value;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            keywords.removeAt(i);
                            Map<String, dynamic> data = {
                              'keywords': keywords,
                              'types': types,
                              'name': currentName,
                              'description': currentDescription,
                              'version': currentVersion,
                              'category': categories[selectedCategory],
                              'lastUpdated': DateTime.now().toString(),
                            };
                            String datas = jsonEncode(data);
                            await writeData(
                                    datas,
                                    DEBUG
                                        ? '../vsce_extensions_creator/lib/storage'
                                        : '$dir/data/flutter_assets/lib/storage',
                                    'format.json')
                                .then((value) {
                              setState(() {});
                            });
                          },
                          icon: Icon(Icons.highlight_remove_sharp,
                              color: theme.onSurface),
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40,
                                top: -40,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('Add Keywords'),
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Keyword',
                                        ),
                                        onChanged: (value) =>
                                            currentKeyword = value,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          keywords.add(currentKeyword);
                                          if (currentKeyword.isNotEmpty) {
                                            Map<String, dynamic> data = {
                                              'keywords': keywords,
                                              'types': types,
                                            };
                                            String datas = jsonEncode(data);
                                            await writeData(
                                                    datas,
                                                    DEBUG
                                                        ? '../vsce_extensions_creator/lib/storage'
                                                        : '$dir/data/flutter_assets/lib/storage',
                                                    'format.json')
                                                .then((value) {
                                              setState(() {
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          }
                                        },
                                        child: const Text('Add'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.add, color: theme.onSurface),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Center(
                      child: Text(
                        'Types:',
                        style: TextStyle(
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < types.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: types[i].length * 10.0,
                          child: TextField(
                            readOnly: true,
                            controller: TextEditingController(text: types[i]),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            ),
                            onChanged: (value) {
                              types[i] = value;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            types.removeAt(i);
                            Map<String, dynamic> data = {
                              'keywords': keywords,
                              'types': types,
                            };
                            String datas = jsonEncode(data);
                            await writeData(
                                    datas,
                                    DEBUG
                                        ? '../vsce_extensions_creator/lib/storage'
                                        : '$dir/data/flutter_assets/lib/storage',
                                    'format.json')
                                .then((value) {
                              setState(() {});
                            });
                          },
                          icon: Icon(Icons.highlight_remove_sharp,
                              color: theme.onSurface),
                        ),
                      ],
                    ),
                  IconButton(
                    onPressed: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40,
                                top: -40,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('Add types'),
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Keyword',
                                        ),
                                        onChanged: (value) =>
                                            currentKeyword = value,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          types.add(currentKeyword);
                                          if (currentKeyword.isNotEmpty) {
                                            Map<String, dynamic> data = {
                                              'keywords': keywords,
                                              'types': types,
                                            };
                                            String datas = jsonEncode(data);
                                            await writeData(
                                                    datas,
                                                    DEBUG
                                                        ? '../vsce_extensions_creator/lib/storage'
                                                        : '$dir/data/flutter_assets/lib/storage',
                                                    'format.json')
                                                .then((value) {
                                              setState(() {
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          }
                                        },
                                        child: const Text('Add'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.add, color: theme.onSurface),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('       Name: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: TextField(
                            controller: nameController..text = currentName,
                            decoration: InputDecoration(
                              hintText: 'Enter Extension Name',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: nameColor),
                              ),
                            ),
                            onChanged: (value) async {
                              currentName = nameController.text;

                              String dir = Directory.current.path;
                              File extensionsFile = DEBUG
                                  ? File(
                                      "$dir/lib/storage/extensions_list.json")
                                  : File(
                                      "$dir/data/flutter_assets/lib/storage/extensions_list.json");
                              var extensionsData = json
                                  .decode(extensionsFile.readAsStringSync());
                              Map<String, dynamic> data = {
                                'name': currentName,
                                'description': currentDescription,
                                'version': currentVersion,
                                'category': categories[selectedCategory],
                                'lastUpdated': DateTime.now().toString(),
                                'publisher': publisher,
                                'extensionFileName': extensionFileName,
                              };
                              extensionsData['extensions'][extensionIndex] =
                                  data;
                              String datas = jsonEncode(extensionsData);
                              await writeData(
                                      datas,
                                      DEBUG
                                          ? '../vsce_extensions_creator/lib/storage'
                                          : '$dir/data/flutter_assets/lib/storage',
                                      'extensions_list.json')
                                  .then((value) {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Description: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: TextField(
                            controller: descriptionController
                              ..text = currentDescription,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: const InputDecoration(
                              hintText: 'Enter Extension Description',
                            ),
                            onChanged: (value) async {
                              currentDescription = descriptionController.text;

                              String dir = Directory.current.path;
                              File extensionsFile = DEBUG
                                  ? File(
                                      "$dir/lib/storage/extensions_list.json")
                                  : File(
                                      "$dir/data/flutter_assets/lib/storage/extensions_list.json");
                              var extensionsData = json
                                  .decode(extensionsFile.readAsStringSync());
                              Map<String, dynamic> data = {
                                'name': currentName,
                                'description': currentDescription,
                                'version': currentVersion,
                                'category': categories[selectedCategory],
                                'lastUpdated': DateTime.now().toString(),
                                'publisher': publisher,
                                'extensionFileName': extensionFileName,
                              };
                              extensionsData['extensions'][extensionIndex] =
                                  data;
                              String datas = jsonEncode(extensionsData);
                              await writeData(
                                      datas,
                                      DEBUG
                                          ? '../vsce_extensions_creator/lib/storage'
                                          : '$dir/data/flutter_assets/lib/storage',
                                      'extensions_list.json')
                                  .then((value) {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('    Version: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: TextField(
                            controller: versionController
                              ..text = currentVersion,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            decoration: const InputDecoration(
                              hintText: 'e.g. 1.0.2',
                            ),
                            onChanged: (value) async {
                              currentVersion = versionController.text;

                              String dir = Directory.current.path;
                              File extensionsFile = DEBUG
                                  ? File(
                                      "$dir/lib/storage/extensions_list.json")
                                  : File(
                                      "$dir/data/flutter_assets/lib/storage/extensions_list.json");
                              var extensionsData = json
                                  .decode(extensionsFile.readAsStringSync());
                              Map<String, dynamic> data = {
                                'name': currentName,
                                'description': currentDescription,
                                'version': currentVersion,
                                'category': categories[selectedCategory],
                                'lastUpdated': DateTime.now().toString(),
                                'publisher': publisher,
                                'extensionFileName': extensionFileName,
                              };
                              extensionsData['extensions'][extensionIndex] =
                                  data;
                              String datas = jsonEncode(extensionsData);
                              await writeData(
                                      datas,
                                      DEBUG
                                          ? '../vsce_extensions_creator/lib/storage'
                                          : '$dir/data/flutter_assets/lib/storage',
                                      'extensions_list.json')
                                  .then((value) {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('  Extension: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.onSurface,
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: TextField(
                            controller: extensionController
                              ..text = extensionFileName,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            decoration: const InputDecoration(
                              hintText: 'e.g. dart',
                            ),
                            onChanged: (value) async {
                              extensionFileName = extensionController.text;

                              String dir = Directory.current.path;
                              File extensionsFile = DEBUG
                                  ? File(
                                      "$dir/lib/storage/extensions_list.json")
                                  : File(
                                      "$dir/data/flutter_assets/lib/storage/extensions_list.json");
                              var extensionsData = json
                                  .decode(extensionsFile.readAsStringSync());
                              Map<String, dynamic> data = {
                                'name': currentName,
                                'description': currentDescription,
                                'version': currentVersion,
                                'category': categories[selectedCategory],
                                'lastUpdated': DateTime.now().toString(),
                                'publisher': publisher,
                                'extensionFileName': extensionFileName,
                              };
                              extensionsData['extensions'][extensionIndex] =
                                  data;
                              String datas = jsonEncode(extensionsData);
                              await writeData(
                                      datas,
                                      DEBUG
                                          ? '../vsce_extensions_creator/lib/storage'
                                          : '$dir/data/flutter_assets/lib/storage',
                                      'extensions_list.json')
                                  .then((value) {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('   Category: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.onSurface,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        child: DropdownButton<String>(
                          value: categories[selectedCategory],
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) async {
                            selectedCategory = categories.indexOf(newValue!);

                            String dir = Directory.current.path;
                            File extensionsFile = DEBUG
                                ? File(
                                    "$dir/data/flutter_assets/lib/storage/extensions_list.json")
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
                              'publisher': publisher,
                              'extensionFileName': extensionFileName,
                            };
                            extensionsData['extensions'][extensionIndex] = data;
                            String datas = jsonEncode(extensionsData);
                            await writeData(
                                    datas,
                                    DEBUG
                                        ? '../vsce_extensions_creator/lib/storage'
                                        : '$dir/data/flutter_assets/lib/storage',
                                    'extensions_list.json')
                                .then((value) {
                              setState(() {});
                            });
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
