import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'dart:convert';

import 'functionals/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
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

    return Scaffold(
      backgroundColor: surfaceCol,
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
                  ]),
                  for (int i = 0; i < data.length; i++)
                    tableRow(data, i, [width, height], context, _formKey,
                        i == selected),
                ],
              ),
            ),
            Positioned(
              top: height * 0.93,
              left: 0,
              child: Icon(Icons.settings, color: onSurfaceCol, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

Row headRow(List<String> labels, List<double> size) {
  return Row(children: <Widget>[
    for (int i = 0; i < 5; i++)
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10, left: i == 0 ? size[0] * 0.05 : 0),
        width: i != 4 ? size[0] * 0.2 : size[0] * 0.05,
        height: size[1] * 0.05,
        decoration: BoxDecoration(
          color: secondaryCol,
          border: Border(
            left: BorderSide(
              color: onSurfaceCol,
              width: 2,
            ),
            bottom: BorderSide(
              color: onSurfaceCol,
              width: 2,
            ),
            top: BorderSide(
              color: onSurfaceCol,
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
            color: onSecondaryCol,
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
        color: secondaryCol,
        border: Border(
          right: BorderSide(
            color: onSurfaceCol,
            width: 2,
          ),
          left: BorderSide(
            color: onSurfaceCol,
            width: 2,
          ),
          bottom: BorderSide(
            color: onSurfaceCol,
            width: 2,
          ),
          top: BorderSide(
            color: onSurfaceCol,
            width: 2,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text("Select",
          style: TextStyle(color: onSecondaryCol, fontWeight: FontWeight.bold)),
    ),
  ]);
}

Row tableRow(List<dynamic> data, int index, List<double> size,
    BuildContext context, GlobalKey<FormState> formKey, bool isSelected) {
  return Row(
    children: <Widget>[
      for (int i = 0; i < 5; i++)
        Container(
          width: i != 4 ? size[0] * 0.2 : size[0] * 0.05,
          height: size[1] * 0.1,
          margin: EdgeInsets.only(top: 10, left: i == 0 ? size[0] * 0.05 : 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? surfaceCol : surfaceCol,
            border: Border(
              right: BorderSide(
                color: onSurfaceCol,
                width: 2,
              ),
              left: i == 0
                  ? BorderSide(
                      color: onSurfaceCol,
                      width: 2,
                    )
                  : BorderSide.none,
              bottom: BorderSide(
                color: onSurfaceCol,
                width: 2,
              ),
              top: BorderSide(
                color: onSurfaceCol,
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
          child: i == 0
              ? Text(
                  data[index]["name"],
                  style: TextStyle(
                      color: onSurfaceCol, fontWeight: FontWeight.bold),
                )
              : i == 1
                  ? Text(
                      data[index]["description"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: onSurfaceCol, fontWeight: FontWeight.bold),
                    )
                  : i == 2
                      ? Text(
                          data[index]["category"],
                          style: TextStyle(
                              color: onSurfaceCol, fontWeight: FontWeight.bold),
                        )
                      : i == 3
                          ? Text(
                              DateFormat('yyyy-MM-dd - kk:mm:ss').format(
                                  DateTime.parse(data[index]["lastUpdated"])),
                              style: TextStyle(
                                  color: onSurfaceCol,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              data[index]["version"],
                              style: TextStyle(
                                  color: onSurfaceCol,
                                  fontWeight: FontWeight.bold),
                            ),
        ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        width: size[0] * 0.05,
        height: size[1] * 0.1,
        decoration: BoxDecoration(
          color: isSelected ? surfaceCol : surfaceCol,
          border: Border(
            right: BorderSide(
              color: onSurfaceCol,
              width: 2,
            ),
            bottom: BorderSide(
              color: onSurfaceCol,
              width: 2,
            ),
            top: BorderSide(
              color: onSurfaceCol,
              width: 2,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text("Select",
              style:
                  TextStyle(color: onSurfaceCol, fontWeight: FontWeight.bold)),
        ),
      ),
    ],
  );
}
