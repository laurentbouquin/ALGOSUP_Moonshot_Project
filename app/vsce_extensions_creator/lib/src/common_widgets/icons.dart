import 'package:flutter/material.dart';

BoxDecoration iconsDecoration(ColorScheme scheme) {
  return BoxDecoration(
    color: scheme.primary,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(
      color: scheme.onSurface,
      width: 2,
    ),
  );
}
BoxDecoration selectedIconsDecoration(ColorScheme scheme) {
  return BoxDecoration(
    color: scheme.onSurface,
    borderRadius: BorderRadius.circular(40)
  );
}