import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

// import pages
import 'format.dart';
import 'theme.dart';
import 'misceleanous.dart';
import 'comments&strings.dart';
import 'functionalities.dart';


class Customisables extends StatefulWidget {
  const Customisables({super.key});

  @override
  State<Customisables> createState() => _CustomisablesState();
}

class _CustomisablesState extends State<Customisables> {


  int indexOfPage = 0;


  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: indexOfPage == 0 ? theme.surfaceContainer : theme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          indexOfPage = 0;
                        });},
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Format",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: indexOfPage == 1 ? theme.surfaceContainer : theme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          indexOfPage = 1;
                        });},
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Theme",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: indexOfPage == 2 ? theme.surfaceContainer : theme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          indexOfPage = 2;
                        });},
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Misceleanous",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: indexOfPage == 3 ? theme.surfaceContainer : theme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          indexOfPage = 3;
                        });},
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Comments & Strings",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: indexOfPage == 4 ? theme.surfaceContainer : theme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: theme.outline,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          indexOfPage = 4;
                        });
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Functionalities",
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
          height: MediaQuery.of(context).size.height * 0.83,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: indexOfPage == 0
            ? const FormatPage()
            : indexOfPage == 1
              ? const ThemePage()
              : indexOfPage == 2
                ? const MisceleanousPage()
                : indexOfPage == 3
                  ? const CommentsAndStringsPage()
                  : indexOfPage == 4
                    ? const FunctionalitiesPage()
                    : Container(),
          ),
        ],
      ),),
    );
  }
}
