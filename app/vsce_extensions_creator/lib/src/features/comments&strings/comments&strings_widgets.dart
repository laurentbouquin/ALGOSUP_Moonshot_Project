import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/features/convert/convert_widgets_to_json.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';

Container commentsOptionsPart(
  WindowSize windowSize,
  ColorScheme scheme,
  int extensionIndex,
  String text,
  String type,
  double width,
  double height,
  State state,
) {
  return Container(
    width: windowSize.width / 8,
    height: windowSize.height / 10.8,
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
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
          color: scheme.onSurface,
        ),
      ),
    ),
  );
}

Container quotesOptionsPart(
  WindowSize windowSize,
  ColorScheme scheme,
  int extensionIndex,
  String text,
  String type,
  double width,
  State state,
) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: text == "\""
            ? (checkbox1 ? scheme.onSurface : scheme.error)
            : text == "'"
                ? (checkbox2 ? scheme.onSurface : scheme.error)
                : scheme.onSurface,
        width: 2,
      ),
    ),
    child: TextButton(
      child: Text(
        text,
        style: TextStyle(
          color: text == "\"" ? (checkbox1 ? scheme.onSurface : scheme.error)
              : text == "'"
                  ? (checkbox2 ? scheme.onSurface : scheme.error)
                  : scheme.onSurface,
          fontSize: windowSize.width * 0.05,
        ),
      ),
      onPressed: () {
        // ignore: invalid_use_of_protected_member
        state.setState(() {
          checkbox1 = text == "\"" ? !checkbox1 : checkbox1;
          checkbox2 = text == "'" ? !checkbox2 : checkbox2;
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


