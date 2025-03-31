// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'dart:convert';

// ==== Pages Imports ==== //
import '../../constants/functions.dart';
import '../../constants/variables.dart';
import '../../constants/links.dart';
import '../../constants/classes.dart';

import 'theme_widgets.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key, required this.extensionIndex});

  final int extensionIndex;

  @override
  State<ThemePage> createState() =>
      _ThemePageState(extensionIndex: extensionIndex);
}

class _ThemePageState extends State<ThemePage> {
  _ThemePageState({required this.extensionIndex});

  final int extensionIndex;

  // The form key is used to validate the form fields in the dialog
  final _formKey = GlobalKey<FormState>();

  Theming themeColors = Theming();

  WindowSize windowSize = WindowSize();

  Map<String, dynamic> jsonDataTemp = {};

  @override
  void initState() {
    super.initState();
    var themeData = json.decode(themingFile.readAsStringSync());
    jsonDataTemp = themeData;
    var themeColorsList = themeData["extensions"][extensionIndex];
    setState(() {
      themeColors.bgColor = themeColorsList['bgColor'];
      themeColors.keywordColor = themeColorsList['keywordColor'];
      themeColors.functionColor = themeColorsList['functionColor'];
      themeColors.variableColor = themeColorsList['variableColor'];
      themeColors.stringColor = themeColorsList['stringColor'];
      themeColors.commentColor = themeColorsList['commentColor'];
      themeColors.commonColor = themeColorsList['commonColor'];
      themeColors.otherColor = themeColorsList['otherColor'];
      colorsList = [
        themeColorsList['bgColor'],
        themeColorsList['keywordColor'],
        themeColorsList['functionColor'],
        themeColorsList['variableColor'],
        themeColorsList['stringColor'],
        themeColorsList['commentColor'],
        themeColorsList['commonColor'],
        themeColorsList['otherColor']
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    ColorScheme scheme = currentTheme.colorScheme;
    return Scaffold(
      body: Container(
        color: scheme.surface,
        height: windowSize.height - windowSize.height / 7.5,
        child: Row(
          children: [
            Column(
              children: <Widget>[
                ...List.generate(
                  CATEGORIES_NUM ~/ 2,
                  (k) => Row(
                    children: <Widget>[
                      Container(
                        width: windowSize.width / 4,
                        height: windowSize.height / 5.4,
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          border: Border(
                            bottom: BorderSide(
                              color: scheme.onSurface,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "   ${categories[k * 2]}",
                                style: TextStyle(
                                  fontSize: windowSize.width * 0.025,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: windowSize.height / 5.4 / 2,
                              height: windowSize.height / 5.4 / 2,
                              margin:
                                  EdgeInsets.only(right: windowSize.width / 96),
                              decoration: BoxDecoration(
                                color: Color(
                                    int.parse("0xFF${colorsList[k * 2]}")),
                                border: Border.all(
                                  color: scheme.onSurface,
                                  width: 1,
                                ),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                    Size(windowSize.height / 5.4 / 2,
                                        windowSize.height / 5.4 / 2),
                                  ),
                                ),
                                onPressed: () async {
                                  createDialog(
                                          context,
                                          _formKey,
                                          windowSize,
                                          scheme,
                                          jsonDataTemp,
                                          names,
                                          k,
                                          colorsList,
                                          themeColors,
                                          0)
                                      .then((value) {
                                    setState(() {
                                      themeColors.bgColor = colorsList[0];
                                      themeColors.keywordColor = colorsList[1];
                                      themeColors.functionColor = colorsList[2];
                                      themeColors.variableColor = colorsList[3];
                                      themeColors.stringColor = colorsList[4];
                                      themeColors.commentColor = colorsList[5];
                                      themeColors.commonColor = colorsList[6];
                                      themeColors.otherColor = colorsList[7];
                                      updateColorFile(themeColors, extensionIndex);
                                    });
                                  });
                                },
                                child: const Text(""),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: windowSize.width / 4,
                        height: windowSize.height / 5.4,
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          border: Border(
                            bottom: BorderSide(
                              color: scheme.onSurface,
                              width: 1,
                            ),
                            left: BorderSide(
                              color: scheme.onSurface,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.start,
                                "   ${categories[k * 2 + 1]}",
                                style: TextStyle(
                                  fontSize: windowSize.width * 0.025,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: windowSize.height / 5.4 / 2,
                              height: windowSize.height / 5.4 / 2,
                              margin:
                                  EdgeInsets.only(right: windowSize.width / 96),
                              decoration: BoxDecoration(
                                color: Color(
                                    int.parse("0xFF${colorsList[k * 2 + 1]}")),
                                border: Border.all(
                                  color: scheme.onSurface,
                                  width: 1,
                                ),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                    Size(windowSize.height / 5.4 / 2,
                                        windowSize.height / 5.4 / 2),
                                  ),
                                ),
                                onPressed: () async {
                                  createDialog(
                                          context,
                                          _formKey,
                                          windowSize,
                                          scheme,
                                          jsonDataTemp,
                                          names,
                                          k,
                                          colorsList,
                                          themeColors,
                                          1)
                                      .then((value) {
                                    setState(() {
                                      themeColors.bgColor = colorsList[0];
                                      themeColors.keywordColor = colorsList[1];
                                      themeColors.functionColor = colorsList[2];
                                      themeColors.variableColor = colorsList[3];
                                      themeColors.stringColor = colorsList[4];
                                      themeColors.commentColor = colorsList[5];
                                      themeColors.commonColor = colorsList[6];
                                      themeColors.otherColor = colorsList[7];
                                      updateColorFile(themeColors, extensionIndex);
                                    });
                                  });
                                },
                                child: const Text(""),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalDivider(
              color: scheme.onSurface,
              width: 2,
              thickness: 2,
            ),
            visualization(
              windowSize,
              themeColors,
            ),
          ],
        ),
      ),
    );
  }
}
