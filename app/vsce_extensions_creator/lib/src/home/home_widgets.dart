import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';

Container headRowPart(WindowSize windowSize, String text, String bordersRadius,
    double inWidth, String margins, ColorScheme scheme) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(
      left: margins.contains("L") ? windowSize.width * 0.05 : 0,
      right: margins.contains("R") ? windowSize.width * 0.002 : 0,
      top: margins.contains("T") ? windowSize.height * 0.01 : 0,
      bottom: margins.contains("B") ? windowSize.height * 0.01 : 0,
    ),
    width: inWidth - windowSize.width * 0.002,
    height: windowSize.height * 0.04,
    decoration: BoxDecoration(
      color: scheme.onSurface,
      borderRadius: BorderRadius.only(
        topLeft: bordersRadius.contains("TL")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        bottomLeft: bordersRadius.contains("BL")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        topRight: bordersRadius.contains("TR")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        bottomRight: bordersRadius.contains("BR")
            ? const Radius.circular(10)
            : const Radius.circular(0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: scheme.surface,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Container tableElement(WindowSize windowSize, String text, String bordersRadius,
    double inWidth, String margins, ColorScheme scheme,
    {bool isSelected = false}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(
      left: margins.contains("L") ? windowSize.width * 0.05 : 0,
      right: margins.contains("R") ? windowSize.width * 0.002 : 0,
      top: margins.contains("T") ? windowSize.height * 0.01 : 0,
      bottom: margins.contains("B") ? windowSize.height * 0.01 : 0,
    ),
    width: inWidth - windowSize.width * 0.002,
    height: windowSize.height * 0.08,
    decoration: BoxDecoration(
      color: isSelected ? scheme.onSurface : scheme.surface,
      border: !isSelected ? Border(
        left:  BorderSide(
          color: scheme.onSurface,
          width: 2,
        ),
        bottom: BorderSide(
          color: scheme.onSurface,
          width: 2,
        ),
        top: BorderSide(
          color: scheme.onSurface,
          width: 2,
        ),
        right: BorderSide(
          color: scheme.onSurface,
          width: 2,
        ),
      ): null,
      borderRadius: BorderRadius.only(
        topLeft: bordersRadius.contains("TL")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        bottomLeft: bordersRadius.contains("BL")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        topRight: bordersRadius.contains("TR")
            ? const Radius.circular(10)
            : const Radius.circular(0),
        bottomRight: bordersRadius.contains("BR")
            ? const Radius.circular(10)
            : const Radius.circular(0),
      ),
    ),
    child: Text(
            text,
            style: TextStyle(
              color: isSelected ? scheme.surface : scheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
  );
}

String getListAsString(List<String> list) {
  String result = "";
  for (int i = 0; i < list.length; i++) {
    result += list[i];
    if (i != list.length - 1) {
      result += "\n ";
    }
  }
  return result;
}
