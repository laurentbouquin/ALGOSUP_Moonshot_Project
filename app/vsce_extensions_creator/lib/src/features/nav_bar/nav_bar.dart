import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/icons.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';





Container navBarButton(IconData icon, ColorScheme scheme, String page, BuildContext context) {
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
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: isCurrent ? selectedIconsDecoration(scheme) : iconsDecoration(scheme),
    child: IconButton(
      onPressed: () async{
        redirectToStateless(context, page).then((value) {});
      },
      icon: Icon(icon),
      iconSize: 30,
      color: isCurrent ? scheme.primary : scheme.onSurface,
      
    ),
  );
}