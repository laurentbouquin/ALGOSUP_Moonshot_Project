import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:convert';

void convertLocalsToFullExtension(
    String name,
    String extension,
    String description,
    String version,
    String publisherName,
    List<String> categories,
    String iconPath) async {
  // Get the path of the project
  final dir = await getApplicationDocumentsDirectory();
  String projectPath =
      '${dir.path}\\GitHub\\Moonshot_Docs\\ALGOSUP_Moonshot_Project\\app\\vsce_extensions_creator\\lib';

  // Create the extension folder
  Directory('$projectPath\\out\\$name').createSync(recursive: true);

  // Create the package.json file
  final pkg = File('${'$projectPath\\out\\$name'}\\package.json');
  if (!pkg.existsSync()) {
    pkg.createSync();
  }

  // Generate the package.json file's content
  final pkgData =
      generatePackageJson(name, extension, description, version, publisherName, categories);

  // Write the package.json file
  await pkg.writeAsString(pkgData);

  // Create the .vscodeignore file
  final vscodeIgnore = File('${'$projectPath\\out\\$name'}\\.vscodeignore');
  if (!vscodeIgnore.existsSync()) {
    vscodeIgnore.createSync();
  }

  // Generate the .vscodeignore file's content
  final vscodeIgnoreData = generateVSCodeIgnore();

  // Write the .vscodeignore file
  await vscodeIgnore.writeAsString(vscodeIgnoreData);

  // Create the launch.json file
  final launchJson =
      File('${'$projectPath\\out\\$name'}\\.vscode\\launch.json');
  if (!launchJson.existsSync()) {
    launchJson.createSync(recursive: true);
  }

  // Generate the launch.json file's content
  final launchJsonData = generateLaunchJson();

  // Write the launch.json file
  await launchJson.writeAsString(launchJsonData);

  // Create the README.md file
  final readme = File('${'$projectPath\\out\\$name'}\\README.md');
  if (!readme.existsSync()) {
    readme.createSync();
  }

  // Generate the README.md file's content
  final readmeData = generateREADME('');

  // Write the README.md file
  await readme.writeAsString(readmeData);

  // Create the CHANGELOG.md file
  final changeLog = File('${'$projectPath\\out\\$name'}\\CHANGELOG.md');
  if (!changeLog.existsSync()) {
    changeLog.createSync();
  }

  // Generate the CHANGELOG.md file's content
  final changeLogData = generateChangeLog('');

  // Write the CHANGELOG.md file
  await changeLog.writeAsString(changeLogData);

  // Create the vsc-extension-quickstart.md file
  final quickStart =
      File('${'$projectPath\\out\\$name'}\\vsc-extension-quickstart.md');
  if (!quickStart.existsSync()) {
    quickStart.createSync();
  }

  // Generate the vsc-extension-quickstart.md file's content
  final quickStartData = generateQuickStart('');

  // Write the vsc-extension-quickstart.md file
  await quickStart.writeAsString(quickStartData);

  // Create the icon.json file
  if (iconPath != '') {
    final icon = File('${'$projectPath\\out\\$name'}\\.vscode\\icon.json');
    if (!icon.existsSync()) {
      icon.createSync();
    }

    // Generate the icon.json file's content
    final iconData = generateIcon(iconPath);

    // Write the icon.json file
    await icon.writeAsString(iconData);
  }

  // Create the language-configuration.json file
  final languageConfiguration =
      File('${'$projectPath\\out\\$name'}\\language-configuration.json');
  if (!languageConfiguration.existsSync()) {
    languageConfiguration.createSync();
  }

  // Generate the language-configuration.json file's content
  final languageConfigurationData = await generateLanguageConfigurationJSON();

  // Write the language-configuration.json file
  await languageConfiguration.writeAsString(languageConfigurationData);

  // Create the syntaxes folder
  Directory('${'$projectPath\\out\\$name'}\\syntaxes').createSync();

  // Create the syntaxes file
  final syntax = File(
      '${'$projectPath\\out\\$name'}\\syntaxes\\$extension.tmLanguage.json');
  if (!syntax.existsSync()) {
    syntax.createSync();
  }

  // Generate the syntaxes file's content
  final syntaxData = await generateSyntax(extension);

  // Write the syntaxes file
  await syntax.writeAsString(syntaxData);




  // Create the themes folder
  Directory('${'$projectPath\\out\\$name'}\\themes').createSync();

  // Create the themes file
  final theme = File(
      '${'$projectPath\\out\\$name'}\\themes\\$extension.thTheme.json');
  if (!theme.existsSync()) {
    theme.createSync();
  }

  // Generate the themes file's content
  final themeData = await generateTheme(name);

  // Write the themes file
  await theme.writeAsString(themeData);
}

String generatePackageJson(String name, String extension, String description,
    String version, String publisherName, List<String> categories) {
  return '''
{
  "name": "$name",
  "displayName": "$name",
  "description": "$description",
  "version": "$version",
  "publisher": "$publisherName",
  "engines": {
    "vscode": "^1.92.0"
  },
  "categories": [
    ${categories.map((e) => '"$e"').join(', ')}
  ],
  "contributes": {
    "languages": [{
      "id": "$extension",
      "aliases": ["TBD", "$extension"],
      "extensions": ["$extension"],
      "configuration": "./language-configuration.json"
    }],
    "grammars": [{
      "language": "$extension",
      "scopeName": "source.$extension",
      "path": "./syntaxes/$extension.tmLanguage.json"
    }]
  }
}''';
}

String generateVSCodeIgnore() {
  return '''
.vscode/**
.vscode-test/**
.gitignore
vsc-extension-quickstart.md
''';
}

String generateLaunchJson() {
  return '''
// A launch configuration that launches the extension inside a new window
// Use IntelliSense to learn about possible attributes.
// Hover to view descriptions of existing attributes.
// For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
{
	"version": "0.2.0",
	"configurations": [
		{
			"name": "Extension",
			"type": "extensionHost",
			"request": "launch",
			"args": [
				"--extensionDevelopmentPath=\${workspaceFolder}"
			]
		}
	]
}
''';
}

String generateREADME(String readmeContent) {
  if (readmeContent == '') {
    readmeContent = '''
# tbd README

This is the README for your extension "tbd". After writing up a brief description, we recommend including the following sections.

## Features

Describe specific features of your extension including screenshots of your extension in action. Image paths are relative to this README file.

For example if there is an image subfolder under your extension project workspace:

![feature X](images/feature-x.png)

> Tip: Many popular extensions utilize animations. This is an excellent way to show off your extension! We recommend short, focused animations that are easy to follow.

## Requirements

If you have any requirements or dependencies, add a section describing those and how to install and configure them.

## Extension Settings

Include if your extension adds any VS Code settings through the `contributes.configuration` extension point.

For example:

This extension contributes the following settings:

* `myExtension.enable`: Enable/disable this extension.
* `myExtension.thing`: Set to `blah` to do something.

## Known Issues

Calling out known issues can help limit users opening duplicate issues against your extension.

## Release Notes

Users appreciate release notes as you update your extension.

### 1.0.0

Initial release of ...

### 1.0.1

Fixed issue #.

### 1.1.0

Added features X, Y, and Z.

---

## Working with Markdown

You can author your README using Visual Studio Code. Here are some useful editor keyboard shortcuts:

* Split the editor (`Cmd+` on macOS or `Ctrl+` on Windows and Linux).
* Toggle preview (`Shift+Cmd+V` on macOS or `Shift+Ctrl+V` on Windows and Linux).
* Press `Ctrl+Space` (Windows, Linux, macOS) to see a list of Markdown snippets.

## For more information

* [Visual Studio Code's Markdown Support](http://code.visualstudio.com/docs/languages/markdown)
* [Markdown Syntax Reference](https://help.github.com/articles/markdown-basics/)

**Enjoy!**
''';
  }
  return '''
$readmeContent
''';
}

String generateChangeLog(String changeLogContent) {
  if (changeLogContent == '') {
    changeLogContent = '''
# Change Log

All notable changes to the "tbd" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.

## [Unreleased]

- Initial release''';
  }

  return '''
$changeLogContent
''';
}

String generateQuickStart(String quickStartContent) {
  if (quickStartContent == '') {
    quickStartContent = '''
# Welcome to your VS Code Extension

## What's in the folder

* This folder contains all of the files necessary for your extension.
* `package.json` - this is the manifest file in which you declare your language support and define the location of the grammar file that has been copied into your extension.
* `syntaxes/tbd.tmLanguage.json` - this is the Text mate grammar file that is used for tokenization.
* `language-configuration.json` - this is the language configuration, defining the tokens that are used for comments and brackets.

## Get up and running straight away

* Make sure the language configuration settings in `language-configuration.json` are accurate.
* Press `F5` to open a new window with your extension loaded.
* Create a new file with a file name suffix matching your language.
* Verify that syntax highlighting works and that the language configuration settings are working.

## Make changes

* You can relaunch the extension from the debug toolbar after making changes to the files listed above.
* You can also reload (`Ctrl+R` or `Cmd+R` on Mac) the VS Code window with your extension to load your changes.

## Add more language features

* To add features such as IntelliSense, hovers and validators check out the VS Code extenders documentation at https://code.visualstudio.com/docs

## Install your extension

* To start using your extension with Visual Studio Code copy it into the `<user home>/.vscode/extensions` folder and restart Code.
* To share your extension with the world, read on https://code.visualstudio.com/docs about publishing an extension.
''';
  }

  return '''
$quickStartContent
''';
}

String generateIcon(imgPath) {
  return '''
{
	"iconDefinitions": {
		"_file": {
			"iconPath": "$imgPath"
		}
	},
	"file": "_file"
}
''';
}

Future<String> generateLanguageConfigurationJSON() async {
  List<String> singleLineComments = ['"//"', '"#"', '"##"', "add your own"];
  List<String> multiLineComments = ['"/* */"', '"<!-- -->"', '"<!--- --->"'];

  final dir = await getApplicationDocumentsDirectory();
  File jsonFile = File(
      "${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/commentsandstrings.json");
  var jsonData = json.decode(jsonFile.readAsStringSync());
  String slc = singleLineComments[jsonData['slc']];
  String mlc = multiLineComments[jsonData['mlc']];

  String mlc1 = mlc.split(' ')[0];
  String mlc2 = mlc.split(' ')[1];

  debugPrint('SLC: $slc / MLC: $mlc1 - $mlc2');

  return '''
{
    "comments": {
        // symbol used for single line comment. Remove this entry if your language does not support line comments
        "lineComment": $slc,
        // symbols used for start and end a block comment. Remove this entry if your language does not support block comments
        "blockComment": [ $mlc1, $mlc2 ]
    },
    // symbols used as brackets
    "brackets": [
        ["{", "}"],
        ["[", "]"],
        ["(", ")"]
    ],
    // symbols that are auto closed when typing
    "autoClosingPairs": [
        ["{", "}"],
        ["[", "]"],
        ["(", ")"],
        ["\\"", "\\""],
        ["'", "'"]
    ],
    // symbols that can be used to surround a selection
    "surroundingPairs": [
        ["{", "}"],
        ["[", "]"],
        ["(", ")"],
        ["\\"", "\\""],
        ["'", "'"]
    ]
}
''';
}

Future<String> generateSyntax(String extension) async {
  final dir = await getApplicationDocumentsDirectory();
  File jsonFile = File(
      "${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/format.json");
  var jsonData = json.decode(jsonFile.readAsStringSync());
  List<String> keywords = jsonData['keywords'].cast<String>();

  return '''
{
	"\$schema": "https://raw.githubusercontent.com/martinring/tmlanguage/master/tmlanguage.json",
	"name": "$extension",
	"patterns": [
		{
			"include": "#keywords"
		},
		{
			"include": "#const"
		},
		{
			"include": "#comment"
		},
		{
			"include": "#label"
		},
		{
			"include": "#strings"
		}
	],
	"repository": {
		"keywords": {
			"patterns": [
				{
					"name": "keyword.$extension",
					"match": "(?i)\\\\b(${keywords.map((e) => e).join('|')})\\\\b"
				}
			]
		},
		"comment": {
			"patterns": [
				{
					"name": "comment.$extension",
					"match": "(//).*\\\\n?"
				}
			]
		},
		"const": {
			"patterns": [
				{
					"name": "constant.other.$extension",
					"match": "(\\\\..*).*\\\\n?"
				}
			]
		},
		"strings": {
			"name": "string.quoted.double.$extension",
			"begin": "\\"",
			"end": "\\"",
			"patterns": [
				{
					"name": "constant.character.escape.$extension",
					"match": "\\\\\\\\."
				}
			]
		},
		"label":{
			"patterns":[
				{
					"name":"label.$extension",
					"match":"(\\\\w+:).*\\\\n?"
				}
			]
		}
	},
	"scopeName": "source.$extension"
}
''';
}

Future<String> generateTheme(String name) async {
  final dir = await getApplicationDocumentsDirectory();

  List<String> colorsIds = ["#ffffff", "#000000", "#2196f3", "#9c27b0", "#ff9800", "#4caf50"];

  File jsonFile = File(
      "${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/theming.json");
  var jsonData = json.decode(jsonFile.readAsStringSync());

  String background = colorsIds[jsonData['bgColor']];
  String keywords = colorsIds[jsonData['keywordColor']];
  String functions = colorsIds[jsonData['functionColor']];
  String strings = colorsIds[jsonData['stringColor']];
  String comments = colorsIds[jsonData['commentColor']];
  String variables = colorsIds[jsonData['variableColor']];
  String common = colorsIds[jsonData['commonColor']];

  return '''
{
	"name": "$name",
	"colors": {
		"editor.background": "#f5f5f5",
		"editor.foreground": "$background",
        "list.activeSelectionIconForeground": "#fff"
	},
	"tokenColors": [
		{
			"name": "Comments",
			"scope": [
				"comment",
				"punctuation.definition.comment"
			],
			"settings": {
				"fontStyle": "italic",
				"foreground": "$comments"
			}
		},
		{
			"name": "Comments: Preprocessor",
			"scope": "comment.block.preprocessor",
			"settings": {
				"fontStyle": "",
				"foreground": "#AAAAAA"
			}
		},
		{
			"name": "Comments: Documentation",
			"scope": [
				"comment.documentation",
				"comment.block.documentation"
			],
			"settings": {
				"foreground": "#448C27"
			}
		},
		{
			"name": "Invalid - Illegal",
			"scope": "invalid.illegal",
			"settings": {
				"foreground": "#660000"
			}
		},
		{
			"name": "Operators",
			"scope": "keyword.operator",
			"settings": {
				"foreground": "$common"
			}
		},
		{
			"name": "Keywords",
			"scope": [
				"keyword",
				"storage"
			],
			"settings": {
				"foreground": "$keywords"
			}
		},
		{
			"name": "Types",
			"scope": [
				"storage.type",
				"support.type"
			],
			"settings": {
				"foreground": "$keywords"
			}
		},
		{
			"name": "Language Constants",
			"scope": [
				"constant.language",
				"support.constant",
				"variable.language"
			],
			"settings": {
				"foreground": "#AB6526"
			}
		},
		{
			"name": "Variables",
			"scope": [
				"variable",
				"support.variable"
			],
			"settings": {
				"foreground": "$variables"
			}
		},
		{
			"name": "Functions",
			"scope": [
				"entity.name.function",
				"support.function"
			],
			"settings": {
				"fontStyle": "bold",
				"foreground": "$functions"
			}
		},
		{
			"name": "Classes",
			"scope": [
				"entity.name.type",
				"entity.other.inherited-class",
				"support.class"
			],
			"settings": {
				"fontStyle": "bold",
				"foreground": "#7A3E9D"
			}
		},
		{
			"name": "Exceptions",
			"scope": "entity.name.exception",
			"settings": {
				"foreground": "#660000"
			}
		},
		{
			"name": "Sections",
			"scope": "entity.name.section",
			"settings": {
				"fontStyle": "bold"
			}
		},
		{
			"name": "Numbers, Characters",
			"scope": [
				"constant.numeric",
				"constant.character",
				"constant"
			],
			"settings": {
				"foreground": "$common"
			}
		},
		{
			"name": "Strings",
			"scope": "string",
			"settings": {
				"foreground": "$strings"
			}
		},
		{
			"name": "Strings: Escape Sequences",
			"scope": "constant.character.escape",
			"settings": {
				"foreground": "#777777"
			}
		},
		{
			"name": "Strings: Regular Expressions",
			"scope": "string.regexp",
			"settings": {
				"foreground": "#4B83CD"
			}
		},
		{
			"name": "Strings: Symbols",
			"scope": "constant.other.symbol",
			"settings": {
				"foreground": "$common"
			}
		},
		{
			"name": "Punctuation",
			"scope": "punctuation",
			"settings": {
				"foreground": "$common"
			}
		},
		{
			"name": "HTML: Doctype Declaration",
			"scope": [
				"meta.tag.sgml.doctype",
				"meta.tag.sgml.doctype string",
				"meta.tag.sgml.doctype entity.name.tag",
				"meta.tag.sgml punctuation.definition.tag.html"
			],
			"settings": {
				"foreground": "#AAAAAA"
			}
		},
		{
			"name": "HTML: Tags",
			"scope": [
				"meta.tag",
				"punctuation.definition.tag.html",
				"punctuation.definition.tag.begin.html",
				"punctuation.definition.tag.end.html"
			],
			"settings": {
				"foreground": "#91B3E0"
			}
		},
		{
			"name": "HTML: Tag Names",
			"scope": "entity.name.tag",
			"settings": {
				"foreground": "#4B83CD"
			}
		},
		{
			"name": "HTML: Attribute Names",
			"scope": [
				"meta.tag entity.other.attribute-name",
				"entity.other.attribute-name.html"
			],
			"settings": {
				"fontStyle": "italic",
				"foreground": "#91B3E0"
			}
		},
		{
			"name": "HTML: Entities",
			"scope": [
				"constant.character.entity",
				"punctuation.definition.entity"
			],
			"settings": {
				"foreground": "#AB6526"
			}
		},
		{
			"name": "CSS: Selectors",
			"scope": [
				"meta.selector",
				"meta.selector entity",
				"meta.selector entity punctuation",
				"entity.name.tag.css"
			],
			"settings": {
				"foreground": "#7A3E9D"
			}
		},
		{
			"name": "CSS: Property Names",
			"scope": [
				"meta.property-name",
				"support.type.property-name"
			],
			"settings": {
				"foreground": "#AB6526"
			}
		},
		{
			"name": "CSS: Property Values",
			"scope": [
				"meta.property-value",
				"meta.property-value constant.other",
				"support.constant.property-value"
			],
			"settings": {
				"foreground": "#448C27"
			}
		},
		{
			"name": "CSS: Important Keyword",
			"scope": "keyword.other.important",
			"settings": {
				"fontStyle": "bold"
			}
		},
		{
			"name": "Markup: Changed",
			"scope": "markup.changed",
			"settings": {
				"foreground": "#000000"
			}
		},
		{
			"name": "Markup: Deletion",
			"scope": "markup.deleted",
			"settings": {
				"foreground": "#000000"
			}
		},
		{
			"name": "Markup: Emphasis",
			"scope": "markup.italic",
			"settings": {
				"fontStyle": "italic"
			}
		},
		{
			"name": "Markup: Error",
			"scope": "markup.error",
			"settings": {
				"foreground": "#660000"
			}
		},
		{
			"name": "Markup: Insertion",
			"scope": "markup.inserted",
			"settings": {
				"foreground": "#000000"
			}
		},
		{
			"name": "Markup: Link",
			"scope": "meta.link",
			"settings": {
				"foreground": "#4B83CD"
			}
		},
		{
			"name": "Markup: Output",
			"scope": [
				"markup.output",
				"markup.raw"
			],
			"settings": {
				"foreground": "#777777"
			}
		},
		{
			"name": "Markup: Prompt",
			"scope": "markup.prompt",
			"settings": {
				"foreground": "#777777"
			}
		},
		{
			"name": "Markup: Heading",
			"scope": "markup.heading",
			"settings": {
				"foreground": "#AA3731"
			}
		},
		{
			"name": "Markup: Strong",
			"scope": "markup.bold",
			"settings": {
				"fontStyle": "bold"
			}
		},
		{
			"name": "Markup: Traceback",
			"scope": "markup.traceback",
			"settings": {
				"foreground": "#660000"
			}
		},
		{
			"name": "Markup: Underline",
			"scope": "markup.underline",
			"settings": {
				"fontStyle": "underline"
			}
		},
		{
			"name": "Markup Quote",
			"scope": "markup.quote",
			"settings": {
				"foreground": "#7A3E9D"
			}
		},
		{
			"name": "Markup Lists",
			"scope": "markup.list",
			"settings": {
				"foreground": "#4B83CD"
			}
		},
		{
			"name": "Markup Styling",
			"scope": [
				"markup.bold",
				"markup.italic"
			],
			"settings": {
				"foreground": "#448C27"
			}
		},
		{
			"name": "Markup Inline",
			"scope": "markup.inline.raw",
			"settings": {
				"fontStyle": "",
				"foreground": "#AB6526"
			}
		},
		{
			"name": "Extra: Diff Range",
			"scope": [
				"meta.diff.range",
				"meta.diff.index",
				"meta.separator"
			],
			"settings": {
				"foreground": "#434343"
			}
		},
		{
			"name": "Extra: Diff From",
			"scope": "meta.diff.header.from-file",
			"settings": {
				"foreground": "#434343"
			}
		},
		{
			"name": "Extra: Diff To",
			"scope": "meta.diff.header.to-file",
			"settings": {
				"foreground": "#434343"
			}
		}
	]
}

''';
}
