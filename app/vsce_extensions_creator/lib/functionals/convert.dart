
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:convert';



void ConvertLocalsToFullExtension(String keywords, String theming) async {

    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    File jsonFile = File("${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/extensions_data.json");
    var extensionsData = json.decode(jsonFile.readAsStringSync());
}
