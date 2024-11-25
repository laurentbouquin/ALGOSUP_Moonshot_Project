// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/functional/classes.dart';
import 'dart:convert';

// ==== Pages imports ==== //
import '../functional/functions.dart';
import '../functional/constants.dart';

class CommentsAndStringsPage extends StatefulWidget {
  const CommentsAndStringsPage({super.key});

  @override
  State<CommentsAndStringsPage> createState() => _CommentsAndStringsPageState();
}

class _CommentsAndStringsPageState extends State<CommentsAndStringsPage> {
  List<List<String>> values = [
    ['"//"', '"#"', '"##"'],
    ['"/* */"', '"<!-- -->"', '"<!--- --->"'],
    ['only "" accepted', 'only \'\' accepted', '"" and \'\' accepted'],
  ];
  List<int> indexes = [
    0,
    0,
    0,
  ];

  bool checkbox1 = true;
  bool checkbox2 = false;

  WindowSize windowSize = WindowSize();

  @override
  void initState() {
    super.initState();
    var jsonData = json.decode(commentsAndStringsFile.readAsStringSync());
    setState(() {
      indexes[0] = jsonData['slc'];
      indexes[1] = jsonData['mlc'];
      indexes[2] = jsonData['quotes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    double usableHeight = windowSize.height - windowSize.height / 7.5;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: windowSize.width / 2,
            decoration: BoxDecoration(
              color: scheme.surface,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: usableHeight / 2,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: scheme.onSurface,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    indexes[0] = 0;
                                  },
                                );
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '//',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  indexes[0] = 1;
                                });
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '#',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  indexes[0] = 2;
                                });
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '##',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  indexes[1] = 0;
                                });
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '/* */',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  indexes[1] = 1;
                                });
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '<!-- -->',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: windowSize.width / 8,
                            height: windowSize.height / 10.8,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: scheme.onSurface,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  indexes[1] = 2;
                                });
                                Map<String, dynamic> data = {
                                  'slc': indexes[0],
                                  'mlc': indexes[1],
                                  'quotes': indexes[2],
                                };
                                String dataList = jsonEncode(data);
                                writeData(dataList, storageAddress,
                                        'commentsandstrings.json')
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text(
                                '<!--- --->',
                                style: TextStyle(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: usableHeight / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: windowSize.width / 8,
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: checkbox1 ? scheme.onSurface : scheme.error,
                            width: 2,
                          ),
                        ),
                        child: TextButton(
                          child: Text(
                            '"',
                            style: TextStyle(
                              color:
                                  checkbox1 ? scheme.onSurface : scheme.error,
                              fontSize: windowSize.width * 0.05,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              checkbox1 = !checkbox1;
                              indexes[2] = checkbox2
                                  ? checkbox1
                                      ? 2
                                      : 1
                                  : checkbox1
                                      ? 0
                                      : 3;
                            });
                            Map<String, dynamic> data = {
                              'slc': indexes[0],
                              'mlc': indexes[1],
                              'quotes': indexes[2],
                            };
                            String dataList = jsonEncode(data);
                            writeData(dataList, storageAddress,
                                    'commentsandstrings.json')
                                .then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      Container(
                        width: windowSize.width / 8,
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: checkbox2 ? scheme.onSurface : scheme.error,
                            width: 2,
                          ),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              scheme.surface,
                            ),
                          ),
                          child: Text(
                            '\'',
                            style: TextStyle(
                              color:
                                  checkbox2 ? scheme.onSurface : scheme.error,
                              fontSize: windowSize.width * 0.05,
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                checkbox2 = !checkbox2;
                                indexes[2] = checkbox2
                                    ? checkbox1
                                        ? 2
                                        : 1
                                    : checkbox1
                                        ? 0
                                        : 3;
                              },
                            );
                            Map<String, dynamic> data = {
                              'slc': indexes[0],
                              'mlc': indexes[1],
                              'quotes': indexes[2],
                            };
                            String dataList = jsonEncode(data);
                            writeData(dataList, storageAddress,
                                    'commentsandstrings.json')
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
          ),

          // Separator
          VerticalDivider(
            color: scheme.onSurface,
            thickness: 2,
            width: 2,
          ),

          // This part of the code is the right side of the screen and displays the selected parameters of the comments and strings customization
          Container(
            width: windowSize.width / 2 - 2,
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Comments: ',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.025,
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
                    fontSize: windowSize.width * 0.018,
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
                    fontSize: windowSize.width * 0.018,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: windowSize.height * 0.04,
                ),
                Text(
                  'Strings: ',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                Text(
                  indexes[2] == 0
                      ? '"Strings only with double quotes"'
                      : indexes[2] == 1
                          ? '\'Strings only with single quotes\''
                          : indexes[2] == 2
                              ? '"Strings with double quotes" \'and single quotes\''
                              : 'No String Style Selected',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.018,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
