import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/icons.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/functions.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_json_to_files.dart';

MouseRegion navBarButton(IconData icon, ColorScheme scheme, String page,
    BuildContext context, WindowSize windowSize) {
  bool isCurrent = false;
  switch (icon) {
    case Icons.home_rounded:
      isCurrent = currentPage == "/menu";
      break;
    case Icons.format_align_center_rounded:
      isCurrent = currentPage == "/FormatPage";
      break;
    case Icons.format_color_fill_rounded:
      isCurrent = currentPage == "/ThemePage";
      break;
    case Icons.snippet_folder_rounded:
      isCurrent = currentPage == "/Snippetspage";
      break;
    case Icons.format_quote_rounded:
      isCurrent = currentPage == "/CommentsAndStringsPage";
      break;
    case Icons.code_rounded:
      isCurrent = currentPage == "/FunctionalitiesPage";
      break;
    case Icons.settings_rounded:
      isCurrent = currentPage == "/ExtensionSettingsPage";
      break;
    default:
      isCurrent = false;
  }
  if (page != "/none") {
    return MouseRegion(
      cursor: isCurrent
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: TapRegion(
        onTapInside: page[0] != "*" && page != currentPage
            ? (PointerDownEvent event) async {
                redirectToStateless(context, page).then((value) {});
              }
            : null,
        child: Container(
          width: windowSize.width * 0.1,
          height: windowSize.width * 0.027,
          decoration: isCurrent
              ? selectedIconsDecoration(scheme)
              : iconsDecoration(scheme),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: windowSize.width * 0.005),
              Icon(
                icon,
                size: 30,
                color: isCurrent ? scheme.primary : scheme.onSurface,
              ),
              Text(" ${page.characters.isNotEmpty &&
                        page != "/CommentsAndStringsPage" &&
                        page != "/menu" &&
                        page != "/ExtensionSettingsPage"
                    ? page
                        .replaceAll("/", "")
                        .replaceAll("Page", "")
                        .replaceAll("*", "")
                    : page == "/CommentsAndStringsPage"
                        ? "Comments & Strings"
                        : page == "/menu"
                            ? "Home"
                            : page == "/ExtensionSettingsPage"
                                ? "Extension Settings"
                                : ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? scheme.primary : scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    return MouseRegion(
      cursor: isCurrent
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: TapRegion(
        onTapInside: (PointerDownEvent event) async {
          checkForNPM();
          convertLocalsToFullExtension(
              Extension().fromJson(currentExtensionIndex), "", true);
          await Future.delayed(const Duration(seconds: 1));
          final TextEditingController textController = TextEditingController();
          await showDialog(
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
        child: Container(
          width: windowSize.width * 0.1,
          height: windowSize.width * 0.027,
          decoration: iconsDecoration(scheme),
          child: Row(
            children: [
              SizedBox(width: windowSize.width * 0.005),
              Icon(
                icon,
                size: 30,
                color: isCurrent ? scheme.primary : scheme.onSurface,
              ),
              Text(
                " Publish",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? scheme.primary : scheme.onSurface,
                  // fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
