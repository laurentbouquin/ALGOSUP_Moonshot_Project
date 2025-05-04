// ==== Built-in Imports ==== //
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/visualization.dart';
import 'package:vsce_extensions_creator/src/constants/styles.dart';
import 'dart:convert';
import 'dart:io';

// ==== Pages Imports ==== //
import 'classes.dart';
import 'links.dart';
// import '../common_widgets/visualization.dart';

/// Returns a dynamic map from the specified file path
Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

/// Writes the specified data to the specified file path and file name. If the file does not exist, it will be created.
Future<File> writeData(data, String path, String fileName) async {
  final file = File('$path/$fileName');
  if (file.existsSync()) {
  } else {
    await file.create(recursive: true);
  }

  // Write the file
  return file.writeAsString(data);
}

/// Creates files with the specified names in the specified path and some default content for the files
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
      '{"extensions":[{"name":"Template","description":"This extension is a simple template","version":"1.0.0","categories":["Programming Languages"],"lastUpdated":"2024-08-27 13:12:09.776771","publisher":"temp","extensionFileName":"tmp"}]}');
  commentsAndStringsFile.writeAsStringSync('{"slc":0,"mlc":0,"quotes":2}');
  formatFile
      .writeAsStringSync('{"keywords":["if","else"],"types":["int","string"]}');
  settingsFile.writeAsStringSync('{"outputDirectory":""}');
  themingFile.writeAsStringSync(
      '{"bgColor":"FFFFFF","keywordColor":"FFFFFF","functionColor":"FFFFFF","variableColor":"FFFFFF","stringColor":"FFFFFF","commentColor":"FFFFFF","commonColor":"FFFFFF","otherColor":"FFFFFF"}');
}

/// Returns a Column widget with the data called from the textToVisualize function
Container visualization(WindowSize windowSize, Theming themeColors, usableWidth,
    ColorScheme scheme) {
  return Container(
    width: windowSize.width * 0.3,
    height: windowSize.height * 0.9,
    margin: EdgeInsets.only(
      right: windowSize.width * 0.04,
    ),
    decoration: mainCards(scheme),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: windowSize.width * 0.294,
          height: windowSize.height * 0.1,
          margin: EdgeInsets.only(
            top: windowSize.width * 0.002,
          ),
          decoration: mainCardsHead(scheme),
          child: Center(
            child: Text("Preview", style: mainCardsHeadText(scheme)),
          ),
        ),
        textToVisualize(themeColors, windowSize),
      ],
    ),
  );
}

/// Inverts the input color and returns the inverted color
Color invertColor(String color) {
  int colorInt = int.parse("0xFF$color");
  int invertedColorInt = 0xFFFFFF ^ colorInt;
  return Color(invertedColorInt);
}

/// Returns a string with the hexadecimal value of the input integer
String getHexFromInt(int value) {
  if (value < 16) {
    return "0${value.toRadixString(16)}";
  } else if (value == 0) {
    return "00";
  } else {
    return value.toRadixString(16);
  }
}

/// Converts the input hexadecimal value to an integer and returns the integer
int getIntFromHex(String value) {
  return int.parse(value, radix: 16);
}

/// Changes the red value of the input color and returns the new color
String changeRedHexColor(int value, String color) {
  return getHexFromInt(value.toInt()).toUpperCase() + color.substring(2);
}

/// Changes the green value of the input color and returns the new color
String changeGreenHexColor(int value, String color) {
  return color.substring(0, 2) +
      getHexFromInt(value.toInt()).toUpperCase() +
      color.substring(4);
}

/// Changes the blue value of the input color and returns the new color
String changeBlueHexColor(int value, String color) {
  return color.substring(0, 4) + getHexFromInt(value.toInt()).toUpperCase();
}

/// Compare the input color name with the list of color names and change the color value accordingly for the red value
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

/// Compare the input color name with the list of color names and change the color value accordingly for the green value
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

/// Compare the input color name with the list of color names and change the color value accordingly for the blue value
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

/// Updates the theming class with the new color values
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

/// Returns a list of strings with the categories selected
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

/// Returns a Categories class with the categories selected
Categories setCategories(List<String> categoriesList) {
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
