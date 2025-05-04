// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'dart:io';
import 'dart:convert';

// ==== Pages Imports ==== //

// Call data files
import '../constants/functions.dart';
import '../constants/variables.dart';
import '../constants/links.dart';
import '../constants/classes.dart';

// ==== External Imports ==== //
import 'package:file_picker/file_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _SettingsPageState();

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
    });
  }

  @override
  Widget build(BuildContext context) {
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;

    ColorScheme scheme = currentTheme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          // Back Button
          Container(
            margin: EdgeInsets.only(
                top: windowSize.height / 20, left: windowSize.width / 20),
            child: Transform.scale(
              scale: 1.5,
              child: IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    redirectToStateless(context, currentPage).then((value) {});
                  });
                },
                icon: Icon(Icons.arrow_back, color: scheme.onSurface),
              ),
            ),
          ),

          // Main Column
          Container(
            width: windowSize.width * 0.5,
            margin: EdgeInsets.only(
              left: windowSize.width * .25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Change Publisher Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: windowSize.height / 8,
                      width: windowSize.width / 2.25,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(scheme.onSurface),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          isConnected
                              ? "Connected as: ${currentExtension.publisherName}"
                              : "Click to connect to publisher",
                          style: TextStyle(
                            fontSize: windowSize.height * 0.025,
                            color: scheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Manage Output Directory
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Select The Output Directory
                    Container(
                      height: windowSize.height * 0.125,
                      width: windowSize.width * 0.2,
                      margin: const EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        border: Border.all(color: scheme.onSurface, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(scheme.surface),
                          overlayColor: WidgetStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () async {
                          String? result =
                              await FilePicker.platform.getDirectoryPath();
                          if (result != null) {
                            updateData("settings", currentExtensionIndex,
                                    outputDirectory: result)
                                .then((value) {});
                            setState(() {
                              settingsPath = result;
                            });
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: Text(
                          "Select Output Directory",
                          style: TextStyle(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Go To The Output Directory
                    Container(
                      height: windowSize.height / 8,
                      width: windowSize.width / 4.8,
                      margin: const EdgeInsets.only(top: 50, left: 10),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        border: Border.all(color: scheme.onSurface, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(scheme.surface),
                          overlayColor: WidgetStateProperty.all<Color>(
                              Colors.transparent),
                        ),
                        onPressed: () async {
                          if (settingsPath != '') {
                            if (Platform.isWindows) {
                              await Process.run('explorer', [settingsPath]);
                            } else if (Platform.isMacOS) {
                              await Process.run('open', [settingsPath]);
                            } else if (Platform.isLinux) {
                              await Process.run('xdg-open', [settingsPath]);
                            }
                          }
                        },
                        child: Text(
                          "Go To Output Directory",
                          style: TextStyle(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: windowSize.height / 8,
                  width: windowSize.width / 2.25,
                  margin: const EdgeInsets.only(top: 50, left: 10),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border.all(color: scheme.onSurface, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(scheme.surface),
                      overlayColor:
                          WidgetStateProperty.all<Color>(Colors.transparent),
                    ),
                    onPressed: () async {},
                    child: Text(
                      "Set Current Parameters As Template",
                      style: TextStyle(
                          color: scheme.onSurface, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Change Theme
                Container(
                  margin: EdgeInsets.only(top: windowSize.height / 8),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      value: isDark,
                      onChanged: (bool newValue) {
                        setState(() {
                          isDark = !isDark;
                          colorUpdated = true;
                          currentTheme = isDark ? darkTheme : lightTheme;
                        });
                      },
                      thumbColor:
                          WidgetStateProperty.all<Color>(scheme.primary),
                      inactiveThumbColor: scheme.primary,
                      activeTrackColor: scheme.onSurface,
                      inactiveTrackColor: scheme.onSurface,
                      trackOutlineColor:
                          WidgetStateProperty.all<Color>(scheme.onSurface),
                      thumbIcon: WidgetStateProperty.all<Icon?>(
                        Icon(
                          isDark ? Icons.nightlight_round : Icons.wb_sunny,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
