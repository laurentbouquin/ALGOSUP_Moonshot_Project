// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/features/comments&strings/comments&strings_widgets.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar_view.dart';
import 'dart:convert';

// ==== Pages imports ==== //
import '../../constants/variables.dart';
import '../../constants/links.dart';

class CommentsAndStringsPage extends StatefulWidget {
  const CommentsAndStringsPage({super.key});

  static const String routeName = '/commentsAndStringsPage';

  @override
  State<CommentsAndStringsPage> createState() => _CommentsAndStringsPageState();
}

class _CommentsAndStringsPageState extends State<CommentsAndStringsPage> {
  _CommentsAndStringsPageState();

  

  WindowSize windowSize = WindowSize();

  @override
  void initState() {
    super.initState();
    var commentsandstringsData = json.decode(commentsAndStringsFile.readAsStringSync());
    setState(() {
      valuesIndex[0] = commentsandstringsData["extensions"][currentExtensionIndex]['slc'];
      valuesIndex[1] = commentsandstringsData["extensions"][currentExtensionIndex]['mlc'];
      valuesIndex[2] = commentsandstringsData["extensions"][currentExtensionIndex]['quotes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    double usableWidth = windowSize.width - windowSize.width / 7;
    double usableHeight = windowSize.height - windowSize.height / 7.5;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: usableWidth / 2,
            decoration: BoxDecoration(
              color: scheme.surface,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: usableHeight / 2,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: scheme.onSurface,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '//', "Single Line Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '#', "Single Line Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '##', "Single Line Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '/* */', "Multi Lines Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '<!-- -->', "Multi Lines Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                          commentsOptionsPart(windowSize, scheme, currentExtensionIndex, '<!--- --->', "Multi Lines Comment", windowSize.width / 8, windowSize.height / 10.8, this),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: usableHeight / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      quotesOptionsPart(windowSize, scheme, currentExtensionIndex, "\"", "quotes", windowSize.width / 8, this),
                      quotesOptionsPart(windowSize, scheme, currentExtensionIndex, "'", "quotes", windowSize.width / 8, this),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Separator
          VerticalDivider(
            color: scheme.onSurface,
            thickness: 2,
            width: 2,
          ),

          // This part of the code is the right side of the screen and displays the selected parameters of the comments and strings customization
          Container(
            width: usableWidth / 2 - 2,
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Comments: ',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                Text(
                  valuesIndex[0] == 0
                      ? '// This is a single line comment'
                      : valuesIndex[0] == 1
                          ? '# This is a single line comment'
                          : valuesIndex[0] == 2
                              ? '## This is a single line comment'
                              : '',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.018,
                    color: Colors.green,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Text(
                  valuesIndex[1] == 0
                      ? '/* This is a multi\n lines comment */'
                      : valuesIndex[1] == 1
                          ? '<!-- This is a multi\n lines comment -->'
                          : valuesIndex[1] == 2
                              ? '<!--- This is a multi\n lines comment --->'
                              : '',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.018,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: windowSize.height * 0.04,
                ),
                Text(
                  'Strings: ',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.025,
                    color: Colors.white,
                  ),
                ),
                Text(
                  valuesIndex[2] == 0
                      ? '"Strings only with double quotes"'
                      : valuesIndex[2] == 1
                          ? '\'Strings only with single quotes\''
                          : valuesIndex[2] == 2
                              ? '"Strings with double quotes" \'and single quotes\''
                              : 'No String Style Selected',
                  style: TextStyle(
                    fontSize: windowSize.width * 0.018,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          NavBar(),
        ],
      ),
    );
  }
}
