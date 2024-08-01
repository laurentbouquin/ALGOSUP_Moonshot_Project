import 'package:flutter/material.dart';


// Packages imports
import 'package:adaptive_theme/adaptive_theme.dart';




// Pages imports
import 'customisables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          surface: const Color(0xFF007198),
          primary: const Color(0xff003C57),
          secondary: const Color(0xff0594D0),
          tertiary: const Color(0xff04BBFF),
          outline: const Color(0xff051C24),
        ),
      ), // Light Theme Options
      dark: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          surface: const Color(0xFF007198),
          primary: const Color(0xff003C57),
          secondary: const Color(0xff0594D0),
          tertiary: const Color(0xff04BBFF),
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

  List<String> navBarNames = ["Home", "Modify", "Themes", "Settings"];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[

            for (int i = 0; i < 4; i++)
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    )
                ),
                child: TextButton(
                  onHover: (value) {
                    // Add your onPressed function here
                  },
                  onPressed: () {},
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
        body: const customisables(),
      ),
    );
  }
}
