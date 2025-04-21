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
            SizedBox(
              height: windowSize.height,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Create a head cell for each label of the extension
                      headRowPart(windowSize, "Name", "TL",
                          windowSize.width * 0.2, "TLR", scheme),
                      headRowPart(windowSize, "Description", "",
                          windowSize.width * 0.45, "TR", scheme),
                      headRowPart(windowSize, "Last Updated", "",
                          windowSize.width * 0.15, "TR", scheme),
                      headRowPart(windowSize, "Version", "TR",
                          windowSize.width * 0.1, "T", scheme)
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
                            currentExtensionIndex = index;
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            currentExtensionIndex = index;
                            redirectToStateless(context, '/formatPage',
                                arguments: {
                                  "extensionIndex": currentExtensionIndex
                                });
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            tableElement(windowSize, data[index]["name"], "",
                                windowSize.width * 0.2, "LTR", scheme,
                                isSelected: index == currentExtensionIndex
                                    ? true
                                    : false),
                            tableElement(windowSize, data[index]["description"],
                                "", windowSize.width * 0.45, "TR", scheme,
                                isSelected: index == currentExtensionIndex
                                    ? true
                                    : false),
                            tableElement(
                                windowSize,
                                DateFormat('yyyy-MM-dd - kk:mm:ss').format(
                                    DateTime.parse(data[index]["lastUpdated"])),
                                "",
                                windowSize.width * 0.15,
                                "TR",
                                scheme,
                                isSelected: index == currentExtensionIndex
                                    ? true
                                    : false),
                            tableElement(windowSize, data[index]["version"], "",
                                windowSize.width * 0.1, "T", scheme,
                                isSelected: index == currentExtensionIndex
                                    ? true
                                    : false),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: windowSize.height * 0.955 - windowSize.width * 0.01,
              left: windowSize.width * 0.01,
              child: IconButton(
                hoverColor: Colors.transparent,
                icon: Icon(Icons.settings, color: scheme.onSurface, size: 40),
                onPressed: () {
                  redirectToStateless(context, "/settings",
                      arguments: {"extensionIndex": 0});
                },
              ),
            ),
          ],
        ),
      ), // Floating action button to open the menu to save, publish and cancel
      floatingActionButton: FloatingActionButton(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: scheme.onSurface),
            borderRadius: BorderRadius.circular(10)),
        heroTag: 'menu',
        onPressed: () {
          setState(() {
            redirectToStateless(context, '/formatPage',
                arguments: {"extensionIndex": currentExtensionIndex});
          });
        },
        // tooltip: isMenuOpen ? 'Close Menu' : 'Open Menu',
        child: const Icon(Icons.arrow_circle_right_outlined),
      ),
    );
  }
}
