import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final dir = await getApplicationDocumentsDirectory();
    File jsonFile = File(
        "${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/extensions_list.json");
    var jsonData = json.decode(jsonFile.readAsStringSync());
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            headRow([
              "Name",
              "Version",
              "Categories",
              "Description",
              "Last Updated",
            ], [
              width,
              height
            ]),
            for (int i = 0; i < data.length; i++)
              tableRow(data, i, [width, height]),
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
        width: size[0] * 0.15,
        height: size[1] * 0.05,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: const Border(
            left: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft:
                i == 0 ? const Radius.circular(10) : const Radius.circular(0),
            bottomLeft:
                i == 0 ? const Radius.circular(10) : const Radius.circular(0),
          ),
        ),
        child: Text(labels[i]),
      ),
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        width: size[0] * 0.15,
        height: size[1] * 0.05,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: const Border(
            right: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            left: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: const Text("Modifying"),
      ),
      
  ]);
}

Row tableRow(List<dynamic> data, int index, List<double> size) {
  return Row(
    children: <Widget>[
      for (int i = 0; i < 5; i++)
        Container(
          width: size[0] * 0.15,
          height: size[1] * 0.1,
          margin: EdgeInsets.only(top: 10, left: i == 0 ? size[0] * 0.05 : 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              right: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
              left: i == 0
                  ? const BorderSide(
                      color: Colors.black,
                      width: 1,
                    )
                  : BorderSide.none,
              bottom: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
              top: const BorderSide(
                color: Colors.black,
                width: 1,
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
              ? Text(data[index]["name"])
              : i == 1
                  ? Text(data[index]["version"])
                  : i == 2
                      ? Text(data[index]["categories"].join(", "))
                      : i == 3
                          ? Text(data[index]["description"])
                          : Text(data[index]["lastUpdated"]),
        ),
        Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        width: size[0] * 0.15,
        height: size[1] * 0.1,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: TextButton(
          onPressed: () {
            // Add your onPressed function here
          },
          child:  const Text("Modify"),),
      ),
    ],
  );
}
