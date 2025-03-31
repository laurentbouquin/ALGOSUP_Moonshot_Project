// ==== Built-in Imports ==== //
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';
import 'dart:convert';

// ==== Pages Imports ==== //

// Call displayable files
import '../format/format_view.dart';
import '../theme/theme_view.dart';
import '../snippets/snippets_view.dart';
import '../comments&strings/comments&strings_view.dart';
import '../functionalities/functionalities_view.dart';

// Call data files
import '../../constants/variables.dart';
import '../../constants/links.dart';
import '../../constants/classes.dart';
import '../../constants/functions.dart';

class Customizables extends StatefulWidget {
  const Customizables({super.key, required this.extensionIndex});

  final int extensionIndex;

  static const routeName = '/customizables';

  @override
  State<Customizables> createState() =>
      _CustomizablesState(extensionIndex: extensionIndex);
}

class _CustomizablesState extends State<Customizables> {
  _CustomizablesState({required this.extensionIndex});

  final int extensionIndex;
  bool isMenuOpen = false;

  int indexOfPage = 0;

  String outputPath = "";

  Extension extension = Extension();

  WindowSize windowSize = WindowSize();

  @override
  void initState() {
    super.initState();
    var settingsData = json.decode(settingsFile.readAsStringSync());

    outputPath = settingsData["extensions"][extensionIndex]['outputDirectory'];

    var extensionsData = json.decode(extensionsFile.readAsStringSync());

    extension.name = extensionsData['extensions'][extensionIndex]['name'];
    extension.description =
        extensionsData['extensions'][extensionIndex]['description'];
    extension.version = extensionsData['extensions'][extensionIndex]['version'];
    extension.categories = setCategories(extensionsData['extensions']
            [extensionIndex]['categories']
        .cast<String>());
    extension.publisherName =
        extensionsData['extensions'][extensionIndex]['publisher'];
    extension.extensionFileName =
        extensionsData['extensions'][extensionIndex]['extensionFileName'];
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Customizables page opened $extensionIndex");
    ColorScheme scheme = currentTheme.colorScheme;

    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scheme.surface,
      // Create a SizedBox to make the Stack widget inherit the size of the screen
      body: SizedBox(
        height: windowSize.height,
        child: Stack(
          children: [
            Column(
              children: [
                // This Column widget contains the navigation bar buttons
                Column(
                  children: [
                    // Contains the 3 first buttons of the navigation bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: windowSize.width * 1 / 3,
                          height: windowSize.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 0
                                ? scheme.secondary
                                : scheme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: scheme.onSurface,
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
                                color: scheme.onPrimary,
                                fontSize: windowSize.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: windowSize.width * 1 / 3,
                          height: windowSize.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 1
                                ? scheme.secondary
                                : scheme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: scheme.onSurface,
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
                                color: scheme.onPrimary,
                                fontSize: windowSize.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: windowSize.width * 1 / 3,
                          height: windowSize.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 2
                                ? scheme.secondary
                                : scheme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              top: BorderSide(
                                color: scheme.onSurface,
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
                                    // color: scheme.onSurface,
                                    color: scheme.onPrimary,
                                    fontSize: windowSize.width * 0.014,
                                  ),
                                ),
                                Text(
                                  "    (Coming Soon)",
                                  style: TextStyle(
                                    color: scheme.onPrimary,
                                    fontSize: windowSize.width * 0.014,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Contains the 2 last buttons of the navigation bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: windowSize.width * 1 / 2,
                          height: windowSize.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 3
                                ? scheme.secondary
                                : scheme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: scheme.onSurface,
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
                                color: scheme.onPrimary,
                                fontSize: windowSize.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: windowSize.width * 1 / 2,
                          height: windowSize.height / 15,
                          decoration: BoxDecoration(
                            color: indexOfPage == 4
                                ? scheme.secondary
                                : scheme.primary,
                            border: Border(
                              bottom: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              left: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                              right: BorderSide(
                                color: scheme.onSurface,
                                width: 2,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: null,
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
                                    // color: scheme.onSurface,
                                    color: scheme.onPrimary,
                                    fontSize: windowSize.width * 0.014,
                                  ),
                                ),
                                Text(
                                  "    (Coming Soon)",
                                  style: TextStyle(
                                    color: scheme.onPrimary,
                                    fontSize: windowSize.width * 0.014,
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

                // Determines which page has to be displayed depending on the index
                Container(
                  height: windowSize.height - windowSize.height / 7.5,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                  ),
                  child: indexOfPage == 0
                      ? FormatPage(
                          extensionIndex: extensionIndex,
                        )
                      : indexOfPage == 1
                          ? ThemePage(extensionIndex: extensionIndex,)
                          : indexOfPage == 2
                              ? const MiscellaneousPage()
                              : indexOfPage == 3
                                  ? CommentsAndStringsPage(
                                      extensionIndex: extensionIndex,
                                    )
                                  : indexOfPage == 4
                                      ? const FunctionalitiesPage()
                                      : Container(),
                ),
              ],
            ),

            // Contains the 3 buttons to save, publish and cancel
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Positioned(
                  top: windowSize.height / 1.73,
                  right: windowSize.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: scheme.surface,
                      foregroundColor: scheme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: scheme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'publish',
                      onPressed: isMenuOpen ? null : null,
                      tooltip: isMenuOpen ? 'Publish' : null,
                      child: const Icon(Icons.publish_rounded),
                    ),
                  ),
                ),
                Positioned(
                  top: windowSize.height / 1.48,
                  right: windowSize.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: scheme.surface,
                      foregroundColor: scheme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: scheme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'save',
                      onPressed: isMenuOpen
                          ? () {
                              // convertLocalsToFullExtension(
                              //     extension, "", false, outputPath);
                              // Navigator.pop(context);
                            }
                          : null,
                      tooltip: isMenuOpen ? 'Save' : null,
                      child: const Icon(Icons.save),
                    ),
                  ),
                ),
                Positioned(
                  top: windowSize.height / 1.29,
                  right: windowSize.width / 80,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      backgroundColor: scheme.surface,
                      foregroundColor: scheme.onSurface,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: scheme.onSurface),
                          borderRadius: BorderRadius.circular(10)),
                      heroTag: 'close',
                      onPressed: isMenuOpen
                          ? () {
                              redirectToStateless(context, '/home');
                            }
                          : null,
                      tooltip: isMenuOpen ? "close" : null,
                      child: const Icon(Icons.cancel),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      // Floating action button to open the menu to save, publish and cancel
      floatingActionButton: FloatingActionButton(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: scheme.onSurface),
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
