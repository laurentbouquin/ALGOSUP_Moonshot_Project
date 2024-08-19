import 'dart:math';

import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

// import pages
import 'format.dart';
import 'theme.dart';
import 'miscellaneous.dart';
import 'comments&strings.dart';
import 'functionalities.dart';

class Customisables extends StatefulWidget {
  const Customisables({super.key});

  @override
  State<Customisables> createState() => _CustomisablesState();
}

class _CustomisablesState extends State<Customisables> {
  bool isMenuOpen = false;

  int indexOfPage = 0;

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
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: indexOfPage == 0
                                ? theme.surfaceContainer
                                : theme.surface,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              left: BorderSide(
                                color: theme.outline,
                                width: 1,
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
                                color: theme.onSurface,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: indexOfPage == 1
                                ? theme.surfaceContainer
                                : theme.surface,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: theme.outline,
                                width: 1,
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
                                color: theme.onSurface,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: indexOfPage == 2
                                ? theme.surfaceContainer
                                : theme.surface,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                indexOfPage = 2;
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
                              "Miscellaneous",
                              style: TextStyle(
                                color: theme.onSurface,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
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
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: indexOfPage == 3
                                ? theme.surfaceContainer
                                : theme.surface,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              left: BorderSide(
                                color: theme.outline,
                                width: 1,
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
                                color: theme.onSurface,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1 / 2,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: indexOfPage == 4
                                ? theme.surfaceContainer
                                : theme.surface,
                            border: Border(
                              bottom: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              left: BorderSide(
                                color: theme.outline,
                                width: 1,
                              ),
                              right: BorderSide(
                                color: theme.outline,
                                width: 1,
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
                                    color: Colors.blueGrey[600],
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.014,
                                  ),
                                ),
                                Text(
                                  "    (Comming Soon)",
                                  style: TextStyle(
                                    color: Colors.blueGrey[600],
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
                  height: MediaQuery.of(context).size.height * 0.83,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: indexOfPage == 0
                      ? const FormatPage()
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
                  top: MediaQuery.of(context).size.height * 0.586,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      tooltip: 'Publish',
                      child: const Icon(Icons.publish_rounded),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.668,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      tooltip: 'Save',
                      child: const Icon(Icons.save),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.750,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isMenuOpen ? 1 : 0,
                    child: FloatingActionButton(
                      onPressed: () {},
                      tooltip: "Cancel",
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
        onPressed: () {
          setState(() {
            isMenuOpen = !isMenuOpen;
          });
        },
        tooltip: isMenuOpen ? null : 'Open Menu',
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
