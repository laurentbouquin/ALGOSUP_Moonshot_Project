import 'package:flutter/material.dart';


TextStyle extensionSettingsTitleCategory(ColorScheme scheme) {
  return TextStyle(
    fontSize: 35,
    color: scheme.onSurface,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    decorationColor: scheme.onSurface,
  );
}

BoxDecoration extensionSettingsBoxCategory(ColorScheme scheme) {
  return BoxDecoration(
    color: scheme.surface,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    border: Border.all(
      color: scheme.onSurface,
      width: 1,
    ),
  );
}