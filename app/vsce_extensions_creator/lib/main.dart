import 'package:flutter/material.dart';

// === Packages imports === //
import 'dart:io';
import 'package:window_manager/window_manager.dart';

// ==== Pages imports ==== //

// Pages for links
import 'customize/customizables.dart';
import 'home.dart';
import 'settings.dart';

// Pages for functions or constants
import 'functional/functions.dart';
import 'functional/constants.dart';

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
    // Return the AdaptiveTheme widget
    return const RootPage();
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // Add your stateful widget implementation here

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
