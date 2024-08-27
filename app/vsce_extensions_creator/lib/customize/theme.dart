import 'package:flutter/material.dart';
import '../functionals/functions.dart';
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

  int bgColor = 0;
  int keywordColor = 1;
  int functionColor = 1;
  int variableColor = 1;
  int stringColor = 2;
  int commentColor = 1;
  int commonColor = 1;

  List<String> categories = [
    "Background",
    "Keywords",
    "Functions",
    "Variables",
    "Strings",
    "Comments",
    "Base"
  ];

  List<String> names = [
    "bgColor",
    "keywordColor",
    "functionColor",
    "variableColor",
    "stringColor",
    "commentColor",
    "commonColor"
  ];

  Map<String, dynamic> jsonDataTemp = {};

  @override
  void initState() {
    super.initState();
    final dir = Directory.current.path;
    File jsonFile = File("$dir/lib/storage/theming.json");
    var jsonData = json.decode(jsonFile.readAsStringSync());
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
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: windowHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Colors: ',
                  style: TextStyle(
                    fontSize: windowWidth * 0.025,
                    color: Colors.black,
                  ),
                ),
                for (var k = 0; k < categories.length; k++)
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 230,
                        child: Text(
                          '${categories[k]} : ',
                          style: TextStyle(
                            fontSize: windowWidth * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      for (var i = 0; i < colors.length; i++)
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: k == 0
                                  ? bgColor == i
                                      ? Colors.red
                                      : Colors.black
                                  : k == 1
                                      ? keywordColor == i
                                          ? Colors.red
                                          : Colors.black
                                      : k == 2
                                          ? functionColor == i
                                              ? Colors.red
                                              : Colors.black
                                          : k == 3
                                              ? variableColor == i
                                                  ? Colors.red
                                                  : Colors.black
                                              : k == 4
                                                  ? stringColor == i
                                                      ? Colors.red
                                                      : Colors.black
                                                  : k == 5
                                                      ? commentColor == i
                                                          ? Colors.red
                                                          : Colors.black
                                                      : commonColor == i
                                                          ? Colors.red
                                                          : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(colors[i]),
                            ),
                            onPressed: () {
                              setState(() {
                                k == 0
                                    ? bgColor = i
                                    : k == 1
                                        ? keywordColor = i
                                        : k == 2
                                            ? functionColor = i
                                            : k == 3
                                                ? variableColor = i
                                                : k == 4
                                                    ? stringColor = i
                                                    : k == 5
                                                        ? commentColor = i
                                                        : commonColor = i;
                              });
                            },
                            child: Container(),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            visualisation(
                windowHeight,
                windowWidth,
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
              datas, '../vsce_extensions_creator/lib/storage', 'theming.json');
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
        width: windowWidth * 0.5,
        height: windowHeight * 0.83,
        decoration: BoxDecoration(
          color: colors[bgColor],
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
            fontSize: 25,
            color: colors[functionColor],
          ),
        ),
        Text(
          ('<iostream>'),
          style: TextStyle(
            fontSize: 25,
            color: colors[stringColor],
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
            fontSize: 25,
            color: colors[keywordColor],
          ),
        ),
        Text(
          ('std;'),
          style: TextStyle(
            fontSize: 25,
            color: colors[variableColor],
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
            fontSize: 25,
            color: colors[commentColor],
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
            fontSize: 25,
            color: colors[keywordColor],
          ),
        ),
        Text(
          ('main'),
          style: TextStyle(
            fontSize: 25,
            color: colors[functionColor],
          ),
        ),
        Text(
          ('() {'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[keywordColor],
          ),
        ),
        Text(
          ('n'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('\n<< '),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
        Text(
          ('\n"Enter an integer: "'),
          style: TextStyle(
            fontSize: 25,
            color: colors[stringColor],
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('>> n;'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[keywordColor],
          ),
        ),
        Text(
          ('\n( n % '),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
        Text(
          ('\n2 '),
          style: TextStyle(
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('\n== '),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('\n)'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
        Text(
          ('" is even."'),
          style: TextStyle(
            fontSize: 25,
            color: colors[stringColor],
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[keywordColor],
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
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
        Text(
          ('" is odd."'),
          style: TextStyle(
            fontSize: 25,
            color: colors[stringColor],
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[keywordColor],
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 25,
            color: colors[variableColor],
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 25,
            color: colors[commonColor],
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
            fontSize: 25,
            color: colors[commonColor],
          ),
        ),
      ],
    ),
  ];
}
