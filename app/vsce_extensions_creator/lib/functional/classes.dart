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

