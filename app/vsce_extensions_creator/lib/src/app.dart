import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/comments_and_strings/comments_and_strings_view.dart';
import 'package:vsce_extensions_creator/src/features/extension_settings/extension_settings_view.dart';
import 'package:vsce_extensions_creator/src/features/format/format_view.dart';
import 'package:vsce_extensions_creator/src/features/theme/theme_view.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

import 'home/home_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          // Set page transitions duration to 0
          theme: ThemeData(),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: settingsController.themeMode,

          



          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsPage.routeName:
                    return const SettingsPage();
                  case FormatPage.routeName:
                    currentPage = "/FormatPage";
                    return const FormatPage();
                  case ThemePage.routeName:
                    currentPage = "/ThemePage";
                    return const ThemePage();
                  case CommentsAndStringsPage.routeName:
                    currentPage = "/CommentsAndStringsPage";
                    return const CommentsAndStringsPage();
                  case ExtensionSettingsView.routeName:
                    currentPage = "/ExtensionSettingsPage";
                    return const ExtensionSettingsView();
                  case HomePage.routeName:
                  default:
                    currentPage = "/menu";
                    return const HomePage();
                }
              },
            );
          },
        );
      },
    );
  }
}
