import 'dart:io';

// === Constants ===
const DEBUG = true;







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

