import 'package:flutter/material.dart';

import 'package:vsce_extensions_creator/src/constants/classes.dart';



/// Returns a list of widgets with a code example to visualize with the specified theme colors
List<Widget> textToVisualize(Theming themeColors) {
  return [
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('#include '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.functionColor}")),
          ),
        ),
        Text(
          ('<iostream>'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('using namespace '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('std;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n// Check if a number is even or odd'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commentColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('int '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('main'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.functionColor}")),
          ),
        ),
        Text(
          ('() {'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    int '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('n'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n<< '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n"Enter an integer: "'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    cin '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('>> n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    if '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('\n( n % '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n2 '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n== '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n)'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('        cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('" is even."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('    else'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('        cout '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('<< n << '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
        Text(
          ('" is odd."'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.stringColor}")),
          ),
        ),
        Text(
          (';'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('\n    return '),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.keywordColor}")),
          ),
        ),
        Text(
          ('\n0'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.variableColor}")),
          ),
        ),
        Text(
          ('\n;'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
    Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ('}'),
          style: TextStyle(
            fontSize: 22,
            color: Color(int.parse("0xFF${themeColors.commonColor}")),
          ),
        ),
      ],
    ),
  ];
}



