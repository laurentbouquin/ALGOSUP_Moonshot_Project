import 'package:flutter/material.dart';


BoxDecoration mainCards(ColorScheme scheme) {
  return BoxDecoration(
    color: scheme.surface,
    borderRadius: const BorderRadius.all(Radius.circular(30)),
    border: Border.all(
      color: scheme.onSurface,
      width: 3,
    ),
    boxShadow: [
      BoxShadow(
        color: scheme.onSurface.withOpacity(1),
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(2, 2), // changes position of shadow
      ),
    ],
  );
}

BoxDecoration mainCardsHead(scheme) {
  return BoxDecoration(
    color: scheme.onSurface,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
  );
}