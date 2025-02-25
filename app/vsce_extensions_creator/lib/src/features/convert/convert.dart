import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';
import 'dart:io';
import 'dart:convert';

import '../../constants/classes.dart';

void convertLocalsToFullExtension(Extension extension, String iconPath,
    bool isThemeActive, String outputPath) async {
  // Get the path of the project
  String projectPath = outputPath;

  // Create the extension folder
  Directory('$projectPath\\out\\${extension.name}').createSync(recursive: true);

  // Create the package.json file
  final pkg = File('${'$projectPath\\out\\${extension.name}'}\\package.json');
  if (!pkg.existsSync()) {
    pkg.createSync();
  }

  // Generate the package.json file's content
  final pkgData = generatePackageJson(extension, isThemeActive);

  // Write the package.json file
  await pkg.writeAsString(pkgData);

  // Create the .vscodeignore file
  final vscodeIgnore =
      File('${'$projectPath\\out\\${extension.name}'}\\.vscodeignore');
  if (!vscodeIgnore.existsSync()) {
    vscodeIgnore.createSync();
  }

  // Generate the .vscodeignore file's content
  final vscodeIgnoreData = generateVSCodeIgnore();

  // Write the .vscodeignore file
  await vscodeIgnore.writeAsString(vscodeIgnoreData);

  // Create the launch.json file
  final launchJson =
      File('${'$projectPath\\out\\${extension.name}'}\\.vscode\\launch.json');
  if (!launchJson.existsSync()) {
    launchJson.createSync(recursive: true);
  }

  // Generate the launch.json file's content
  final launchJsonData = generateLaunchJson();

  // Write the launch.json file
  await launchJson.writeAsString(launchJsonData);

  // Create the README.md file
  final readme = File('${'$projectPath\\out\\${extension.name}'}\\README.md');
  if (!readme.existsSync()) {
    readme.createSync();
  }

  // Generate the README.md file's content
  final readmeData = generateREADME('');

  // Write the README.md file
  await readme.writeAsString(readmeData);

  // Create the CHANGELOG.md file
  final changeLog =
      File('${'$projectPath\\out\\${extension.name}'}\\CHANGELOG.md');
  if (!changeLog.existsSync()) {
    changeLog.createSync();
  }

  // Generate the CHANGELOG.md file's content
  final changeLogData = generateChangeLog('', extension.extensionFileName);

  // Write the CHANGELOG.md file
  await changeLog.writeAsString(changeLogData);

  // Create the vsc-extension-quickstart.md file
  final quickStart = File(
      '${'$projectPath\\out\\${extension.name}'}\\vsc-extension-quickstart.md');
  if (!quickStart.existsSync()) {
    quickStart.createSync();
  }

  // Generate the vsc-extension-quickstart.md file's content
  final quickStartData = generateQuickStart('', extension.extensionFileName);

  // Write the vsc-extension-quickstart.md file
  await quickStart.writeAsString(quickStartData);

  // Create the icon.json file
  if (iconPath != '') {
    final icon =
        File('${'$projectPath\\out\\${extension.name}'}\\.vscode\\icon.json');
    if (!icon.existsSync()) {
      icon.createSync();
    }

    // Generate the icon.json file's content
    final iconData = generateIcon(iconPath);

    // Write the icon.json file
    await icon.writeAsString(iconData);
  }

  // Create the language-configuration.json file
  final languageConfiguration = File(
      '${'$projectPath\\out\\${extension.name}'}\\language-configuration.json');
  if (!languageConfiguration.existsSync()) {
    languageConfiguration.createSync();
  }

  // Generate the language-configuration.json file's content
  final languageConfigurationData = await generateLanguageConfigurationJSON();

  // Write the language-configuration.json file
  await languageConfiguration.writeAsString(languageConfigurationData);

  // Create the syntaxes folder
  Directory('${'$projectPath\\out\\${extension.name}'}\\syntaxes').createSync();

  // Create the syntaxes file
  final syntax = File(
      '${'$projectPath\\out\\${extension.name}'}\\syntaxes\\${extension.extensionFileName}.tmLanguage.json');
  if (!syntax.existsSync()) {
    syntax.createSync();
  }

  // Generate the syntaxes file's content
  final syntaxData = await generateSyntax(extension.extensionFileName);

  // Write the syntaxes file
  await syntax.writeAsString(syntaxData);

/*
	// Create the themes folder
	Directory('${'$projectPath\\out\\$name'}\\themes').createSync();

	// Create the themes file
	final theme = File(
			'${'$projectPath\\out\\$name'}\\themes\\${extension.extensionFileName}.thTheme.json');
	if (!theme.existsSync()) {
		theme.createSync();
	}

	// Generate the themes file's content
	final themeData = await generateTheme(name);

	// Write the themes file
	await theme.writeAsString(themeData);
*/
}

String generatePackageJson(Extension extension, bool isThemeActive) {
  String theme = ''',
		"themes": [
			{
				"label": "${extension.name}",
				"uiTheme": "vs-dark",
				"path": "./themes/${extension.extensionFileName}.thTheme.json"
			}
		],
		"configurationDefaults": {
			"[${extension.extensionFileName}]": {
				"editor.semanticHighlighting.enabled": "configuredByTheme"
			}
		}''';

  return '''
{
	"name": "${extension.name}",
	"displayName": "${extension.name}",
	"description": "${extension.description}",
	"version": "${extension.version}",
	"publisher": "${extension.publisherName}",
	"engines": {
		"vscode": "^1.92.0"
	},
	"categories": ${getCategories(extension.categories)},
	"contributes": {
		"languages": [{
			"id": "${extension.extensionFileName}",
			"aliases": ["${extension.extensionFileName.toLowerCase()}", "${extension.extensionFileName.toUpperCase()}"],
			"extensions": ["${extension.extensionFileName}"],
			"configuration": "./language-configuration.json"
		}],
		"grammars": [{
			"language": "${extension.extensionFileName}",
			"scopeName": "source.${extension.extensionFileName}",
			"path": "./syntaxes/${extension.extensionFileName}.tmLanguage.json"
		}]
	}${isThemeActive ? theme : ''}
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
# README

As of now, this extension is still in development. Please check back later for updates.
''';
  }
  return '''
$readmeContent
''';
}

String generateChangeLog(String changeLogContent, String extension) {
  if (changeLogContent == '') {
    changeLogContent = '''
# Change Log

All notable changes to the "$extension" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.

## [Unreleased]

- Initial release''';
  }

  return '''
$changeLogContent
''';
}

String generateQuickStart(String quickStartContent, String extension) {
  if (quickStartContent == '') {
    quickStartContent = '''
# Welcome to your VS Code Extension

## What's in the folder

* This folder contains all of the files necessary for your extension.
* `package.json` - this is the manifest file in which you declare your language support and define the location of the grammar file that has been copied into your extension.
* `syntaxes/$extension.tmLanguage.json` - this is the Text mate grammar file that is used for tokenization.
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

  File jsonFile = commentsAndStringsFile;
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
				"blockComment": [ $mlc1", "$mlc2 ]
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
  File jsonFile = formatFile;
  var jsonData = json.decode(jsonFile.readAsStringSync());
  List<String> keywords = jsonData['keywords'].cast<String>();
  List<String> types = jsonData['types'].cast<String>();

  File jsonFile2 = commentsAndStringsFile;
  var jsonData2 = json.decode(jsonFile2.readAsStringSync());
  int stringType = jsonData2['quotes'];
  int multiCommentType = jsonData2['mlc'];
  String multiComment = multiCommentType == 0
      ? ''',
				{
					"begin": "/\\\\*",
					"end": "\\\\*/",
					"name": "comment.block.$extension"
				}'''
      : multiCommentType == 1
          ? ''',
				{
						"begin": "<!--",
						"end": "-->",
						"name": "comment.block.$extension"
				}'''
          : ''',
				{
						"begin": "<!---",
						"end": "--->",
						"name": "comment.block.$extension"
				}''';

  String strings = stringType == 0
      ? ''',
				{
						"begin": "\\"",
						"end": "\\"",
						"name": "string.quoted.double"
				}'''
      : stringType == 1
          ? ''',
				{
						"begin": "'",
						"end": "'",
						"name": "string.quoted.single"
				}'''
          : ''',
				{
						"begin": "'",
						"end": "'",
						"name": "string.quoted.single"
				},
				{
						"begin": "\\"",
						"end": "\\"",
						"name": "string.quoted.double"
				}''';

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
			"include": "#comments"
		},
		{
			"include": "#functions"
		},
		{
			"include": "#types"
		},
		{
			"include": "#variables"
		},
		{
			"include": "#numbers"
		}$strings
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
		"comments": {
			"patterns": [
				{
					"name": "comment.$extension",
					"match": "(//).*\\\\n?"
				}$multiComment
			]
		},
		"const": {
			"patterns": [
				{
					"name": "constant.other.$extension",
					"match": "\\\\b(true|false)\\\\b"
				}
			]
		},
		"functions": {
			"patterns": [
				{
					"name": "entity.name.function.$extension",
					"match": "\\\\w+\\\\s*\\\\(\\\\s*"
				}
			]
		},
		"types": {
			"patterns": [
				{
					"name": "storage.type.$extension",
					"match": "\\\\b(${types.map((e) => e).join('|')})\\\\b"
				}
			]
		},
		"numbers": {
			"patterns": [
				{
					"name": "constant.numeric.$extension",
					"match": "\\\\b\\\\d+\\\\b"
				}
			]
		},
		"variables": {
			"patterns": [
				{
					"name": "variable.other.$extension",
					"match": "\\\\b\\\\w+\\\\b"
				}
			]
		}
	},
	"scopeName": "source.$extension"
}
''';
}

Future<String> generateTheme(String name) async {

  List<String> colorsIds = [
    "#ffffff",
    "#000000",
    "#2196f3",
    "#9c27b0",
    "#ff9800",
    "#4caf50"
  ];

  File jsonFile = themingFile;
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
		"editor.background": "$background",
		"editor.foreground": "$common",
				"list.activeSelectionIconForeground": "#fff"
	},
	"tokenColors": [
		{
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
			"scope": "keyword.operator",
			"settings": {
				"foreground": "$common"
			}
		},
		{
			"scope": [
				"keyword",
				"storage"
			],
			"settings": {
				"foreground": "$keywords"
			}
		},
		{
			"scope": [
				"storage.type",
				"support.type"
			],
			"settings": {
				"foreground": "$keywords"
			}
		},
		{
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
			"scope": [
				"variable",
				"support.variable"
			],
			"settings": {
				"foreground": "$variables"
			}
		},
		{
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
			"scope": "entity.name.exception",
			"settings": {
				"foreground": "#660000"
			}
		},
		{
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
			"scope": "string",
			"settings": {
				"foreground": "$strings"
			}
		}
	],
	"semanticHighlighting": true
}

''';
}
