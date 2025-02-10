import 'dart:io';
import './variables.dart';

// === JSON Files ===

// Define the project directory
final dir = Directory.current.path;

// Define the address of the storage folder
String storageAddress = DEBUG
    ? '../vsce_extensions_creator/lib/utils/storage'
    : '$dir/data/flutter_assets/lib/utils/storage';

// Define the address of the settings file
File settingsFile = DEBUG
    ? File("$dir/lib/utils/storage/settings.json")
    : File("$dir/data/flutter_assets/lib/utils/storage/settings.json");

// Define the address of the extensions
File extensionsFile = DEBUG
    ? File("$dir/lib/utils/storage/extensions_list.json")
    : File("$dir/data/flutter_assets/lib/utils/storage/extensions_list.json");

// Define the address of the comments and strings
File commentsAndStringsFile = DEBUG
    ? File("$dir/lib/utils/storage/commentsandstrings.json")
    : File("$dir/data/flutter_assets/lib/utils/storage/commentsandstrings.json");

// Define the address of the format file
File formatFile = DEBUG
    ? File("$dir/lib/utils/storage/format.json")
    : File("$dir/data/flutter_assets/lib/utils/storage/format.json");

// Define the address of the theming file
File themingFile = DEBUG
    ? File("$dir/lib/utils/storage/theming.json")
    : File("$dir/data/flutter_assets/lib/utils/storage/theming.json");
