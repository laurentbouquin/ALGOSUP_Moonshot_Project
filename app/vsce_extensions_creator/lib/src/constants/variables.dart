// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// === Constants ===
const DEBUG = true;

bool isDark = false;

int index = 0;

const int CATEGORIES_NUM = 8;

// === Colors ===

bool colorUpdated = false;

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffefefef),
    onPrimary: Color(0xff000000),
    secondary: Color(0xffcccccc),
    onSecondary: Color(0xff000000),
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
