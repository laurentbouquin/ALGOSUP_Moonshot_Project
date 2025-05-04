// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// === Constants ===
const DEBUG = false;

bool isDark = false;

int index = 0;

int currentExtensionIndex = 0;

String currentPage = "/menu";

const int CATEGORIES_NUM = 8;

bool isConnected = false;

const List<String> categoriesList = [
  "Programming Languages",
  "Themes",
  "Snippets",
  "Debuggers",
  "Keymaps",
  "Testing",
  "Linters",
  "Other",

  // Not yet implemented categories
  // "Formatters",
  // "SCM Providers",
  // "Extension Packs",
  // "Language Packs",
  // "Data Science",
  // "Machine Learning",
  // "Visualization",
  // "Notebooks",
  // "Education",
];

// === Theme Colors ===

List<String> colorsList = [
  "FFFFFF",
  "FFFFFF",
  "FFFFFF",
  "FFFFFF",
  "FFFFFF",
  "FFFFFF",
  "FFFFFF",
  "FFFFFF"
];

List<String> categories = [
  "Background",
  "Keywords",
  "Functions",
  "Variables",
  "Strings",
  "Comments",
  "Operators",
  "Others"
];

List<String> names = [
  "bgColor",
  "keywordColor",
  "functionColor",
  "variableColor",
  "stringColor",
  "commentColor",
  "commonColor",
  "otherColor"
];

// === Comments & Strings ===

List<List<String>> values = [
  ['"//"', '"#"', '"##"'],
  ['"/* */"', '"<!-- -->"', '"<!--- --->"'],
  ['only "" accepted', 'only \'\' accepted', '"" and \'\' accepted'],
];
List<int> valuesIndex = [
  0,
  0,
  0,
];

bool checkbox1 = true;
bool checkbox2 = false;

// === end Constants ===

// === Colors ===

bool colorUpdated = false;

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffefefef),
    onPrimary: Color(0xff000000),
    secondary: Color(0xffcccccc),
    onSecondary: Color(0xff000000),
    tertiary: Color(0xfff3f3f3),
    onTertiary: Color(0xff000000),
    surface: Color(0xffEDF6F9),
    onSurface: Color(0xFF006d77),
    error: Color(0xffB00020),
    onError: Color(0xffFFFFFF),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff1F1F1F),
    onPrimary: Color(0xffFFFFFF),
    secondary: Color(0xff434343),
    onSecondary: Color(0xffFFFFFF),
    surface: Color(0xff332E3C),
    onSurface: Color(0xFFD8D6F2),
    error: Color(0xffB00020),
    onError: Color(0xffFFFFFF),
  ),
);

ThemeData currentTheme = isDark ? darkTheme : lightTheme;

// Define the color scheme

// :root {
// 	--bg: #0f0f0f;
// 	--on-bg: #f0f0f0;
// 	--primary: #1f1f1f;
// 	--on-primary: #f0f0f0;
// 	--primary-button: #a2a2a2;
// 	--secondary: #BF94FF;
// 	--on-secondary: #f0f0f0;
// 	--tertiary: #8636ff;
// 	--on-tertiary: #f0f0f0;
// }

// :root[data-theme="light"] {
// 	--bg: #ffffff;
// 	--on-bg: #616161;
// 	--primary: #f3f3f3;
// 	--on-primary: #616166;
// 	--primary-button: #2a2a2a;
// 	--secondary: #2c2c2c;
// 	--on-secondary: #808080;
// 	--tertiary: #ffffff;
// 	--on-tertiary: #616161;
// }


// ThemeData lightTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     brightness: Brightness.light,
//     primary: Color(0xffefefef),
//     onPrimary: Color(0xff000000),
//     secondary: Color(0xffcccccc),
//     onSecondary: Color(0xff000000),
//     surface: Color(0xffEDF6F9),
//     onSurface: Color(0xFF006d77),
//     error: Color(0xffB00020),
//     onError: Color(0xffFFFFFF),
//   ),
// );

// ThemeData darkTheme = ThemeData(
//   colorScheme: const ColorScheme(
//     brightness: Brightness.dark,
//     primary: Color(0xff1F1F1F),
//     onPrimary: Color(0xffFFFFFF),
//     secondary: Color(0xff434343),
//     onSecondary: Color(0xffFFFFFF),
//     surface: Color(0xff332E3C),
//     onSurface: Color(0xFFD8D6F2),
//     error: Color(0xffB00020),
//     onError: Color(0xffFFFFFF),
//   ),
// );