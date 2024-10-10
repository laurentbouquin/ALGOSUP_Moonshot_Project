import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/functionals/constants.dart';
import '../functionals/functions.dart';
// import '../functionals/constants.dart';
import 'dart:convert';
import 'dart:io';
// import 'package:flex_color_picker/flex_color_picker.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  // Color for the picker shown in Card on the screen.
  List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
  ];

  String bgColor = "FFFFFF";
  String keywordColor = "FFFFFF";
  String functionColor = "FFFFFF";
  String variableColor = "FFFFFF";
  String stringColor = "FFFFFF";
  String commentColor = "FFFFFF";
  String commonColor = "FFFFFF";

  List<String> categories = [
    "Background",
    "Keywords",
    "Functions",
    "Variables",
    "Strings",
    "Comments",
    "Operators",
    "Others"
  ];

  List<String> names = [
    "bgColor",
    "keywordColor",
    "functionColor",
    "variableColor",
    "stringColor",
    "commentColor",
    "commonColor",
    "otherColor"
  ];
  final dir = Directory.current.path;

  Map<String, dynamic> jsonDataTemp = {};

  @override
  void initState() {
    super.initState();
    var jsonData = json.decode(themingFile.readAsStringSync());
    jsonDataTemp = jsonData;
    setState(() {
      bgColor = jsonData['bgColor'];
      keywordColor = jsonData['keywordColor'];
      functionColor = jsonData['functionColor'];
      variableColor = jsonData['variableColor'];
      stringColor = jsonData['stringColor'];
      commentColor = jsonData['commentColor'];
      commonColor = jsonData['commonColor'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: Container(
        color: theme.surface,
        height: height - height / 7.5,
        child: Row(
          children: [
            Column(
              children: <Widget>[
                for (var k = 0; k < categories.length / 2; k++)
                  Row(
                    children: <Widget>[
                      Container(
                        width: width / 4,
                        height: height / 5.4,
                        decoration: BoxDecoration(
                          color: theme.surface,
                          border: Border(
                            bottom:
                                BorderSide(color: theme.onSurface, width: 1),
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
                                  fontSize: width * 0.025,
                                  color: theme.onSurface,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: height / 5.4 / 2,
                              height: height / 5.4 / 2,
                              margin: EdgeInsets.only(right: width / 96),
                              decoration: BoxDecoration(
                                color: jsonDataTemp[names[k * 2 + 1]] != null ? Color(int.parse("0xFF${jsonDataTemp[names[k * 2 + 1]]}")) : Colors.white,
                                border: Border.all(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width / 4,
                        height: height / 5.4,
                        decoration: BoxDecoration(
                          color: theme.surface,
                          border: Border(
                            bottom:
                                BorderSide(color: theme.onSurface, width: 1),
                            left: BorderSide(color: theme.onSurface, width: 1),
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
                                  fontSize: width * 0.025,
                                  color: theme.onSurface,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: height / 5.4 / 2,
                              height: height / 5.4 / 2,
                              margin: EdgeInsets.only(right: width / 96),
                              decoration: BoxDecoration(
                                color: jsonDataTemp[names[k * 2 + 1]] != null ? Color(int.parse("0xFF${jsonDataTemp[names[k * 2 + 1]]}")) : Colors.white,
                                border: Border.all(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            VerticalDivider(
              color: theme.onSurface,
              width: 2,
              thickness: 2,
            ),
            visualisation(
                height,
                width,
                colors,
                bgColor,
                keywordColor,
                functionColor,
                variableColor,
                stringColor,
                commentColor,
                commonColor),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: theme.onSurface,
        onPressed: () async {
          Map<String, dynamic> data = {
            "bgColor": bgColor,
            "keywordColor": keywordColor,
            "functionColor": functionColor,
            "variableColor": variableColor,
            "stringColor": stringColor,
            "commentColor": commentColor,
            "commonColor": commonColor
          };
          String datas = jsonEncode(data);
          writeData(
            datas,
            storageAddress,
            'theming.json',
          );
          setState(() {});
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

Column visualisation(windowHeight, windowWidth, colors, bgColor, keywordColor,
    functionColor, variableColor, stringColor, commentColor, commonColor) {
  return Column(
    children: <Widget>[
      Container(
        width: windowWidth / 2 - 2,
        height: windowHeight - windowHeight / 7.5,
        decoration: BoxDecoration(
          color: Color(int.parse("0xFF$bgColor")),
          border: const Border(left: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Container(
          width: windowWidth * 0.25,
          margin: EdgeInsets.only(left: windowWidth * 0.125),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textToVisualize(colors, keywordColor, functionColor,
                variableColor, stringColor, commentColor, commonColor),
          ),
        ),
      )
    ],
  );
}

List<Widget> textToVisualize(colors, keywordColor, functionColor, variableColor,
    stringColor, commentColor, commonColor) {
  return [
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('#include '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$functionColor")),
          ),
        ),
        Text(
          ('<iostream>'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$stringColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('using namespace '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
        Text(
          ('std;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n// Check if a number is even or odd'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commentColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('int '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
        Text(
          ('main'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$functionColor")),
          ),
        ),
        Text(
          ('() {'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    int '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
        Text(
          ('n'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('\n<< '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
        Text(
          ('\n"Enter an integer: "'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$stringColor")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    cin '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('>> n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    if '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
        Text(
          ('\n( n % '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
        Text(
          ('\n2 '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('\n== '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('\n)'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('        cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
        Text(
          ('" is even."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$stringColor")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    else'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('        cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
        Text(
          ('" is odd."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$stringColor")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    return '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$keywordColor")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$variableColor")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('}'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF$commonColor")),
          ),
        ),
      ],
    ),
  ];
}
