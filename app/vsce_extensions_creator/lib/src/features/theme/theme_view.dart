// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/styles.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar_view.dart';
import 'dart:convert';

// ==== Pages Imports ==== //
import '../../constants/functions.dart';
import '../../constants/variables.dart';
import '../../constants/links.dart';
import '../../constants/classes.dart';

import 'theme_widgets.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  static const String routeName = '/themePage';

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  _ThemePageState();

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
    var themeColorsList = themeData["extensions"][currentExtensionIndex];
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
    var usableWidth = windowSize.width - windowSize.width / 7;
    ColorScheme scheme = currentTheme.colorScheme;
    return Scaffold(
      body: Container(
        color: scheme.surface,
        width: windowSize.width,
        height: windowSize.height,
        child: Row(
          children: [
            Container(
              decoration: mainCards(scheme),
              width: windowSize.width * 0.3,
              height: windowSize.height * 0.9,
              margin: EdgeInsets.only(
                left: windowSize.width * 0.04,
                right: windowSize.width * 0.18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: windowSize.width * 0.294,
                    height: windowSize.height * 0.1,
                    margin: EdgeInsets.only(
                      top: windowSize.width * 0.002,
                    ),
                    decoration: mainCardsHead(scheme),
                    child: Center(
                      child: Text("Colors", style: mainCardsHeadText(scheme)),
                    ),
                  ),
                  ...List.generate(
                    CATEGORIES_NUM,
                    (k) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: windowSize.width * 0.2,
                          height: windowSize.height * 0.05,
                          margin: EdgeInsets.only(
                            top: windowSize.height * 0.02,
                            bottom: k == CATEGORIES_NUM - 1
                                ? windowSize.height * 0.02
                                : 0,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            border: Border.all(
                              color: scheme.onSurface,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "   ${categories[k]}",
                                  style: TextStyle(
                                    fontSize: windowSize.width * 0.017,
                                    color: scheme.onSurface,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                height: windowSize.height * 0.05,
                                width: windowSize.height * 0.05,
                                decoration: BoxDecoration(
                                  color:
                                      Color(int.parse("0xFF${colorsList[k]}")),
                                  border: Border(
                                    left: BorderSide(
                                      color: scheme.onSurface,
                                      width: 1,
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
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
                                        themeColors.keywordColor =
                                            colorsList[1];
                                        themeColors.functionColor =
                                            colorsList[2];
                                        themeColors.variableColor =
                                            colorsList[3];
                                        themeColors.stringColor = colorsList[4];
                                        themeColors.commentColor =
                                            colorsList[5];
                                        themeColors.commonColor = colorsList[6];
                                        themeColors.otherColor = colorsList[7];
                                        updateColorFile(
                                            themeColors, currentExtensionIndex);
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
            ),
            visualization(windowSize, themeColors, usableWidth, scheme),
            NavBar(state: this),
          ],
        ),
      ),
    );
  }
}
