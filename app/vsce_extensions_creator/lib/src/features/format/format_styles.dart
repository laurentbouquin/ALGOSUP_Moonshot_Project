import 'package:flutter/material.dart';


BoxDecoration elementNameBox(scheme) {
  return BoxDecoration(
    color: scheme.surface,
    border: Border.all(
      color: scheme.onSurface,
      width: 1,
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
    ),
  );
}

BoxDecoration elementInteractBox(scheme) {
  return BoxDecoration(
    color: scheme.surface,
    border: Border.all(
      color: scheme.onSurface,
      width: 1,
    ),
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
  );
}
