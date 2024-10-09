import 'package:flutter/material.dart';

// Packages imports
import 'package:adaptive_theme/adaptive_theme.dart';
import 'dart:io';
import 'package:window_manager/window_manager.dart';

// Pages imports
import 'customize/customisables.dart';

import 'home.dart';
import 'settings.dart';
import './functionals/functions.dart';
import './functionals/constants.dart';

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
    return AdaptiveTheme(
      // Set the light and dark theme options
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light, // Inital theme when app starts
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vsce Extensions Creator',
        theme: theme,
        darkTheme: darkTheme,

        // Home page is the connection page if debug is false, else it is the root page
        home: const RootPage(),
      ),
      debugShowFloatingThemeButton: true,
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // Add your stateful widget implementation here

  List<String> navBarNames = ["Home", "Customize", "Settings"];

  int currentIndex = index;

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
                ? const Customisables(
                    extensionIndex: 0,
                  )
                : const SettingsPage(
                    extensionIndex: 0,
                  ),
      ),
    );
  }
}
