import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';

Container extensionOptionsPart(
  WindowSize windowSize,
  ColorScheme scheme,
  int extensionIndex,
  String text,
  String hintText,
  double width,
  double height,
) {
  TextEditingController controller = TextEditingController();
  var extensionsData = json.decode(extensionsFile.readAsStringSync());
  var extensionData =
      extensionsData["extensions"][extensionIndex] as Map<String, dynamic>;
  debugPrint("Extension data: ${extensionData["name"]}");
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: scheme.secondary,
      border: Border(
        bottom: BorderSide(
          color: scheme.onSurface,
          width: 1,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: scheme.onSurface,
          ),
        ),
        Container(
          width: windowSize.width * 0.12,
          margin: EdgeInsets.only(left: windowSize.width * 0.02),
          child: TextField(
            controller: controller
              ..text = (text == "Name:"
                  ? extensionData["name"]
                  : text == "Description:"
                      ? extensionData["description"]
                      : text == "Publisher:"
                          ? extensionData["publisher"]
                          : text == "Version:"
                              ? extensionData["version"]
                              : text == "Extension:"
                                  ? extensionData["extensionFileName"]
                                  : "?"),
            keyboardType:
                text == "Version:" ? TextInputType.number : TextInputType.text,
            inputFormatters: text == "Version:"
                ? [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9.]'),
                    ),
                  ]
                : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
            onChanged: (value) async {
              switch (text) {
                case "Name:":
                  debugPrint("Text field changed: $value");
                  updateData("extensions", extensionIndex, name: value)
                      .then((value) {});
                  break;
                case "Description:":
                  await updateData("extensions", extensionIndex,
                          description: value)
                      .then((value) {});
                  break;
                case "Publisher:":
                  await updateData("extensions", extensionIndex,
                          publisher: value)
                      .then((value) {});
                  break;
                case "Version:":
                  await updateData("extensions", extensionIndex, version: value)
                      .then((value) {});
                  break;
                case "Extension:":
                  await updateData("extensions", extensionIndex,
                          extensionFileName: value)
                      .then((value) {});
                  break;
              }
            },
          ),
        ),
      ],
    ),
  );
}

Container categoriesButton(WindowSize windowSize, ColorScheme scheme,
    int extensionIndex, Categories categories, String text, State state) {
  bool isSelected = false;
  if (text == "Programming Languages" && categories.languages) {
    isSelected = true;
  } else if (text == "Themes" && categories.themes) {
    isSelected = true;
  } else if (text == "Snippets" && categories.snippets) {
    isSelected = true;
  } else if (text == "Debuggers" && categories.debuggers) {
    isSelected = true;
  } else if (text == "Keymaps" && categories.keymaps) {
    isSelected = true;
  } else if (text == "Testing" && categories.testing) {
    isSelected = true;
  } else if (text == "Linters" && categories.linters) {
    isSelected = true;
  } else if (text == "Other" && categories.other) {
    isSelected = true;
  }
  return Container(
    width: windowSize.width / 5,
    height: windowSize.height * 0.05,
    margin: EdgeInsets.only(
      top: windowSize.height * 0.05,
    ),
    decoration: BoxDecoration(
      color: isSelected ? scheme.onSurface : scheme.surface,
      border: isSelected
          ? null
          : Border.all(
              color: scheme.onSurface,
              width: 1,
            ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            isSelected ? scheme.onSurface : scheme.surface,
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              color: isSelected ? scheme.surface : scheme.onSurface,
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () async {
          switch (text) {
            case "Programming Languages":
              categories.languages = !categories.languages;
              break;
            case "Themes":
              categories.themes = !categories.themes;
              break;
            case "Snippets":
              categories.snippets = !categories.snippets;
              break;
            case "Debuggers":
              categories.debuggers = !categories.debuggers;
              break;
            case "Keymaps":
              categories.keymaps = !categories.keymaps;
              break;
            case "Testing":
              categories.testing = !categories.testing;
              break;
            case "Linters":
              categories.linters = !categories.linters;
              break;
            case "Other":
              categories.other = !categories.other;
              break;
          }
          updateData("extensions", extensionIndex, categories: categories).then(
            (value) {
              // ignore: invalid_use_of_protected_member
              state.setState(() {});
            },
          );
        }),
  );
}
