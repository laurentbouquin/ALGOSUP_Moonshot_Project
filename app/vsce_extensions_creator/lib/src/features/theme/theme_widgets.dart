import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';

/// Creates a dialog with sliders to change the color values of the theme that is being edited
Future<Form> createDialog(BuildContext context, formKey, WindowSize windowSize,
    theme, jsonDataTemp, names, k, colorsList, themeColors, condition) async {
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
                  height: windowSize.height / 1.5,
                  width: windowSize.width / 7.3,
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
                            width: windowSize.width / 7.3 / 5 * 4,
                            height: windowSize.height / 21.6,
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
                            width: windowSize.width / 7.3 / 5,
                            height: windowSize.height / 1.5 / 10,
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
                            width: windowSize.width / 40,
                            height: windowSize.height / 37.2,
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
                                fontSize: windowSize.width * 0.005,
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

/// Updates the color file with the new color values
void updateColorFile(Theming themeColors, int extensionIndex) async {
  var themeData = json.decode(themingFile.readAsStringSync());
  var extensionData = json.decode(extensionsFile.readAsStringSync());
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
  themeData["extensions"][extensionIndex] = data;
  extensionData["extensions"][extensionIndex]["lastUpdated"] =
      DateTime.now().toString();
  String datas = jsonEncode(themeData);
  String datas2 = jsonEncode(extensionData);
  await writeData(datas, storageAddress, 'theming.json');
  await writeData(datas2, storageAddress, 'extensionsList.json');
}
