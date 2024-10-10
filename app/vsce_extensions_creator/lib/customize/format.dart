import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';

import '../functionals/functions.dart';
import '../functionals/constants.dart';
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

  List<bool> categories = [
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false
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
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
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
                                  'category': categories[selectedCategory],
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
                    Text('       Name: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        )),
                    Container(
                      width: width * 0.12,
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: TextField(
                        controller: nameController..text = currentName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Extension Name',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: nameColor),
                          ),
                        ),
                        onChanged: (value) async {
                          currentName = nameController.text;
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
                            'category': categories[selectedCategory],
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
                            'category': categories[selectedCategory],
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
                            'category': categories[selectedCategory],
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
                              categories[0] ? theme.onSurface : theme.primary),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Programming Languages',
                            maxLines: 1,
                            style: TextStyle(
                              color: categories[0]
                                  ? theme.onPrimary
                                  : theme.onSurface,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[0] = !categories[0];
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
                              categories[1] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Themes',
                          style: TextStyle(
                            color: categories[1]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[1] = !categories[1];
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
                              categories[2] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Snippets',
                          style: TextStyle(
                            color: categories[2]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[2] = !categories[2];
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
                              categories[3] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Debuggers',
                          style: TextStyle(
                            color: categories[3]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[3] = !categories[3];
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
                              categories[4] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Keymaps',
                          style: TextStyle(
                            color: categories[4]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[4] = !categories[4];
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
                              categories[5] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Testing',
                          style: TextStyle(
                            color: categories[5]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[5] = !categories[5];
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
                              categories[6] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Linters',
                          style: TextStyle(
                            color: categories[6]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[6] = !categories[6];
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
                              categories[7] ? theme.onSurface : theme.primary),
                        ),
                        child: Text(
                          'Other',
                          style: TextStyle(
                            color: categories[7]
                                ? theme.onPrimary
                                : theme.onSurface,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            categories[7] = !categories[7];
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
