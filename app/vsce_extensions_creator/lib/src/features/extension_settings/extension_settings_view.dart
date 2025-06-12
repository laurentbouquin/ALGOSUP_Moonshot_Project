import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';
import 'package:vsce_extensions_creator/src/constants/styles.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'package:vsce_extensions_creator/src/features/extension_settings/extension_settings_styles.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar_view.dart';

class ExtensionSettingsView extends StatefulWidget {
  const ExtensionSettingsView({super.key});

  static const routeName = '/ExtensionSettingsPage';

  @override
  State<ExtensionSettingsView> createState() => _ExtensionSettingsViewState();
}

class _ExtensionSettingsViewState extends State<ExtensionSettingsView> {
  Extension currentExtension = Extension();

  WindowSize windowSize = WindowSize();

  String settingsPath = '';

  @override
  void initState() {
    super.initState();

    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData['extensions'][currentExtensionIndex];

    var settingsData = json.decode(settingsFile.readAsStringSync());

    setState(() {
      currentExtension.name = extensionData['name'];
      currentExtension.description = extensionData['description'];
      currentExtension.version = extensionData['version'];
      currentExtension.categories = setCategories(categoriesList);
      currentExtension.publisherName = extensionData['publisher'];
      currentExtension.extensionFileName = extensionData['extensionFileName'];

      settingsPath =
          settingsData["extensions"][currentExtensionIndex]['outputDirectory'];
      settingsPath =
          settingsData["extensions"][currentExtensionIndex]['outputDirectory'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize = WindowSize(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    return Scaffold(
        backgroundColor: scheme.surface,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: windowSize.width * 0.76,
              margin: EdgeInsets.only(
                top: windowSize.height * 0.05,
                bottom: windowSize.height * 0.05,
                right: windowSize.width * 0.05,
              ),
              padding: EdgeInsets.only(
                bottom: windowSize.height * 0.05,
              ),
              decoration: mainCards(scheme),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: windowSize.width * 0.752,
                    height: windowSize.height * 0.1,
                    decoration: mainCardsHead(scheme),
                    margin: EdgeInsets.only(
                      top: windowSize.width * 0.002,
                      left: windowSize.width * 0.002,
                    ),
                    child: Center(
                      child: Text(
                        'Extension Options',
                        textAlign: TextAlign.center,
                        style: mainCardsHeadText(scheme),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Name: ',
                        style: extensionSettingsTitleCategory(scheme),
                      ),
                      Container(
                        width: windowSize.width * 0.45,
                        height: windowSize.height * 0.08,
                        decoration: extensionSettingsBoxCategory(scheme),
                        child: Center(
                          child: TextField(
                            cursorColor: scheme.onSurface,
                            controller: TextEditingController(
                              text: currentExtension.name,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Extension name',
                              hintStyle: TextStyle(
                                color: scheme.onSurface,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 30,
                              color: scheme.onSurface,
                            ),
                            onChanged: (text) async {
                              currentExtension.name = text;
                              await updateData(
                                  "extensions", currentExtensionIndex,
                                  name: text);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      'Description: ',
                      style: extensionSettingsTitleCategory(scheme),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: windowSize.width * 0.65,
                      height: windowSize.height * 0.25,
                      decoration: extensionSettingsBoxCategory(scheme),
                      padding: EdgeInsets.all(
                        windowSize.height * 0.01
                      ),
                      child: TextField(
                        cursorColor: scheme.onSurface,
                        maxLines: 5,
                        maxLength: 150,
                        controller: TextEditingController(
                          text: currentExtension.description,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            color: scheme.onSurface,
                          ),
                          border: InputBorder.none,
                          hintText: 'Extension description',
                          hintStyle: TextStyle(
                            color: scheme.onSurface,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 30,
                          color: scheme.onSurface,
                        ),
                        onChanged: (text) async {
                          currentExtension.description = text;
                          await updateData("extensions", currentExtensionIndex,
                              description: text);
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Version: ',
                        style: extensionSettingsTitleCategory(scheme),
                      ),
                      Text(
                        'Extension: ',
                        style: extensionSettingsTitleCategory(scheme),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: windowSize.width * 0.3,
                        height: windowSize.height * 0.08,
                        decoration: extensionSettingsBoxCategory(scheme),
                        child: Center(
                          child: TextField(
                            cursorColor: scheme.onSurface,
                            controller: TextEditingController(
                              text: currentExtension.version,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Extension version (e.g. 1.0.0)',
                              hintStyle: TextStyle(
                                color: scheme.onSurface,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 30,
                              color: scheme.onSurface,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9.]'),
                              ),
                            ],
                            onChanged: (text) async {
                              currentExtension.version = text;
                              await updateData(
                                  "extensions", currentExtensionIndex,
                                  version: text);
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: windowSize.width * 0.3,
                        height: windowSize.height * 0.08,
                        decoration: extensionSettingsBoxCategory(scheme),
                        child: Center(
                          child: TextField(
                            cursorColor: scheme.onSurface,
                            controller: TextEditingController(
                              text: currentExtension.extensionFileName,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Extension file name (e.g. py or js)',
                              hintStyle: TextStyle(
                                color: scheme.onSurface,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 30,
                              color: scheme.onSurface,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-z]'),
                              ),
                            ],
                            onChanged: (text) async {
                              currentExtension.extensionFileName = text;
                              await updateData(
                                  "extensions", currentExtensionIndex,
                                  extensionFileName: text);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            NavBar(state: this),
          ],
        ));
  }
}
