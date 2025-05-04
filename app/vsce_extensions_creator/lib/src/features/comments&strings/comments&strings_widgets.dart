import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';

Container commentsOptionsPart(
  ColorScheme scheme,
  int extensionIndex,
  String text,
  String type,
  double width,
  double height,
  bool isSelected,
  State state,
) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: isSelected ? scheme.onSurface : scheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: isSelected
          ? null
          : Border.all(
              color: scheme.onSurface,
              width: 1,
            ),
    ),
    child: TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        // ignore: invalid_use_of_protected_member
        state.setState(() {
          if (type == 'Single Line Comment') {
            valuesIndex[0] = text == "//"
                ? 0
                : text == "#"
                    ? 1
                    : text == "##"
                        ? 2
                        : 0;
            updateData("comments", extensionIndex, slc: valuesIndex[0]);
          } else if (type == 'Multi Lines Comment') {
            valuesIndex[1] = (text == "/* */"
                ? 0
                : text == "<!-- -->"
                    ? 1
                    : text == "<!--- --->"
                        ? 2
                        : 0);
            updateData("comments", extensionIndex, mlc: valuesIndex[1]);
          }
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? scheme.surface : scheme.onSurface,
        ),
      ),
    ),
  );
}

Container quotesOptionsPart(
  ColorScheme scheme,
  int extensionIndex,
  String text,
  String type,
  double width,
  State state,
) {
  return Container(
    width: width,
    height: width * 0.2,
    decoration: BoxDecoration(
      color: text == "\"string example\""
          ? (checkbox1 ? scheme.onSurface : scheme.surface)
          : text == "'string example'"
              ? (checkbox2 ? scheme.onSurface : scheme.surface)
              : scheme.onError,
      borderRadius: BorderRadius.circular(10),
      border: text == "\"string example\""
          ? (checkbox1
              ? null
              : Border.all(
                  color: scheme.onSurface,
                  width: 2,
                ))
          : text == "'string example'"
              ? (checkbox2
                  ? null
                  : Border.all(
                      color: scheme.onSurface,
                      width: 2,
                    ))
              : Border.all(
                  color: scheme.onSurface,
                  width: 2,
                ),
    ),
    child: TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: text == "\"string example\""
              ? (checkbox1 ? scheme.surface : scheme.onSurface)
              : text == "'string example'"
                  ? (checkbox2 ? scheme.surface : scheme.onSurface)
                  : scheme.onSurface,
          fontSize: width * 0.1,
        ),
      ),
      onPressed: () {
        // ignore: invalid_use_of_protected_member
        state.setState(() {
          checkbox1 = text == "\"string example\"" ? !checkbox1 : checkbox1;
          checkbox2 = text == "'string example'" ? !checkbox2 : checkbox2;
          valuesIndex[2] = checkbox2
              ? checkbox1
                  ? 2
                  : 1
              : checkbox1
                  ? 0
                  : 3;
        });
        updateData("comments", extensionIndex, quotes: valuesIndex[2])
            .then((value) {
          // ignore: invalid_use_of_protected_member
          state.setState(() {});
        });
      },
    ),
  );
}
