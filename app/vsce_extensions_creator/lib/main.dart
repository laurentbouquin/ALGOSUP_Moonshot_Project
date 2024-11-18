// ==== Built-in Imports ==== //
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:window_manager/window_manager.dart';


// ==== Pages Imports ==== //

// Call displayable files
import 'customize/customizables.dart';
import 'home.dart';
import 'settings.dart';

// Call data files
import 'functional/functions.dart';
import 'functional/constants.dart';

// ==== Main Function ==== //
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  Size windowSize = await WindowManager.instance.getSize();
  await WindowManager.instance.setMinimumSize(windowSize * 1.1);
  await WindowManager.instance.maximize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  // Main build function
  Widget build(BuildContext context) {
    return const RootPage();
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  void initState() {
    super.initState();
    _asyncCallForFiles();
  }

  _asyncCallForFiles() async {
    await createBaseFilesContent(Directory.current.path);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Change the body of the app depending on the index
        body: index == 0
            ? const HomePage()
            : index == 1
                ? const Customizables(
                    extensionIndex: 0,
                  )
                : const SettingsPage(
                    extensionIndex: 0,
                  ),
      ),
    );
  }
}
