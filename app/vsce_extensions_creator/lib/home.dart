// import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:vsce_extensions_creator/customize/customisables.dart';
// import 'package:vsce_extensions_creator/customize/customisables.dart';

import 'dart:convert';

import 'functional/constants.dart';

import 'package:vsce_extensions_creator/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _formKey = GlobalKey<FormState>();
  String name = "";
  String version = "";
  String publisher = "";
  List<String> categories = ["Other"];
  String lastUpdated = "";
  String displayName = "";
  String description = "";
  var data = [];

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
    //   name = jsonData['name'];
    //   version = jsonData['version'];
    //   publisher = jsonData['publisher'];
    //   categories = jsonData['categories'].cast<String>();
    //   lastUpdated = jsonData['lastUpdated'];
    //   displayName = jsonData['displayName'];
    //   description = jsonData['description'];
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ColorScheme scheme = currentTheme.colorScheme;
    if (colorUpdated) {
      setState(() {
        colorUpdated = false;
      });
    }

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: height,
              child: Column(
                children: <Widget>[
                  headRow([
                    "Name",
                    "Description",
                    "Categories",
                    "Last Updated",
                    "Version",
                  ], [
                    width,
                    height
                  ], scheme),
                  for (int i = 0; i < data.length; i++)
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Container(
                            width: i != 4 ? width * 0.2 : width * 0.05,
                            height: height * 0.1,
                            margin: EdgeInsets.only(
                                top: 10, left: i == 0 ? width * 0.05 : 0),
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
                                    data[index]["name"],
                                    style: TextStyle(
                                        color: scheme.onSurface,
                                        fontWeight: FontWeight.bold),
                                  )
                                : i == 1
                                    ? Text(
                                        data[index]["description"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: scheme.onSurface,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : i == 2
                                        ? Text(
                                            data[index]["category"],
                                            style: TextStyle(
                                                color: scheme.onSurface,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : i == 3
                                            ? Text(
                                                DateFormat(
                                                        'yyyy-MM-dd - kk:mm:ss')
                                                    .format(DateTime.parse(
                                                        data[index]
                                                            ["lastUpdated"])),
                                                style: TextStyle(
                                                    color: scheme.onSurface,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                data[index]["version"],
                                                style: TextStyle(
                                                    color: scheme.onSurface,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                          ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10),
                          width: width * 0.05,
                          height: height * 0.1,
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
                                  builder: (context) => const Customizables(
                                    extensionIndex: 0,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  scheme = isDark
                                      ? darkTheme.colorScheme
                                      : lightTheme.colorScheme;
                                });
                              });
                            },
                            child: Text("Select",
                                style: TextStyle(
                                    color: scheme.onSurface,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
              top: height * 0.90,
              left: width * 0.01,
              child: IconButton(
                hoverColor: Colors.transparent,
                icon: Icon(Icons.settings, color: scheme.onSurface, size: 40),
                onPressed: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const SettingsPage(
                            extensionIndex: 0,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Row headRow(List<String> labels, List<double> size, ColorScheme scheme) {
  return Row(children: <Widget>[
    for (int i = 0; i < 5; i++)
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10, left: i == 0 ? size[0] * 0.05 : 0),
        width: i != 4 ? size[0] * 0.2 : size[0] * 0.05,
        height: size[1] * 0.05,
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
    Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      width: size[0] * 0.05,
      height: size[1] * 0.05,
      decoration: BoxDecoration(
        color: scheme.secondary,
        border: Border(
          right: BorderSide(
            color: scheme.onSurface,
            width: 2,
          ),
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
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text("Select",
          style: TextStyle(
              color: scheme.onSecondary, fontWeight: FontWeight.bold)),
    ),
  ]);
}

// Row tableRow(
//     List<dynamic> data,
//     int index,
//     List<double> size,
//     BuildContext context,
//     GlobalKey<FormState> formKey,
//     bool isSelected,
//     ColorScheme scheme) {
//   return Row(
//     children: <Widget>[
//       for (int i = 0; i < 5; i++)
//         Container(
//           width: i != 4 ? size[0] * 0.2 : size[0] * 0.05,
//           height: size[1] * 0.1,
//           margin: EdgeInsets.only(top: 10, left: i == 0 ? size[0] * 0.05 : 0),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: scheme.surface,
//             border: Border(
//               right: BorderSide(
//                 color: scheme.onSurface,
//                 width: 2,
//               ),
//               left: i == 0
//                   ? BorderSide(
//                       color: scheme.onSurface,
//                       width: 2,
//                     )
//                   : BorderSide.none,
//               bottom: BorderSide(
//                 color: scheme.onSurface,
//                 width: 2,
//               ),
//               top: BorderSide(
//                 color: scheme.onSurface,
//                 width: 2,
//               ),
//             ),
//             borderRadius: BorderRadius.only(
//               topLeft:
//                   i == 0 ? const Radius.circular(10) : const Radius.circular(0),
//               bottomLeft:
//                   i == 0 ? const Radius.circular(10) : const Radius.circular(0),
//             ),
//           ),
//           child: i == 0
//               ? Text(
//                   data[index]["name"],
//                   style: TextStyle(
//                       color: scheme.onSurface, fontWeight: FontWeight.bold),
//                 )
//               : i == 1
//                   ? Text(
//                       data[index]["description"],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: scheme.onSurface, fontWeight: FontWeight.bold),
//                     )
//                   : i == 2
//                       ? Text(
//                           data[index]["category"],
//                           style: TextStyle(
//                               color: scheme.onSurface,
//                               fontWeight: FontWeight.bold),
//                         )
//                       : i == 3
//                           ? Text(
//                               DateFormat('yyyy-MM-dd - kk:mm:ss').format(
//                                   DateTime.parse(data[index]["lastUpdated"])),
//                               style: TextStyle(
//                                   color: scheme.onSurface,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           : Text(
//                               data[index]["version"],
//                               style: TextStyle(
//                                   color: scheme.onSurface,
//                                   fontWeight: FontWeight.bold),
//                             ),
//         ),
//       Container(
//         alignment: Alignment.center,
//         margin: const EdgeInsets.only(top: 10),
//         width: size[0] * 0.05,
//         height: size[1] * 0.1,
//         decoration: BoxDecoration(
//           color: scheme.surface,
//           border: Border(
//             right: BorderSide(
//               color: scheme.onSurface,
//               width: 2,
//             ),
//             bottom: BorderSide(
//               color: scheme.onSurface,
//               width: 2,
//             ),
//             top: BorderSide(
//               color: scheme.onSurface,
//               width: 2,
//             ),
//           ),
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(10),
//             bottomRight: Radius.circular(10),
//           ),
//         ),
//         child: TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute<void>(
//                 builder: (context) => const Customisables(
//                   extensionIndex: 0,
//                 ),
//               ),
//             );
//           },
//           child: Text("Select",
//               style: TextStyle(
//                   color: scheme.onSurface, fontWeight: FontWeight.bold)),
//         ),
//       ),
//     ],
//   );
// }
