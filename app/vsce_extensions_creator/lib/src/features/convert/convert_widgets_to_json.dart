import 'dart:convert';

import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/links.dart';

Future<void> updateData(String extensionCategory, int extensionIndex,
    {String? name,
    String? description,
    String? publisher,
    String? version,
    Categories? categories,
    String? extensionFileName,
    String? outputDirectory,
    List<String>? keywords,
    List<String>? types,
    int? slc,
    int? mlc,
    int? quotes
    }) async {
  if (extensionCategory == "extensions") {
    var extensionsData = json.decode(extensionsFile.readAsStringSync());
    var extensionData = extensionsData["extensions"][extensionIndex] as Map<String, dynamic>;
    Map<String, dynamic> data = {
      'name': name ?? extensionData["name"],
      'description': description ?? extensionData["description"],
      'version': version ?? extensionData["version"],
      'categories': categories != null
          ? getCategories(categories)
          : extensionData["categories"].cast<String>(),
      'lastUpdated': DateTime.now().toString(),
      'publisher': publisher ?? extensionData["publisher"],
      'extensionFileName':
          extensionFileName ?? extensionData["extensionFileName"],
    };
    extensionsData["extensions"][extensionIndex] = data;
    String datas = jsonEncode(extensionsData);
    await writeData(
      datas,
      storageAddress,
      'extensions_list.json',
    );
  } else if (extensionCategory == "settings"){
    var settingsData = json.decode(settingsFile.readAsStringSync());
    Map<String, dynamic> data = {
      'outputDirectory': outputDirectory ?? settingsData.outputDirectory,
    };
    settingsData["extensions"][extensionIndex] = data;
    String datas = jsonEncode(settingsData);
    await writeData(
      datas,
      storageAddress,
      'settings.json',
    );
  } else if (extensionCategory == "format"){
    var formatData = json.decode(formatFile.readAsStringSync());
    var formatDataF = formatData["extensions"][extensionIndex] as Map<String, dynamic>;
    Map<String, dynamic> data = {
    "keywords": keywords ?? formatDataF["keywords"],
    "types": types ?? formatDataF["types"],
    };
    formatData["extensions"][extensionIndex] = data;
    String datas = jsonEncode(formatData);
    await writeData(
      datas,
      storageAddress,
      'format.json',
    );
  } else if (extensionCategory == "comments"){
    var commentsData = json.decode(commentsAndStringsFile.readAsStringSync());
    Map<String, dynamic> data = {
      'slc': slc ?? commentsData["extensions"][extensionIndex]["slc"],
      'mlc': mlc ?? commentsData["extensions"][extensionIndex]["mlc"],
      'quotes': quotes ?? commentsData["extensions"][extensionIndex]["quotes"],
    };
    commentsData["extensions"][extensionIndex] = data;
    String datas = jsonEncode(commentsData);
    await writeData(
      datas,
      storageAddress,
      'commentsandstrings.json',
    );
  }
}
