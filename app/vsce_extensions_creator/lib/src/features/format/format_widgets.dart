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
      color: scheme.surface,
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
  return Container(
    width: windowSize.width / 9.6,
    decoration: BoxDecoration(
      color: scheme.surface,
      border: Border.all(
        color: scheme.onSurface,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              text == "Programming Languages"
                  ? (categories.languages ? scheme.onSurface : scheme.primary)
                  : text == "Themes"
                      ? (categories.themes ? scheme.onSurface : scheme.primary)
                      : text == "Snippets"
                          ? (categories.snippets
                              ? scheme.onSurface
                              : scheme.primary)
                          : text == "Debuggers"
                              ? (categories.debuggers
                                  ? scheme.onSurface
                                  : scheme.primary)
                              : text == "Keymaps"
                                  ? (categories.keymaps
                                      ? scheme.onSurface
                                      : scheme.primary)
                                  : text == "Testing"
                                      ? (categories.testing
                                          ? scheme.onSurface
                                          : scheme.primary)
                                      : text == "Linters"
                                          ? (categories.linters
                                              ? scheme.onSurface
                                              : scheme.primary)
                                          : text == "Other" 
                                            ? (categories.other
                                                ? scheme.onSurface
                                                : scheme.primary)
                                                :const Color(0xFF000000)),
        ),
        child: FittedBox(
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
                color: text == "Programming Languages"
                    ? (categories.languages
                        ? scheme.onPrimary
                        : scheme.onSurface)
                    : text == "Themes"
                        ? (categories.themes
                            ? scheme.onPrimary
                            : scheme.onSurface)
                        : text == "Snippets"
                            ? (categories.snippets
                                ? scheme.onPrimary
                                : scheme.onSurface)
                            : text == "Debuggers"
                                ? (categories.debuggers
                                    ? scheme.onPrimary
                                    : scheme.onSurface)
                                : text == "Keymaps"
                                    ? (categories.keymaps
                                        ? scheme.onPrimary
                                        : scheme.onSurface)
                                    : text == "Testing"
                                        ? (categories.testing
                                            ? scheme.onPrimary
                                            : scheme.onSurface)
                                        : text == "Linters"
                                            ? (categories.linters
                                                ? scheme.onPrimary
                                                : scheme.onSurface)
                                            : text == "Other" 
                                              ? (categories.other
                                                  ? scheme.onPrimary
                                                  : scheme.onSurface)
                                                  : scheme.onSurface),
          ),
        ),
        onPressed: () async {
          text == "Programming Languages"
              ? categories.languages = !categories.languages
              : text == "Themes"
                  ? categories.themes = !categories.themes
                  : text == "Snippets"
                      ? categories.snippets = !categories.snippets
                      : text == "Debuggers"
                          ? categories.debuggers = !categories.debuggers
                          : text == "Keymaps"
                              ? categories.keymaps = !categories.keymaps
                              : text == "Testing"
                                  ? categories.testing = !categories.testing
                                  : text == "Linters"
                                      ? categories.linters = !categories.linters
                                      : text == "Other" 
                                        ? categories.other = !categories.other
                                        : null;
          updateData("extensions", extensionIndex, categories: categories).then(
            (value) {
              // ignore: invalid_use_of_protected_member
              state.setState(() {});
            },
          );
        }),
  );
}
