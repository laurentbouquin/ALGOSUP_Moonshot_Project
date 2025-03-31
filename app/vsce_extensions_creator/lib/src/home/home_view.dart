// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:vsce_extensions_creator/src/common_widgets/redirect_widgets.dart';

// ==== Pages Imports ==== //

// Call displayable files
import 'package:vsce_extensions_creator/src/home/home_widgets.dart';

// Call data files
import '../constants/variables.dart';
import '../constants/links.dart';
import '../constants/classes.dart';

// ==== MainApp Class ==== //
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/menu';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Row(
                    children: <Widget>[
                      // Create a head cell for each label of the extension
                      headRowPart(windowSize, "Name", "TL,BL",
                          windowSize.width * 0.2, "TL", scheme),
                      headRowPart(windowSize, "Description", "",
                          windowSize.width * 0.45, "T", scheme),
                      headRowPart(windowSize, "Last Updated", "",
                          windowSize.width * 0.2, "T", scheme),
                      headRowPart(windowSize, "Version", "TR,BR",
                          windowSize.width * 0.05, "T", scheme)
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            debugPrint(selected.toString());
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            tableElement(windowSize, data[index]["name"],
                                "TL,BL", windowSize.width * 0.2, "LT", scheme,
                                isSelected: index == selected ? true : false),
                            tableElement(windowSize, data[index]["description"],
                                "", windowSize.width * 0.45, "T", scheme,
                                isSelected: index == selected ? true : false),
                            tableElement(
                                windowSize,
                                DateFormat('yyyy-MM-dd - kk:mm:ss').format(
                                    DateTime.parse(data[index]["lastUpdated"])),
                                "",
                                windowSize.width * 0.2,
                                "T",
                                scheme,
                                isSelected: index == selected ? true : false),
                            tableElement(windowSize, data[index]["version"],
                                "TR,BR", windowSize.width * 0.05, "T", scheme,
                                isSelected: index == selected ? true : false),
                          ],
                        ),
                      );
                    },
                  ),
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
                  redirectToStateless(context, "/settings",
                      arguments: {"extensionIndex": 0}).then(
                    (_) {
                      // Update the color scheme when getting back from the settings page
                      onGoBack();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ), // Floating action button to open the menu to save, publish and cancel
      floatingActionButton: FloatingActionButton(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onSurface,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: scheme.onSurface),
            borderRadius: BorderRadius.circular(10)),
        heroTag: 'menu',
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/customizables',
                arguments: {"extensionIndex": selected});
          });
        },
        // tooltip: isMenuOpen ? 'Close Menu' : 'Open Menu',
        child: const Icon(Icons.arrow_circle_right_outlined),
      ),
    );
  }
}
