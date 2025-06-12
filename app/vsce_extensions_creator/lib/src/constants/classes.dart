// This file contains all the classes used in the application

import 'dart:convert';

import 'package:vsce_extensions_creator/src/constants/links.dart';

/// Class to store the theming information such as background color, keyword color, function color, variable color, string color, comment color, common color and other color
class Theming {
  String bgColor;
  String keywordColor;
  String functionColor;
  String variableColor;
  String stringColor;
  String commentColor;
  String commonColor;
  String otherColor;

  Theming(
	  {this.bgColor = "FFFFFF",
	  this.keywordColor = "FFFFFF",
	  this.functionColor = "FFFFFF",
	  this.variableColor = "FFFFFF",
	  this.stringColor = "FFFFFF",
	  this.commentColor = "FFFFFF",
	  this.commonColor = "FFFFFF",
	  this.otherColor = "FFFFFF"});
}

/// Class to store the categories of the extension and if they are selected or not
class Categories {
  bool languages;
  bool themes;
  bool snippets;
  bool debuggers;
  bool keymaps;
  bool testing;
  bool linters;
  bool other;

  Categories({
	this.languages = false,
	this.themes = false,
	this.snippets = false,
	this.debuggers = false,
	this.keymaps = false,
	this.testing = false,
	this.linters = false,
	this.other = false,
  });
}

/// Store the window width and height
class WindowSize {
  double width;
  double height;

  WindowSize({this.width = 0, this.height = 0});
}

/// Store the information of the extension such as name, description, version, publisher name, extension file name, last update and categories selected
class Extension {
  String name = '';
  String description = '';
  String version = '';
  String publisherName = '';
  String extensionFileName = '';
  DateTime? lastUpdate;
  Categories categories;
  int? extensionIndex;

  Extension(
	  {this.name = '',
	  this.description = '',
	  this.version = '',
	  this.publisherName = '',
	  this.extensionFileName = '',
	  this.extensionIndex,

	  // Default value for categories
	  Categories? categories})
	  : categories = categories ?? Categories();

  Extension fromJson(int extensionIndex) {
	var extensionsData = json.decode(extensionsFile.readAsStringSync());
	var extensionD = extensionsData['extensions'][extensionIndex];
	this.extensionIndex = extensionIndex;
	name = extensionD['name'] ?? '';
	description = extensionD['description'] ?? '';
	version = extensionD['version'] ?? '';
	publisherName = extensionD['publisherName'] ?? '';
	extensionFileName = extensionD['extensionFileName'] ?? '';
	lastUpdate = DateTime.tryParse(extensionD['lastUpdate'] ?? '');
	categories = Categories(
	  languages: extensionD['categories'].contains("Programming Languages") ?? false,
	  themes: extensionD['categories'].contains("Themes") ?? false,
	  snippets: extensionD['categories'].contains("Snippets") ?? false,
	  debuggers: extensionD['categories'].contains("Debuggers") ?? false,
	  keymaps: extensionD['categories'].contains("Keymaps") ?? false,
	  testing: extensionD['categories'].contains("Testing") ?? false,
	  linters: extensionD['categories'].contains("Linters") ?? false,
	  other: extensionD['categories'].contains("Other") ?? false,
	);
	return this;
  }
}
