import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/icons.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_json_to_files.dart';

Container navBarButton(
    IconData icon, ColorScheme scheme, String page, BuildContext context) {
  bool isCurrent = false;
  switch (icon) {
    case Icons.home_rounded:
      isCurrent = currentPage == "/menu";
      break;
    case Icons.format_align_center_rounded:
      isCurrent = currentPage == "/formatPage";
      break;
    case Icons.format_color_fill_rounded:
      isCurrent = currentPage == "/themePage";
      break;
    case Icons.snippet_folder_rounded:
      isCurrent = currentPage == "/snippetspage";
      break;
    case Icons.format_quote_rounded:
      isCurrent = currentPage == "/commentsAndStringsPage";
      break;
    case Icons.code_rounded:
      isCurrent = currentPage == "/functionalitiesPage";
      break;
    case Icons.settings_rounded:
      isCurrent = currentPage == "/extensionSettingsPage";
      break;
    default:
      isCurrent = false;
  }
  if (page != "/none") {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration:
          isCurrent ? selectedIconsDecoration(scheme) : iconsDecoration(scheme),
      child: IconButton(
        onPressed: () async {
          redirectToStateless(context, page).then((value) {});
        },
        icon: Icon(icon),
        iconSize: 30,
        color: isCurrent ? scheme.primary : scheme.onSurface,
      ),
    );
  } else {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: iconsDecoration(scheme),
      child: IconButton(
        hoverColor: Colors.transparent,
        icon: Icon(icon),
        iconSize: 30,
        color: isCurrent ? scheme.primary : scheme.onSurface,
        onPressed: () async {
          convertLocalsToFullExtension(
              Extension().fromJson(currentExtensionIndex), "", true);
          await Future.delayed(const Duration(seconds: 1));
          final TextEditingController textController = TextEditingController();
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Dialog Title"),
                content: const Text("This is the content of the dialog."),
                actions: [
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter token',
                    ),
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      String textFieldValue = textController.text;
                      Navigator.of(context).pop();
                      runCmdCommand(textFieldValue);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
