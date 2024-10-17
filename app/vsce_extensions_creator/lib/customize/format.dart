import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../functional/functions.dart';
import '../functional/constants.dart';
import '../functional/classes.dart';
import 'dart:convert';

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

  List<String> categoriesList = [
    "languages",
    "themes",
    "snippets",
    "debuggers",
    "keymaps",
    "testing",
    "linters",
    "other",
  ];

  Categories categories = Categories();

  String currentVersion = '1.0.0';

  String currentDescription = '';

  String currentName = '';

  String publisher = '';

  String extensionFileName = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController extensionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var jsonData = json.decode(formatFile.readAsStringSync());

    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][extensionIndex];

    setState(() {
      keywords = jsonData['keywords'].cast<String>();
      types = jsonData['types'].cast<String>();
      currentName = extensionData['name'];
      currentDescription = extensionData['description'];
      currentVersion = extensionData['version'];
      publisher = extensionData['publisher'];
      extensionFileName = extensionData['extensionFileName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = isDark
        ? darkTheme.colorScheme
        : lightTheme.colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.surface,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height / 10.8,
                width: width / 3,
                decoration: BoxDecoration(
                    color: theme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: theme.onSurface,
                        width: 2,
                      ),
                    )),
                child: const Center(
                  child: Text(
                    'keywords',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < keywords.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height / 10.8,
                            width: width / 3 - width / 16,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                              ),
                            ),
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
                          Container(
                            width: width / 16,
                            height: height / 10.8,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              onPressed: () async {
                                keywords.removeAt(i);
                                Map<String, dynamic> data = {
                                  'keywords': keywords,
                                  'types': types,
                                  'name': currentName,
                                  'description': currentDescription,
                                  'version': currentVersion,
                                  'categories': getCategories(categories),
                                  'lastUpdated': DateTime.now().toString(),
                                };
                                String datas = jsonEncode(data);
                                await writeData(
                                        datas, storageAddress, 'format.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.highlight_remove_sharp,
                                  color: theme.onSurface),
                            ),
                          ),
                        ],
                      ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ((height - height / 7.5) -
                              height / 10.8 -
                              ((height / 10.8) * keywords.length) -
                              50)),
                      child: IconButton(
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
                                                        storageAddress,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: theme.onSurface,
            thickness: 2,
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height / 10.8,
                width: width / 3 - 4,
                decoration: BoxDecoration(
                    color: theme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: theme.onSurface,
                        width: 2,
                      ),
                    )),
                child: const Center(
                  child: Text(
                    'Types',
                    style: TextStyle(
                      fontSize: 25,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < types.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: height / 10.8,
                      width: width / 3 - 4 - width / 16,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border(
                          bottom: BorderSide(
                            color: theme.onSurface,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: theme.onSurface,
                            width: 1,
                          ),
                        ),
                      ),
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
                    Container(
                      width: width / 16,
                      height: height / 10.8,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border(
                          bottom: BorderSide(
                            color: theme.onSurface,
                            width: 1,
                          ),
                        ),
                      ),
                      child: IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async {
                          types.removeAt(i);
                          Map<String, dynamic> data = {
                            'keywords': keywords,
                            'types': types,
                          };
                          String datas = jsonEncode(data);
                          await writeData(datas, storageAddress, 'format.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.highlight_remove_sharp,
                            color: theme.onSurface),
                      ),
                    ),
                  ],
                ),
              Container(
                margin: EdgeInsets.only(
                    top: ((height - height / 7.5) -
                        height / 10.8 -
                        ((height / 10.8) * types.length) -
                        50)),
                child: IconButton(
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
                                          await writeData(datas, storageAddress,
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
              ),
            ],
          ),
          VerticalDivider(
            color: theme.onSurface,
            thickness: 2,
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height / 10.8,
                width: width / 3,
                decoration: BoxDecoration(
                    color: theme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: theme.onSurface,
                        width: 2,
                      ),
                    )),
                child: const Center(
                  child: Text(
                    'Extension Options',
                    style: TextStyle(
                      fontSize: 25,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Container(
                width: width / 3,
                height: height / 10.8,
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.onSurface,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '       Name: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.onSurface,
                      ),
                    ),
                    Container(
                      width: width * 0.12,
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: TextField(
                        controller: nameController..text = currentName,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Extension Name',
                        ),
                        onChanged: (value) async {
                          currentName = nameController.text;
                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                height: height / 10.8 * 2,
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.onSurface,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Description: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        )),
                    Container(
                      width: width * 0.12,
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: TextField(
                        controller: descriptionController
                          ..text = currentDescription,
                        // maxLengthEnforcement: MaxLengthEnforcement.none,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Extension Description',
                        ),
                        onChanged: (value) async {
                          currentDescription = descriptionController.text;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                height: height / 10.8,
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.onSurface,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('    Version: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        )),
                    Container(
                      width: width * 0.12,
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: TextField(
                        controller: versionController..text = currentVersion,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'e.g. 1.0.2',
                        ),
                        onChanged: (value) async {
                          currentVersion = versionController.text;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                height: height / 10.8,
                decoration: BoxDecoration(
                  color: theme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: theme.onSurface,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('  Extension: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        )),
                    Container(
                      width: width * 0.12,
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: TextField(
                        controller: extensionController
                          ..text = extensionFileName,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          hintText: 'e.g. dart',
                        ),
                        onChanged: (value) async {
                          extensionFileName = extensionController.text;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                margin: EdgeInsets.only(top: height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width / 9.6,
                      child: Text(
                        '   Categories: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.languages
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Programming Languages',
                            maxLines: 1,
                            style: TextStyle(
                              color: categories.languages
                                  ? theme.onPrimary
                                  : theme.onSurface,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          categories.languages = !categories.languages;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.themes
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Themes',
                          style: TextStyle(
                            color: categories.themes
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.themes = !categories.themes;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                margin: EdgeInsets.only(top: height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.snippets
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Snippets',
                          style: TextStyle(
                            color: categories.snippets
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.snippets = !categories.snippets;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.debuggers
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Debuggers',
                          style: TextStyle(
                            color: categories.debuggers
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories.debuggers = !categories.debuggers;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.keymaps
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Keymaps',
                          style: TextStyle(
                            color: categories.keymaps
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.keymaps = !categories.keymaps;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width / 3,
                margin: EdgeInsets.only(top: height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.testing
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Testing',
                          style: TextStyle(
                            color: categories.testing
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.testing = !categories.testing;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.linters
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Linters',
                          style: TextStyle(
                            color: categories.linters
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.linters = !categories.linters;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                    Container(
                      width: width / 9.6,
                      decoration: BoxDecoration(
                        color: theme.surface,
                        border: Border.all(
                          color: theme.onSurface,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              categories.other
                                  ? theme.onSurface
                                  : theme.primary),
                        ),
                        child: Text(
                          'Other',
                          style: TextStyle(
                            color: categories.other
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () async {
                          categories.other = !categories.other;

                          var extensionsData =
                              json.decode(extensionsFile.readAsStringSync());
                          Map<String, dynamic> data = {
                            'name': currentName,
                            'description': currentDescription,
                            'version': currentVersion,
                            'category': getCategories(categories),
                            'lastUpdated': DateTime.now().toString(),
                            'publisher': publisher,
                            'extensionFileName': extensionFileName,
                          };
                          extensionsData['extensions'][extensionIndex] = data;
                          String datas = jsonEncode(extensionsData);
                          await writeData(
                                  datas, storageAddress, 'extensions_list.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
