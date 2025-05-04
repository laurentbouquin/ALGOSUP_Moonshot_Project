// This file contains all the classes used in the application



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

  Extension(
      {this.name = '',
      this.description = '',
      this.version = '',
      this.publisherName = '',
      this.extensionFileName = '',

      // Default value for categories
      Categories? categories})
      : categories = categories ?? Categories();
}
