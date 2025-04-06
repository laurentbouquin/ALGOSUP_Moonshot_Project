// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar_view.dart';
import 'package:vsce_extensions_creator/src/features/format/format_widgets.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'dart:convert';

// ==== Pages Imports ==== //
import '../../constants/functions.dart';
import '../../constants/variables.dart';
import '../../constants/links.dart';
import '../../constants/classes.dart';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key});

  static const String routeName = '/formatPage';

  @override
  State<FormatPage> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
  _FormatPageState();
  final _formKey = GlobalKey<FormState>();


  String currentKeyword = '';

  List<String> keywords = [];
  List<String> types = [];

  Categories categories = Categories();

  String currentVersion = '1.0.0';

  String currentDescription = '';

  String currentName = '';

  String publisher = '';

  String extensionFileName = '';

  WindowSize windowSize = WindowSize();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController extensionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var formatsData = json.decode(formatFile.readAsStringSync());
    var formatData = formatsData['extensions'][currentExtensionIndex];

    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][currentExtensionIndex];

    setState(() {
      keywords = formatData['keywords'].cast<String>();
      types = formatData['types'].cast<String>();
      currentName = extensionData['name'];
      currentDescription = extensionData['description'];
      currentVersion = extensionData['version'];
      categories = setCategories(extensionData['categories'].cast<String>());
      publisher = extensionData['publisher'];
      extensionFileName = extensionData['extensionFileName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: windowSize.height / 10.8,
                width: windowSize.width / 3.5,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: scheme.onSurface,
                      width: 2,
                    ),
                  ),
                ),
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
                    ...List.generate(
                      keywords.length,
                      (i) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: windowSize.height / 10.8,
                            width:
                                windowSize.width / 3.5 - windowSize.width / 16,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              border: Border(
                                bottom: BorderSide(
                                  color: scheme.onSurface,
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: scheme.onSurface,
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
                                color: scheme.onSurface,
                              ),
                              onChanged: (value) {
                                keywords[i] = value;
                              },
                            ),
                          ),
                          Container(
                            width: windowSize.width / 16,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              border: Border(
                                bottom: BorderSide(
                                  color: scheme.onSurface,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: IconButton(
                              hoverColor: Colors.transparent,
                              onPressed: () async {
                                keywords.removeAt(i);
                                updateData("format", currentExtensionIndex,
                                        keywords: keywords)
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.highlight_remove_sharp,
                                  color: scheme.onSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ((windowSize.height - windowSize.height / 7.5) -
                            windowSize.height / 10.8 -
                            ((windowSize.height / 10.8) * keywords.length) -
                            50),
                      ),
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
                                                updateData("format",
                                                        currentExtensionIndex,
                                                        keywords: keywords)
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
                        icon: Icon(Icons.add, color: scheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: scheme.onSurface,
            thickness: 2,
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: windowSize.height / 10.8,
                width: windowSize.width / 3.5 - 4,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: scheme.onSurface,
                      width: 2,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Types',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              ...List.generate(
                types.length,
                (j) => // Start of the j loop
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: windowSize.height / 10.8,
                      width: windowSize.width / 3.5 - 4 - windowSize.width / 16,
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        border: Border(
                          bottom: BorderSide(
                            color: scheme.onSurface,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: scheme.onSurface,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: types[j]),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: scheme.onSurface,
                        ),
                        onChanged: (value) {
                          types[j] = value;
                        },
                      ),
                    ),
                    Container(
                      width: windowSize.width / 16,
                      height: windowSize.height / 10.8,
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        border: Border(
                          bottom: BorderSide(
                            color: scheme.onSurface,
                            width: 1,
                          ),
                        ),
                      ),
                      child: IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async {
                          types.removeAt(j);
                          updateData("format", currentExtensionIndex, types: types)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.highlight_remove_sharp,
                            color: scheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ((windowSize.height - windowSize.height / 7.5) -
                      windowSize.height / 10.8 -
                      ((windowSize.height / 10.8) * types.length) -
                      50),
                ),
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
                                          updateData("format", currentExtensionIndex,
                                                  types: types)
                                              .then(
                                            (value) {
                                              setState(() {
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
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
                  icon: Icon(Icons.add, color: scheme.onSurface),
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: scheme.onSurface,
            thickness: 2,
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: windowSize.height / 10.8,
                width: windowSize.width / 3.5,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: scheme.onSurface,
                      width: 2,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Extension Options',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              extensionOptionsPart(
                windowSize,
                scheme,
                currentExtensionIndex,
                'Name:',
                'Enter Extension Name',
                windowSize.width / 3.5,
                windowSize.height / 10.8,
              ),
              extensionOptionsPart(
                windowSize,
                scheme,
                currentExtensionIndex,
                'Description:',
                'Enter Extensions Description',
                windowSize.width / 3.5,
                windowSize.height / 10.8,
              ),
              extensionOptionsPart(
                windowSize,
                scheme,
                currentExtensionIndex,
                'Version:',
                'e.g. 1.0.2',
                windowSize.width / 3.5,
                windowSize.height / 10.8,
              ),
              extensionOptionsPart(
                windowSize,
                scheme,
                currentExtensionIndex,
                'Extension:',
                'e.g. dart, txt',
                windowSize.width / 3.5,
                windowSize.height / 10.8,
              ),
              Container(
                width: windowSize.width / 3.5,
                margin: EdgeInsets.only(top: windowSize.height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: windowSize.width / 13,
                      child: Text(
                        '   Categories: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Programming Languages", this),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Themes", this),
                  ],
                ),
              ),
              Container(
                width: windowSize.width / 3.5,
                margin: EdgeInsets.only(top: windowSize.height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Snippets", this),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Debuggers", this),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Keymaps", this),
                  ],
                ),
              ),
              Container(
                width: windowSize.width / 3.5,
                margin: EdgeInsets.only(top: windowSize.height / 108),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Testing", this),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Linters", this),
                    categoriesButton(windowSize, scheme, currentExtensionIndex,
                        categories, "Other", this),
                  ],
                ),
              ),
            ],
          ),
          NavBar()
        ],
      ),
    );
  }
}
