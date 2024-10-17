import 'package:flutter/material.dart';

import '../functional/functions.dart';
import '../functional/constants.dart';

import 'dart:convert';

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

  bool checkbox1 = true;
  bool checkbox2 = false;

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
    ColorScheme theme = isDark
        ? darkTheme.colorScheme
        : lightTheme.colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double usableHeight = height - height / 7.5;
    return Scaffold(
      body: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: theme.surface,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: usableHeight / 2,
                    decoration: BoxDecoration(
                      color: theme.surface,
                      border: Border(
                          bottom: BorderSide(color: theme.onSurface, width: 2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // SizedBox(
                            //   width: width / 2.5,
                            //   height: height / 10.8,
                            //   child: TextField(
                            //     controller: TextEditingController(
                            //         text: values[0][indexes[0]]),
                            //     textAlign: TextAlign.center,
                            //     decoration: InputDecoration(
                            //       enabledBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: theme.onSurface, width: 1),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //             color: theme.onSurface, width: 2),
                            //       ),
                            //       labelText: 'Single-line Comments',
                            //       labelStyle: TextStyle(
                            //         color: theme.onSurface,
                            //         fontSize:
                            //             MediaQuery.of(context).size.width *
                            //                 0.02,
                            //       ),
                            //     ),
                            //     style: TextStyle(
                            //       color: theme.onSurface,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     onChanged: (value) async {
                            //       indexes[0] = values[0].indexOf(value);

                            //       Map<String, dynamic> data = {
                            //         'slc': indexes[0],
                            //         'mlc': indexes[1],
                            //         'quotes': indexes[2],
                            //       };
                            //       String datas = jsonEncode(data);
                            //       await writeData(datas, storageAddress,
                            //               'commentsandstrings.json')
                            //           .then((value) {
                            //         setState(() {});
                            //       });
                            //     },
                            //   ),
                            // ),
                            Container(
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                    indexes[0] = 0;
                                  });
                                  Map<String, dynamic> data = {
                                    'slc': indexes[0],
                                    'mlc': indexes[1],
                                    'quotes': indexes[2],
                                  };
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '//',
                                  style: TextStyle(
                                    color: theme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '#',
                                  style: TextStyle(
                                    color: theme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '##',
                                  style: TextStyle(
                                    color: theme.onSurface,
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
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '/* */',
                                  style: TextStyle(
                                    color: theme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '<!-- -->',
                                  style: TextStyle(
                                    color: theme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width / 8,
                              height: height / 10.8,
                              decoration: BoxDecoration(
                                color: theme.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme.onSurface,
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
                                  String datas = jsonEncode(data);
                                  writeData(datas, storageAddress,
                                          'commentsandstrings.json')
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  '<!--- --->',
                                  style: TextStyle(
                                    color: theme.onSurface,
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
                          width: width / 8,
                          decoration: BoxDecoration(
                            color: theme.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: checkbox1 ? theme.onSurface : theme.error,
                              width: 2,
                            ),
                          ),
                          child: TextButton(
                            child: Text(
                              '"',
                              style: TextStyle(
                                color:
                                    checkbox1 ? theme.onSurface : theme.error,
                                fontSize: width * 0.05,
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
                              String datas = jsonEncode(data);
                              writeData(datas, storageAddress,
                                      'commentsandstrings.json')
                                  .then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        ),
                        Container(
                          width: width / 8,
                          decoration: BoxDecoration(
                            color: theme.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: checkbox2 ? theme.onSurface : theme.error,
                              width: 2,
                            ),
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                theme.surface,
                              ),
                            ),
                            child: Text(
                              '\'',
                              style: TextStyle(
                                color:
                                    checkbox2 ? theme.onSurface : theme.error,
                                fontSize: width * 0.05,
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
                              String datas = jsonEncode(data);
                              writeData(datas, storageAddress,
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
            VerticalDivider(
              color: theme.onSurface,
              thickness: 2,
              width: 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 2,
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(left: BorderSide(color: Colors.black)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                                ? '"Strings with double quotes" \'and single quotes\''
                                : 'No String Style Selected',
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
