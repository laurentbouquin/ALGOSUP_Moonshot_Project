// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/styles.dart';
import 'package:vsce_extensions_creator/src/features/comments_and_strings/comments_and_strings_widgets.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar_view.dart';
import 'dart:convert';

// ==== Pages imports ==== //
import '../../constants/variables.dart';
import '../../constants/links.dart';

class CommentsAndStringsPage extends StatefulWidget {
  const CommentsAndStringsPage({super.key});

  static const String routeName = '/CommentsAndStringsPage';

  @override
  State<CommentsAndStringsPage> createState() => _CommentsAndStringsPageState();
}

class _CommentsAndStringsPageState extends State<CommentsAndStringsPage> {
  _CommentsAndStringsPageState();

  WindowSize windowSize = WindowSize();

  @override
  void initState() {
    super.initState();
    var commentsandstringsData =
        json.decode(commentsAndStringsFile.readAsStringSync());
    setState(() {
      valuesIndex[0] =
          commentsandstringsData["extensions"][currentExtensionIndex]['slc'];
      valuesIndex[1] =
          commentsandstringsData["extensions"][currentExtensionIndex]['mlc'];
      valuesIndex[2] =
          commentsandstringsData["extensions"][currentExtensionIndex]['quotes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    double usableWidth = windowSize.width - windowSize.width / 7;
    double usableHeight = windowSize.height - windowSize.height / 15;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: usableWidth * 0.4,
            height: usableHeight,
            margin: EdgeInsets.only(
              left: windowSize.width * 0.05,
            ),
            decoration: mainCards(scheme),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: windowSize.height / 13,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  decoration: mainCardsHead(scheme),
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.0005,
                  ),
                  child: Center(
                    child: Text(
                      'Comments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: scheme.surface,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: usableHeight * 0.5 - usableHeight * 0.05,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.002,
                  ),
                  decoration: BoxDecoration(
                      color: scheme.surface,
                      border: Border.all(
                        color: scheme.onSurface,
                        width: 1,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Single Line Comments",
                              style: TextStyle(
                                fontSize: 20,
                                color: scheme.onSurface,
                              )),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '//',
                              "Single Line Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[0] == 0 ? true : false,
                              this),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '#',
                              "Single Line Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[0] == 1 ? true : false,
                              this),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '##',
                              "Single Line Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[0] == 2 ? true : false,
                              this),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Multi Lines Comments",
                              style: TextStyle(
                                fontSize: 20,
                                color: scheme.onSurface,
                              )),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '/* */',
                              "Multi Lines Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[1] == 0 ? true : false,
                              this),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '<!-- -->',
                              "Multi Lines Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[1] == 1 ? true : false,
                              this),
                          commentsOptionsPart(
                              scheme,
                              currentExtensionIndex,
                              '<!--- --->',
                              "Multi Lines Comment",
                              windowSize.width * 0.125,
                              windowSize.height * 0.06,
                              valuesIndex[1] == 2 ? true : false,
                              this),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: usableHeight * 0.5 - usableHeight * 0.053,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.002,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border.all(
                      color: scheme.onSurface,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        valuesIndex[0] == 0
                            ? '// This type of comments are\n// made one line at a time.'
                            : valuesIndex[0] == 1
                                ? '# This type of comments are\n# made one line at a time.'
                                : valuesIndex[0] == 2
                                    ? '## This type of comments are\n## made one line at a time.'
                                    : '',
                        style: TextStyle(
                          fontSize: windowSize.width * 0.018,
                          color: scheme.onSurface,
                        ),
                      ),
                      Text(
                        valuesIndex[1] == 0
                            ? '/* This type of comments\n are made as a block. */'
                            : valuesIndex[1] == 1
                                ? '<!-- This type of comments\n are made as a block. -->'
                                : valuesIndex[1] == 2
                                    ? '<!--- This type of comments\n are made as a block. --->'
                                    : '',
                        style: TextStyle(
                          fontSize: windowSize.width * 0.018,
                          color: scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: usableWidth * 0.4,
            height: usableHeight,
            decoration: mainCards(scheme),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: windowSize.height * 0.08,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  decoration: mainCardsHead(scheme),
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.002,
                  ),
                  child: Center(
                    child: Text(
                      'Strings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: scheme.surface,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: usableHeight * 0.5 - usableHeight * 0.056,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.002,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border.all(
                      color: scheme.onSurface,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      quotesOptionsPart(
                          scheme,
                          currentExtensionIndex,
                          "\"string example\"",
                          "quotes",
                          windowSize.width * 0.25,
                          this),
                      quotesOptionsPart(
                          scheme,
                          currentExtensionIndex,
                          "'string example'",
                          "quotes",
                          windowSize.width * 0.25,
                          this),
                    ],
                  ),
                ),
                Container(
                  height: usableHeight * 0.5 - usableHeight * 0.053,
                  width: usableWidth * 0.4 - usableWidth * 0.008,
                  margin: EdgeInsets.only(
                    top: windowSize.width * 0.002,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border.all(
                      color: scheme.onSurface,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'A string can be formed by: ',
                        style: TextStyle(
                          fontSize: windowSize.width * 0.018,
                          color: scheme.onSurface,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            valuesIndex[2] == 0
                                ? '"double"'
                                : valuesIndex[2] == 1
                                    ? "'single'"
                                    : valuesIndex[2] == 2
                                        ? '"double" and \'single\''
                                        : '',
                            style: TextStyle(
                              fontSize: windowSize.width * 0.018,
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            valuesIndex[2] == 0 || valuesIndex[2] == 1
                                ? ' quotes only.'
                                : valuesIndex[2] == 2
                                    ? ' quotes.'
                                    : 'No String Style Selected',
                            style: TextStyle(
                              fontSize: windowSize.width * 0.018,
                              color: scheme.onSurface,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          NavBar(state: this),
        ],
      ),
    );
  }
}
