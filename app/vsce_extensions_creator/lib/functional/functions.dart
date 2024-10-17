import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'classes.dart';

import 'constants.dart';

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

Future<File> writeData(data, String path, String fileName) async {
  final file = File('$path/$fileName');
  if (file.existsSync()) {
  } else {
    await file.create(recursive: true);
  }

  // Write the file
  return file.writeAsString(data);
}

Future<void> createBaseFilesContent(String path) async {
  List<String> files = [
    "commentsandstrings",
    "extensions_list",
    "format",
    "settings",
    "theming"
  ];

  final storagePath = storageAddress;
  for (int i = 0; i < files.length; i++) {
    File file = File("$storagePath/${files[i]}.json");
    if (!file.existsSync()) {
      file.createSync();
    }
  }

  extensionsFile.writeAsStringSync(
      '{"extensions":[{"name":"Template","description":"This extension is a simple template","version":"1.0.0","category":"Programming Languages","lastUpdated":"2024-08-27 13:12:09.776771","publisher":"temp","extensionFileName":"tmp"}]}');
  commentsAndStringsFile.writeAsStringSync('{"slc":0,"mlc":0,"quotes":2}');
  formatFile
      .writeAsStringSync('{"keywords":["if","else"],"types":["int","string"]}');
  settingsFile.writeAsStringSync('{"outputDirectory":""}');
  themingFile.writeAsStringSync(
      '{"bgColor":"FFFFFF","keywordColor":"FFFFFF","functionColor":"FFFFFF","variableColor":"FFFFFF","stringColor":"FFFFFF","commentColor":"FFFFFF","commonColor":"FFFFFF","otherColor":"FFFFFF"}');
}

Column visualization(windowHeight, windowWidth, Theming themeColors) {
  return Column(
    children: <Widget>[
      Container(
        width: windowWidth / 2 - 2,
        height: windowHeight - windowHeight / 7.5,
        decoration: BoxDecoration(
          color: Color(int.parse("0xFF${themeColors.bgColor}")),
          border: const Border(left: BorderSide(color: Colors.black, width: 1)),
        ),
        child: Container(
          width: windowWidth * 0.25,
          margin: EdgeInsets.only(left: windowWidth * 0.125),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textToVisualize(themeColors),
          ),
        ),
      )
    ],
  );
}

List<Widget> textToVisualize(Theming themeColors) {
  return [
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('#include '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.functionColor}")),
          ),
        ),
        Text(
          ('<iostream>'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('std;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
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
            color: Color(int.parse("0xFF${themeColors.commentColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('main'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.functionColor}")),
          ),
        ),
        Text(
          ('() {'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('n'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n<< '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n"Enter an integer: "'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('>> n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('\n( n % '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n2 '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n== '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n)'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('" is even."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
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
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('" is odd."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
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
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
  ];
}

Color invertColor(String color) {
  int colorInt = int.parse("0xFF$color");
  int invertedColorInt = 0xFFFFFF ^ colorInt;
  return Color(invertedColorInt);
}

String getHexFromInt(int value) {
  if (value < 16) {
    return "0${value.toRadixString(16)}";
  } else if (value == 0) {
    return "00";
  } else {
    return value.toRadixString(16);
  }
}

int getIntFromHex(String value) {
  return int.parse(value, radix: 16);
}

String changeRedHexColor(int value, String color) {
  return getHexFromInt(value.toInt()).toUpperCase() + color.substring(2);
}

String changeGreenHexColor(int value, String color) {
  return color.substring(0, 2) +
      getHexFromInt(value.toInt()).toUpperCase() +
      color.substring(4);
}

String changeBlueHexColor(int value, String color) {
  return color.substring(0, 4) + getHexFromInt(value.toInt()).toUpperCase();
}

Theming checkRedCondition(String name, int value, List<String> colorsList) {
  if (name == "bgColor") {
    colorsList[0] = changeRedHexColor(value, colorsList[0]);
  } else if (name == "keywordColor") {
    colorsList[1] = changeRedHexColor(value, colorsList[1]);
  } else if (name == "functionColor") {
    colorsList[2] = changeRedHexColor(value, colorsList[2]);
  } else if (name == "variableColor") {
    colorsList[3] = changeRedHexColor(value, colorsList[3]);
  } else if (name == "stringColor") {
    colorsList[4] = changeRedHexColor(value, colorsList[4]);
  } else if (name == "commentColor") {
    colorsList[5] = changeRedHexColor(value, colorsList[5]);
  } else if (name == "commonColor") {
    colorsList[6] = changeRedHexColor(value, colorsList[6]);
  } else if (name == "otherColor") {
    colorsList[7] = changeRedHexColor(value, colorsList[7]);
  } else {
    debugPrint("Invalid color name");
  }
  return updateThemingClass(colorsList);
}

Theming checkGreenCondition(String name, int value, List<String> colorsList) {
  if (name == "bgColor") {
    colorsList[0] = changeGreenHexColor(value, colorsList[0]);
  } else if (name == "keywordColor") {
    colorsList[1] = changeGreenHexColor(value, colorsList[1]);
  } else if (name == "functionColor") {
    colorsList[2] = changeGreenHexColor(value, colorsList[2]);
  } else if (name == "variableColor") {
    colorsList[3] = changeGreenHexColor(value, colorsList[3]);
  } else if (name == "stringColor") {
    colorsList[4] = changeGreenHexColor(value, colorsList[4]);
  } else if (name == "commentColor") {
    colorsList[5] = changeGreenHexColor(value, colorsList[5]);
  } else if (name == "commonColor") {
    colorsList[6] = changeGreenHexColor(value, colorsList[6]);
  } else if (name == "otherColor") {
    colorsList[7] = changeGreenHexColor(value, colorsList[7]);
  } else {
    debugPrint("Invalid color name");
  }
  return updateThemingClass(colorsList);
}

Theming checkBlueCondition(String name, int value, List<String> colorsList) {
  if (name == "bgColor") {
    colorsList[0] = changeBlueHexColor(value, colorsList[0]);
  } else if (name == "keywordColor") {
    colorsList[1] = changeBlueHexColor(value, colorsList[1]);
  } else if (name == "functionColor") {
    colorsList[2] = changeBlueHexColor(value, colorsList[2]);
  } else if (name == "variableColor") {
    colorsList[3] = changeBlueHexColor(value, colorsList[3]);
  } else if (name == "stringColor") {
    colorsList[4] = changeBlueHexColor(value, colorsList[4]);
  } else if (name == "commentColor") {
    colorsList[5] = changeBlueHexColor(value, colorsList[5]);
  } else if (name == "commonColor") {
    colorsList[6] = changeBlueHexColor(value, colorsList[6]);
  } else if (name == "otherColor") {
    colorsList[7] = changeBlueHexColor(value, colorsList[7]);
  } else {
    debugPrint("Invalid color name");
  }
  return updateThemingClass(colorsList);
}

Theming updateThemingClass(List<String> colorList) {
  return Theming(
    bgColor: colorList[0],
    keywordColor: colorList[1],
    functionColor: colorList[2],
    variableColor: colorList[3],
    stringColor: colorList[4],
    commentColor: colorList[5],
    commonColor: colorList[6],
    otherColor: colorList[7],
  );
}

Future<Form> createDialog(BuildContext context, formKey, width, height, theme,
    jsonDataTemp, names, k, colorsList, themeColors, condition) async {
  Form form =
      Form(key: formKey, child: Container()); // Initialize with a default value
  await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, setState) {
              form = Form(
                key: formKey,
                child: Container(
                  height: height / 1.5,
                  width: width / 7.3,
                  decoration: BoxDecoration(
                    color: theme.primary,
                    border: Border.all(
                      color: theme.onPrimary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width / 7.3 / 5 * 4,
                            height: height / 21.6,
                            decoration: BoxDecoration(
                              color: Color(int.parse(
                                  "0xFF${colorsList[k * 2 + condition]}")),
                              border: Border.all(
                                color: theme.onPrimary,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                "#${colorsList[k * 2 + condition]}",
                                style: TextStyle(
                                    color: invertColor(
                                        colorsList[k * 2 + condition])),
                              ),
                            ),
                          ),
                          Container(
                            width: width / 7.3 / 5,
                            height: height / 1.5 / 10,
                            decoration: BoxDecoration(
                              color: theme.primary,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: theme.onSurface,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const Text("Red"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Slider(
                            value: getIntFromHex(colorsList[k * 2 + condition]
                                    .substring(0, 2))
                                .toDouble(),
                            min: 0,
                            max: 255,
                            onChanged: (value) {
                              setState(
                                () {
                                  themeColors = checkRedCondition(
                                      names[k * 2 + condition],
                                      value.toInt(),
                                      colorsList);
                                },
                              );
                            },
                          ),
                          Container(
                            width: width / 40,
                            height: height / 37.2,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border.all(
                                color: theme.onSurface,
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              controller: TextEditingController(
                                  text: getIntFromHex(
                                          colorsList[k * 2 + condition]
                                              .substring(0, 2))
                                      .toString()),
                              onChanged: (value) {
                                setState(() {
                                  if (value == "") {
                                    value = "0";
                                  }
                                  themeColors = checkRedCondition(
                                      names[k * 2 + condition],
                                      int.parse(value),
                                      colorsList);
                                });
                              },
                              style: TextStyle(
                                color: theme.onSurface,
                                fontSize: width * 0.005,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text("Green"),
                      Slider(
                          value: getIntFromHex(
                                  colorsList[k * 2 + condition].substring(2, 4))
                              .toDouble(),
                          min: 0,
                          max: 255,
                          onChanged: (value) {
                            setState(() {
                              themeColors = checkGreenCondition(
                                  names[k * 2 + condition],
                                  value.toInt(),
                                  colorsList);
                            });
                          }),
                      const Text("Blue"),
                      Slider(
                          value: getIntFromHex(
                                  colorsList[k * 2 + condition].substring(4))
                              .toDouble(),
                          min: 0,
                          max: 255,
                          onChanged: (value) {
                            setState(() {
                              themeColors = checkBlueCondition(
                                  names[k * 2 + condition],
                                  value.toInt(),
                                  colorsList);
                            });
                          }),
                    ],
                  ),
                ),
              );
              return form;
            }),
          ));
  return form;
}

void updateColorFile(Theming themeColors) async {
  Map<String, dynamic> data = {
    "bgColor": themeColors.bgColor,
    "keywordColor": themeColors.keywordColor,
    "functionColor": themeColors.functionColor,
    "variableColor": themeColors.variableColor,
    "stringColor": themeColors.stringColor,
    "commentColor": themeColors.commentColor,
    "commonColor": themeColors.commonColor,
    "otherColor": themeColors.otherColor
  };
  String datas = jsonEncode(data);
  await writeData(datas, storageAddress, 'theming.json');
}

List<String> getCategories(Categories categories) {
  List<String> categoriesPushed = [];
  if (categories.languages) {
    categoriesPushed.add("Programming Languages");
  }
  if (categories.themes) {
    categoriesPushed.add("Themes");
  }
  if (categories.snippets) {
    categoriesPushed.add("Snippets");
  }
  if (categories.debuggers) {
    categoriesPushed.add("Debuggers");
  }
  if (categories.keymaps) {
    categoriesPushed.add("Keymaps");
  }
  if (categories.testing) {
    categoriesPushed.add("Testing");
  }
  if (categories.linters) {
    categoriesPushed.add("Linters");
  }
  if (categories.other) {
    categoriesPushed.add("Other");
  }
  return categoriesPushed;
}

Categories setCategories(List<String> categoriesList){
  Categories categories = Categories();
  for (int i = 0; i < categoriesList.length; i++) {
    if (categoriesList[i] == "Programming Languages") {
      categories.languages = true;
    } else if (categoriesList[i] == "Themes") {
      categories.themes = true;
    } else if (categoriesList[i] == "Snippets") {
      categories.snippets = true;
    } else if (categoriesList[i] == "Debuggers") {
      categories.debuggers = true;
    } else if (categoriesList[i] == "Keymaps") {
      categories.keymaps = true;
    } else if (categoriesList[i] == "Testing") {
      categories.testing = true;
    } else if (categoriesList[i] == "Linters") {
      categories.linters = true;
    } else if (categoriesList[i] == "Other") {
      categories.other = true;
    }
  }
  return categories;
}