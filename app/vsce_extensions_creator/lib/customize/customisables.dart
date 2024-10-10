import 'dart:math';

import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'dart:convert';

// import pages
import 'format.dart';
import 'theme.dart';
import 'miscellaneous.dart';
import 'comments&strings.dart';
import 'functionalities.dart';
import '../functionals/convert.dart';
import '../functionals/constants.dart';

class Customisables extends StatefulWidget {
  const Customisables({super.key, required this.extensionIndex});

  final int extensionIndex;

  @override
  State<Customisables> createState() =>
      _CustomisablesState(extensionIndex: extensionIndex);
}

class _CustomisablesState extends State<Customisables> {
  _CustomisablesState({required this.extensionIndex});

  int extensionIndex;
  bool isMenuOpen = false;

  int indexOfPage = 0;

  String outputPath = "";
  String extensionName = "";
  String extensionFileName = "";
  String extensionDescription = "";
  String extensionVersion = "";
  String publisherName = "";
  String category = "";

  @override
  void initState() {
    super.initState();
    var settingsData = json.decode(settingsFile.readAsStringSync());

    outputPath = settingsData['outputDirectory'];

    var extensionsData = json.decode(extensionsFile.readAsStringSync());

    extensionName = extensionsData['extensions'][extensionIndex]['name'];
    extensionDescription =
        extensionsData['extensions'][extensionIndex]['description'];
    extensionVersion = extensionsData['extensions'][extensionIndex]['version'];
    category = extensionsData['extensions'][extensionIndex]['category'];
    publisherName = extensionsData['extensions'][extensionIndex]['publisher'];
    extensionFileName =
        extensionsData['extensions'][extensionIndex]['extensionFileName'];
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 0
                                ? theme.secondary
                                : theme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                indexOfPage = 0;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Text(
                              "Format",
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 1
                                ? theme.secondary
                                : theme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                indexOfPage = 1;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Text(
                              "Theme",
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 2
                                ? theme.secondary
                                : theme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: null,
                            // onPressed: () {
                            //   setState(() {
                            //     indexOfPage = 2;
                            //   });
                            // },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Snippets",
                                  style: TextStyle(
                                    // color: theme.onSurface,
                                    color: theme.onPrimary,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.014,
                                  ),
                                ),
                                Text(
                                  "    (Comming Soon)",
                                  style: TextStyle(
                                    color: theme.onPrimary,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.014,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 3
                                ? theme.secondary
                                : theme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                indexOfPage = 3;
                              });
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Text(
                              "Comments & Strings",
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 4
                                ? theme.secondary
                                : theme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: theme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: null,
                            // TODO: Uncomment after adding the functionalities page.
                            // onPressed: () {
                            // setState(() {
                            //   indexOfPage = 4;
                            // });
                            // },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Functionalities",
                                  style: TextStyle(
                                    // color: theme.onSurface,
                                    color: theme.onPrimary,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.014,
                                  ),
                                ),
                                Text(
                                  "    (Comming Soon)",
                                  style: TextStyle(
                                    color: theme.onPrimary,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.014,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 7.5,
                  decoration: BoxDecoration(
                    color: theme.surface,
                  ),
                  child: indexOfPage == 0
                      ? const FormatPage(
                          extensionIndex: 0,
                        )
                      : indexOfPage == 1
                          ? const ThemePage()
                          : indexOfPage == 2
                              ? const MisceleanousPage()
                              : indexOfPage == 3
                                  ? const CommentsAndStringsPage()
                                  : indexOfPage == 4
                                      ? const FunctionalitiesPage()
                                      : Container(),
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.73,
                  right: MediaQuery.of(context).size.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: theme.surface,
                      foregroundColor: theme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: theme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'publish',
                      onPressed: isMenuOpen ? null : null,
                      tooltip: isMenuOpen ? 'Publish' : null,
                      child: const Icon(Icons.publish_rounded),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.48,
                  right: MediaQuery.of(context).size.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: theme.surface,
                      foregroundColor: theme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: theme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'save',
                      onPressed: isMenuOpen
                          ? () {
                              convertLocalsToFullExtension(
                                  extensionName,
                                  extensionFileName,
                                  extensionDescription,
                                  extensionVersion,
                                  publisherName,
                                  category,
                                  "",
                                  false,
                                  outputPath);
                              Navigator.pop(context);
                            }
                          : null,
                      tooltip: isMenuOpen ? 'Save' : null,
                      child: const Icon(Icons.save),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.29,
                  right: MediaQuery.of(context).size.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: theme.surface,
                      foregroundColor: theme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: theme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'cancel',
                      onPressed: isMenuOpen ? () {} : null,
                      tooltip: isMenuOpen ? "Cancel" : null,
                      child: const Icon(Icons.cancel),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        foregroundColor: theme.onSurface,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: theme.onSurface),
            borderRadius: BorderRadius.circular(10)),
        heroTag: 'menu',
        onPressed: () {
          setState(() {
            isMenuOpen = !isMenuOpen;
          });
        },
        tooltip: isMenuOpen ? 'Close Menu' : 'Open Menu',
        child: isMenuOpen
            ? AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: Transform.rotate(
                  angle: pi / 4,
                  child: const Icon(Icons.add),
                ),
              )
            : const Icon(Icons.add),
      ),
    );
  }
}
