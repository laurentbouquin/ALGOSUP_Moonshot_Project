import 'dart:io';
import './variables.dart';

// === JSON Files ===

// Define the project directory
final dir = Directory.current.path;

// Define the address of the storage folder
String storageAddress = DEBUG
    ? '../vsce_extensions_creator/lib/src/utils/storage'
    : '$dir/data/flutter_assets/lib/src/utils/storage';

// Define the address of the settings file
File settingsFile = DEBUG
    ? File("$dir/lib/src/utils/storage/settings.json")
    : File("$dir/data/flutter_assets/lib/src/utils/storage/settings.json");

// Define the address of the extensions
File extensionsFile = DEBUG
    ? File("$dir/lib/src/utils/storage/extensions_list.json")
    : File(
        "$dir/data/flutter_assets/lib/src/utils/storage/extensions_list.json");

// Define the address of the comments and strings
File commentsAndStringsFile = DEBUG
    ? File("$dir/lib/src/utils/storage/commentsandstrings.json")
    : File(
        "$dir/data/flutter_assets/lib/src/utils/storage/commentsandstrings.json");

// Define the address of the format file
File formatFile = DEBUG
    ? File("$dir/lib/src/utils/storage/format.json")
    : File("$dir/data/flutter_assets/lib/src/utils/storage/format.json");

// Define the address of the theming file
File themingFile = DEBUG
    ? File("$dir/lib/src/utils/storage/theming.json")
    : File("$dir/data/flutter_assets/lib/src/utils/storage/theming.json");

String settingsFileName = "settings.json";
String extensionsFileName = "extensions_list.json";
String commentsAndStringsFileName = "commentsandstrings.json";
String formatFileName = "format.json";
String themingFileName = "theming.json";