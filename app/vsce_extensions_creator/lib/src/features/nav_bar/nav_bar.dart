import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';


Container navBarButton(IconData icon, ColorScheme scheme, String page, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(40),
      border: Border.all(
        color: scheme.onSecondary,
        width: 2,
      ),
    ),
    child: IconButton(
      onPressed: () async{
        redirectToStateless(context, page).then((value) {});
      },
      icon: Icon(icon),
      iconSize: 30,
      color: scheme.onSurface,
    ),
  );
}