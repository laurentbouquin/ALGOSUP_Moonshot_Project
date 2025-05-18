import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';

/// Creates a dialog with sliders to change the color values of the theme that is being edited
Future<Form> createDialog(
    BuildContext context,
    formKey,
    WindowSize windowSize,
    ColorScheme theme,
    jsonDataTemp,
    names,
    k,
    colorsList,
    themeColors,
    condition) async {
  String redValue = getIntFromHex(colorsList[k].substring(0, 2)).toString();
  String greenValue = getIntFromHex(colorsList[k].substring(2, 4)).toString();
  String blueValue = getIntFromHex(colorsList[k].substring(4, 6)).toString();
  Form form =
      Form(key: formKey, child: Container()); // Initialize with a default value
  await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            alignment:
                Alignment(-windowSize.width * 0.000085, windowSize.height * 0),
            content: StatefulBuilder(builder: (context, setState) {
              form = Form(
                key: formKey,
                child: Container(
                  height: windowSize.height * 0.63,
                  width: windowSize.width * 0.15,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    border: Border.all(
                      color: theme.onSurface,
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
                            height: windowSize.height * 0.05,
                            decoration: BoxDecoration(
                              color: Color(int.parse("0xFF${colorsList[k]}")),
                              border: Border.all(
                                color: theme.onSurface,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                "#${colorsList[k]}",
                                style: TextStyle(
                                  fontSize: windowSize.width * 0.01,
                                  color: invertColor(colorsList[k]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: windowSize.width / 7.3 / 5,
                            height: windowSize.height / 1.5 / 10,
                            decoration: BoxDecoration(
                              color: theme.surface,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: theme.onSurface,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.red,
                        height: windowSize.width * 0.15,
                        width: windowSize.width * 0.15,
                      ),
                      Text(
                        "Red",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Slider(
                            value: getIntFromHex(colorsList[k].substring(0, 2))
                                .toDouble(),
                            min: 0,
                            max: 255,
                            activeColor: Colors.red,
                            thumbColor: theme.onSurface,
                            onChanged: (value) {
                              setState(
                                () {
                                  themeColors = checkRedCondition(
                                      names[k], value.toInt(), colorsList);
                                  redValue = value.toInt().toString();
                                },
                              );
                            },
                          ),
                          Container(
                            width: windowSize.width * 0.03,
                            height: windowSize.height * 0.035,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border.all(
                                color: theme.onSurface,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 20),
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                  text: getIntFromHex(
                                          colorsList[k].substring(0, 2))
                                      .toString()),
                              onChanged: (value) {
                                if (value == "") {
                                  value = "0";
                                }
                                if (int.parse(value) > 255) {
                                  value = "255";
                                } else if (int.parse(value) < 0) {
                                  value = "0";
                                }
                                themeColors = checkRedCondition(
                                    names[k], int.parse(value), colorsList);
                                redValue = value;
                              },
                              onTapOutside: (event) {
                                setState(() {
                                  if (redValue == "") {
                                    redValue = "0";
                                  }
                                  themeColors = checkRedCondition(names[k],
                                      int.parse(redValue), colorsList);
                                  if (int.parse(redValue) > 255) {
                                    redValue = "255";
                                  } else if (int.parse(redValue) < 0) {
                                    redValue = "0";
                                  }
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
                      Text(
                        "Green",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Slider(
                            value: getIntFromHex(colorsList[k].substring(2, 4))
                                .toDouble(),
                            min: 0,
                            max: 255,
                            activeColor: Colors.green,
                            thumbColor: theme.onSurface,
                            onChanged: (value) {
                              setState(
                                () {
                                  themeColors = checkGreenCondition(
                                      names[k], value.toInt(), colorsList);
                                  greenValue = value.toInt().toString();
                                },
                              );
                            },
                          ),
                          Container(
                            width: windowSize.width * 0.03,
                            height: windowSize.height * 0.035,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border.all(
                                color: theme.onSurface,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 20),
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                  text: getIntFromHex(
                                          colorsList[k].substring(2, 4))
                                      .toString()),
                              onChanged: (value) {
                                if (value == "") {
                                  value = "0";
                                }
                                if (int.parse(value) > 255) {
                                  value = "255";
                                } else if (int.parse(value) < 0) {
                                  value = "0";
                                }
                                themeColors = checkGreenCondition(
                                    names[k], int.parse(value), colorsList);
                                greenValue = value;
                              },
                              onTapOutside: (event) {
                                setState(() {
                                  if (greenValue == "") {
                                    greenValue = "0";
                                  }
                                  themeColors = checkGreenCondition(names[k],
                                      int.parse(greenValue), colorsList);
                                  if (int.parse(greenValue) > 255) {
                                    greenValue = "255";
                                  } else if (int.parse(greenValue) < 0) {
                                    greenValue = "0";
                                  }
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
                      Text(
                        "Blue",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Slider(
                            value: getIntFromHex(colorsList[k].substring(4, 6))
                                .toDouble(),
                            min: 0,
                            max: 255,
                            activeColor: Colors.blue,
                            thumbColor: theme.onSurface,
                            onChanged: (value) {
                              setState(
                                () {
                                  themeColors = checkBlueCondition(
                                      names[k], value.toInt(), colorsList);
                                  blueValue = value.toInt().toString();
                                },
                              );
                            },
                          ),
                          Container(
                            width: windowSize.width * 0.03,
                            height: windowSize.height * 0.035,
                            decoration: BoxDecoration(
                              color: theme.surface,
                              border: Border.all(
                                color: theme.onSurface,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 20),
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                  text: getIntFromHex(
                                          colorsList[k].substring(4, 6))
                                      .toString()),
                              onChanged: (value) {
                                if (value == "") {
                                  value = "0";
                                }
                                if (int.parse(value) > 255) {
                                  value = "255";
                                } else if (int.parse(value) < 0) {
                                  value = "0";
                                }
                                themeColors = checkBlueCondition(
                                    names[k], int.parse(value), colorsList);
                                blueValue = value;
                              },
                              onTapOutside: (event) {
                                setState(() {
                                  if (blueValue == "") {
                                    blueValue = "0";
                                  }
                                  themeColors = checkBlueCondition(names[k],
                                      int.parse(blueValue), colorsList);
                                  if (int.parse(blueValue) > 255) {
                                    blueValue = "255";
                                  } else if (int.parse(blueValue) < 0) {
                                    blueValue = "0";
                                  }
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
                      Divider(
                        color: theme.onSurface,
                        thickness: 1,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: windowSize.width * 0.07,
                              height: windowSize.height * 0.05,
                              margin: EdgeInsets.only(
                                top: windowSize.height * 0.002,
                                bottom: windowSize.height * 0.002,
                                left: windowSize.width * 0.002,
                              ),
                              decoration: BoxDecoration(
                                color: theme.surface,
                                border: Border.all(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: theme.onSurface),
                                ),
                              ),
                            ),
                            Container(
                              width: windowSize.width * 0.07,
                              height: windowSize.height * 0.05,
                              margin: EdgeInsets.only(
                                top: windowSize.height * 0.002,
                                bottom: windowSize.height * 0.002,
                                right: windowSize.width * 0.002,
                              ),
                              decoration: BoxDecoration(
                                color: theme.surface,
                                border: Border.all(
                                  color: theme.onSurface,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: theme.onSurface),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
  await writeData(datas, storageAddress, themingFileName);
  await writeData(datas2, storageAddress, extensionsFileName);
}
