import 'dart:io';

import 'package:flutter/material.dart';

// === Constants ===
const DEBUG = true;

bool isDark = false;

int index = 0;

int CATEGORIESNUM = 8;

// === JSON Files ===

// Define the project directory
final dir = Directory.current.path;

// Define the address of the storage folder
String storageAddress = DEBUG
    ? '../vsce_extensions_creator/lib/storage'
    : '$dir/data/flutter_assets/lib/storage';

// Define the address of the settings file
File settingsFile = DEBUG
    ? File("$dir/lib/storage/settings.json")
    : File("$dir/data/flutter_assets/lib/storage/settings.json");

// Define the address of the extensions
File extensionsFile = DEBUG
    ? File("$dir/lib/storage/extensions_list.json")
    : File("$dir/data/flutter_assets/lib/storage/extensions_list.json");

// Define the address of the comments and strings
File commentsAndStringsFile = DEBUG
    ? File("$dir/lib/storage/commentsandstrings.json")
    : File("$dir/data/flutter_assets/lib/storage/commentsandstrings.json");

// Define the address of the format file
File formatFile = DEBUG
    ? File("$dir/lib/storage/format.json")
    : File("$dir/data/flutter_assets/lib/storage/format.json");

// Define the address of the theming file
File themingFile = DEBUG
    ? File("$dir/lib/storage/theming.json")
    : File("$dir/data/flutter_assets/lib/storage/theming.json");

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