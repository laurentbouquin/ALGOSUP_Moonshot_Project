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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  Size windowSize = await WindowManager.instance.getSize();
  await WindowManager.instance.setMinimumSize(windowSize *1.1);
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
      light: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          surface: const Color(0xFFEDF6F9),
          onSurface: const Color(0xFF006d77),
          primary: const Color(0xffefefef),
          onPrimary: const Color(0xff000000),
          secondary: const Color(0xffcccccc),
          onSecondary: const Color(0xff000000),
          outline: const Color(0xff051C24),
        ),
      ), // Light Theme Options
      dark: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          surface: const Color(0xFF332E3C),
          onSurface: const Color(0xFFD8D6F2),
          primary: const Color(0xff1F1F1F),
          onPrimary: const Color(0xffFFFFFF),
          secondary: const Color(0xff434343),
          onSecondary: const Color(0xffFFFFFF),
          outline: const Color(0xff051C24),
        ),
      ), // Dark Theme Options
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

  int index = 0;

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
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            actions: <Widget>[
              for (int i = 0; i < navBarNames.length; i++)
                Container(
                  width: MediaQuery.of(context).size.width *
                      (1 / navBarNames.length),
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      color: index == i ? Colors.grey[300] : Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 2,
                        ),
                        right: i != 2
                            ? const BorderSide(color: Colors.black)
                            : BorderSide.none,
                      )),
                  child: TextButton(
                    onHover: (value) {
                      // Add your onPressed function here
                    },
                    onPressed: () {
                      setState(() {
                        index = i;
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
                      navBarNames[i],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
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
