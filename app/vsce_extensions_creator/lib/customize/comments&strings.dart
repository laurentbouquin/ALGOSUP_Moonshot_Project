import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

// import '../functions.dart';

class CommentsAndStringsPage extends StatefulWidget {
  const CommentsAndStringsPage({super.key});

  @override
  State<CommentsAndStringsPage> createState() => _CommentsAndStringsPageState();
}

class _CommentsAndStringsPageState extends State<CommentsAndStringsPage> {
  List<List<String>> values = [
    ['"//"', '"#"', '"##"', "add your own"],
    ['"/* */"', '"<!-- -->"', '"<!--- --->"']
  ];
  List<int> indexes = [0, 0];

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Comments \n& Strings: ',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  color: theme.onSurface,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Single line's Comments    ",
                      style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.01)),
                  DropdownButton(
                    items: values[0].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: theme.onSurface),
                        ),
                      );
                    }).toList(),
                    dropdownColor: theme.surface,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    borderRadius: BorderRadius.circular(10),
                    value: values[0][indexes[0]],
                    onChanged: (value) {
                      setState(() {
                        indexes[0] = values[0].indexOf(value!);
                        print(
                            'DropdownButton Selected: $value / ${values[0].indexOf(value)} - ${indexes[0]}');
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Multi-line Comments    ",
                      style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.01)),
                  DropdownButton(
                    items: values[1].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: theme.onSurface),
                        ),
                      );
                    }).toList(),
                    dropdownColor: theme.surface,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                    borderRadius: BorderRadius.circular(10),
                    value: values[1][indexes[1]],
                    onChanged: (value) {
                      setState(() {
                        indexes[1] = values[1].indexOf(value!);
                        print(
                            'DropdownButton Selected: $value / ${values[1].indexOf(value)} - ${indexes[1]}');
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
