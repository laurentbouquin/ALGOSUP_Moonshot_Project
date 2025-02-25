// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// ==== Pages Imports ==== //

// Call displayable files
import 'package:vsce_extensions_creator/src/features/customize/customizables.dart';
import 'package:vsce_extensions_creator/src/settings/settings.dart';

// Call data files
import 'constants/variables.dart';
import 'constants/links.dart';
import 'constants/classes.dart';

// ==== MainApp Class ==== //
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  static const routeName = '/menu';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Variables that need to be declared beforehand
  var data = [];
  WindowSize windowSize = WindowSize();

  ColorScheme scheme = isDark ? darkTheme.colorScheme : lightTheme.colorScheme;

  @override
  void initState() {
    super.initState();
    _asyncCallForKeywords();
  }

  _asyncCallForKeywords() async {
    var jsonData = json.decode(extensionsFile.readAsStringSync());
    setState(() {
      data = jsonData['extensions'];
    });
  }

  int selected = 0;

  // Update the color scheme when getting back from the settings page (will be called later)
  /// Updates the color scheme when called
  void onGoBack() {
    setState(() {
      scheme = isDark ? darkTheme.colorScheme : lightTheme.colorScheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        // Create a Stack to have the settings button on the bottom left independent of the table
        child: Stack(
          children: [
            // Create a SizedBox to have the Column inherit the height of the screen
            SizedBox(
              height: windowSize.height,
              child: Column(
                children: <Widget>[
                  headRow(
                    [
                      "Name",
                      "Description",
                      "Categories",
                      "Last Updated",
                      "Version",
                    ],
                    windowSize,
                    scheme,
                  ),
                  // Create a line for each saved extension
                  for (int j = 0; j < data.length; j++)
                    Row(
                      children: [
                        // Create a cell for each label of the extension + the select button
                        for (int i = 0; i < 5; i++)
                          Container(
                            width: i != 4
                                ? windowSize.width * 0.2
                                : windowSize.width * 0.05,
                            height: windowSize.height * 0.1,
                            margin: EdgeInsets.only(
                              top: 10,
                              left: i == 0 ? windowSize.width * 0.05 : 0,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              border: Border(
                                right: BorderSide(
                                  color: scheme.onSurface,
                                  width: 2,
                                ),
                                left: i == 0
                                    ? BorderSide(
                                        color: scheme.onSurface,
                                        width: 2,
                                      )
                                    : BorderSide.none,
                                bottom: BorderSide(
                                  color: scheme.onSurface,
                                  width: 2,
                                ),
                                top: BorderSide(
                                  color: scheme.onSurface,
                                  width: 2,
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: i == 0
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                                bottomLeft: i == 0
                                    ? const Radius.circular(10)
                                    : const Radius.circular(0),
                              ),
                            ),
                            child: i == 0
                                ? Text(
                                    data[j]["name"],
                                    style: TextStyle(
                                      color: scheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : i == 1
                                    ? Text(
                                        data[j]["description"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: scheme.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : i == 2
                                        ? Column(
                                            children: List<Widget>.generate(
                                              data[j]["categories"].length,
                                              (k) => Text(
                                                data[j]["categories"][k],
                                                style: TextStyle(
                                                  color: scheme.onSurface,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                        : i == 3
                                            ? Text(
                                                DateFormat(
                                                        'yyyy-MM-dd - kk:mm:ss')
                                                    .format(
                                                  DateTime.parse(
                                                      data[j]["lastUpdated"]),
                                                ),
                                                style: TextStyle(
                                                  color: scheme.onSurface,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Text(
                                                data[index]["version"],
                                                style: TextStyle(
                                                  color: scheme.onSurface,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                          ),
                        // End of the i loop

                        // Create a cell for the select button
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10),
                          width: windowSize.width * 0.05,
                          height: windowSize.height * 0.1,
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            border: Border(
                              right: BorderSide(
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
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Customizables(
                                    extensionIndex: j,
                                  ),
                                ),
                              ).then(
                                (value) {
                                  setState(
                                    () {
                                      scheme = isDark
                                          ? darkTheme.colorScheme
                                          : lightTheme.colorScheme;
                                    },
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Select",
                              style: TextStyle(
                                  color: scheme.onSurface,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  // End of the j loop
                ],
              ),
            ),

            // Create the settings button on the bottom left
            Positioned(
              top: windowSize.height * 0.90,
              left: windowSize.width * 0.01,
              child: IconButton(
                hoverColor: Colors.transparent,
                icon: Icon(Icons.settings, color: scheme.onSurface, size: 40),
                onPressed: () {
                  // Go to the settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const SettingsPage(
                        extensionIndex: 0,
                      ),
                    ),
                  // Update the color scheme when getting back from the settings page
                  ).then((_) => onGoBack());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Generates the header row of the table with the labels and the select button
Row headRow(List<String> labels, WindowSize size, ColorScheme scheme) {
  return Row(
    children: <Widget>[
      // Create a head cell for each label of the extension
      for (int i = 0; i < 5; i++)
        Container(
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: 10, left: i == 0 ? size.width * 0.05 : 0),
          width: i != 4 ? size.width * 0.2 : size.width * 0.05,
          height: size.height * 0.05,
          decoration: BoxDecoration(
            color: scheme.secondary,
            border: Border(
              left: BorderSide(
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
            ),
            borderRadius: BorderRadius.only(
              topLeft:
                  i == 0 ? const Radius.circular(10) : const Radius.circular(0),
              bottomLeft:
                  i == 0 ? const Radius.circular(10) : const Radius.circular(0),
            ),
          ),
          child: Text(
            labels[i],
            style: TextStyle(
              color: scheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      // End of the i loop

      // Create a head cell for the select button
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        width: size.width * 0.05,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: scheme.secondary,
          border: Border.all(
            color: scheme.onSurface,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text(
          "Select",
          style: TextStyle(
            color: scheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
