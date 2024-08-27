import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import '../functionals/functions.dart';

import 'dart:convert';
import 'dart:io';

class CommentsAndStringsPage extends StatefulWidget {
  const CommentsAndStringsPage({super.key});

  @override
  State<CommentsAndStringsPage> createState() => _CommentsAndStringsPageState();
}

class _CommentsAndStringsPageState extends State<CommentsAndStringsPage> {
  List<List<String>> values = [
    ['"//"', '"#"', '"##"', "add your own"],
    ['"/* */"', '"<!-- -->"', '"<!--- --->"'],
    ['only "" accepted', 'only \'\' accepted', '"" and \'\' accepted'],
  ];
  List<int> indexes = [0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    final dir = Directory.current.path;
    File jsonFile = File("$dir/lib/storage/commentsandstrings.json");
    var jsonData = json.decode(jsonFile.readAsStringSync());
    setState(() {
      indexes[0] = jsonData['slc'];
      indexes[1] = jsonData['mlc'];
      indexes[2] = jsonData['quotes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Comments: ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      color: theme.onSurface,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Single line's Comments    ",
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.01)),
                      DropdownButton(
                        items: values[0].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: theme.onSurface),
                            ),
                          );
                        }).toList(),
                        dropdownColor: theme.surface,
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                        borderRadius: BorderRadius.circular(10),
                        value: values[0][indexes[0]],
                        onChanged: (value) async {
                          indexes[0] = values[0].indexOf(value!);

                          Map<String, dynamic> data = {
                            'slc': indexes[0],
                            'mlc': indexes[1],
                            'quotes': indexes[2],
                          };
                          String datas = jsonEncode(data);
                          await writeData(
                                  datas,
                                  '../vsce_extensions_creator/lib/storage',
                                  'commentsandstrings.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Multi-line Comments    ",
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.01)),
                      DropdownButton(
                        items: values[1].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: theme.onSurface),
                            ),
                          );
                        }).toList(),
                        dropdownColor: theme.surface,
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                        borderRadius: BorderRadius.circular(10),
                        value: values[1][indexes[1]],
                        onChanged: (value) async {
                          indexes[1] = values[1].indexOf(value!);

                          Map<String, dynamic> data = {
                            'slc': indexes[0],
                            'mlc': indexes[1],
                            'quotes': indexes[2],
                          };
                          String datas = jsonEncode(data);
                          await writeData(
                                  datas,
                                  '../vsce_extensions_creator/lib/storage',
                                  'commentsandstrings.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Strings: ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      color: theme.onSurface,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Quotes for Strings    ",
                          style: TextStyle(
                              color: theme.onSurface,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.01)),
                      DropdownButton(
                        items: values[2].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: theme.onSurface),
                            ),
                          );
                        }).toList(),
                        dropdownColor: theme.surface,
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                        borderRadius: BorderRadius.circular(10),
                        value: values[2][indexes[2]],
                        onChanged: (value) async {
                          indexes[2] = values[2].indexOf(value!);
                          Map<String, dynamic> data = {
                            'slc': indexes[0],
                            'mlc': indexes[1],
                            'quotes': indexes[2],
                          };
                          String datas = jsonEncode(data);
                          await writeData(
                                  datas,
                                  '../vsce_extensions_creator/lib/storage',
                                  'commentsandstrings.json')
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(left: BorderSide(color: Colors.black)),
              ),
              child: Column(
                children: [
                  Text(
                    'Comments: ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    indexes[0] == 0
                        ? '// This is a single line comment'
                        : indexes[0] == 1
                            ? '# This is a single line comment'
                            : indexes[0] == 2
                                ? '## This is a single line comment'
                                : '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.018,
                      color: Colors.green,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Text(
                    indexes[1] == 0
                        ? '/* This is a multi\n lines comment */'
                        : indexes[1] == 1
                            ? '<!-- This is a multi\n lines comment -->'
                            : indexes[1] == 2
                                ? '<!--- This is a multi\n lines comment --->'
                                : '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.018,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Text(
                    'Strings: ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    indexes[2] == 0
                        ? '"Strings only with double quotes"'
                        : indexes[2] == 1
                            ? '\'Strings only with single quotes\''
                            : indexes[2] == 2
                                ? '`Strings only with backticks`'
                                : indexes[2] == 3
                                    ? '"Strings with double quotes" \'and single quotes\''
                                    : '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.018,
                      color: Colors.green,
                    ),
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
