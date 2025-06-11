import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.state});

  final State state;

  final windowSize = WindowSize();

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    return Container(
      height: windowSize.height,
      width: windowSize.width * 0.14,
      margin: EdgeInsets.only(
        top: windowSize.height * 0.01,
        bottom: windowSize.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border.all(
          color: scheme.onSurface,
          width: 3,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(windowSize.width * 0.02),
          bottomLeft: Radius.circular(windowSize.width * 0.02),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // navBarButton(Icons.home_rounded, scheme),
          navBarButton(Icons.format_align_center_rounded, scheme, "/FormatPage",
              context, windowSize),
          navBarButton(
              Icons.format_color_fill_rounded, scheme, "/ThemePage", context, windowSize),
          navBarButton(
              Icons.snippet_folder_rounded, scheme, "*/SnippetsPage", context, windowSize), // ""
          navBarButton(Icons.format_quote_rounded, scheme,
              "/CommentsAndStringsPage", context, windowSize),
          navBarButton(
              Icons.code_rounded, scheme, "*/FunctionalitiesPage", context, windowSize), // ""
          navBarButton(Icons.save, scheme, "/menu", context, windowSize),
          navBarButton(Icons.publish_sharp, scheme, "/none", context, windowSize),
          navBarButton(Icons.settings_rounded, scheme, "/ExtensionSettingsPage",
              context, windowSize),
          Container(
            margin: EdgeInsets.only(
              top: windowSize.height * 0.04),
            child: Transform.scale(
              scale: 1.5,
              child: Switch(
                value: isDark,
                onChanged: (bool newValue) {
                  // ignore: invalid_use_of_protected_member
                  state.setState(() {
                    isDark = !isDark;
                    colorUpdated = true;
                    currentTheme = isDark ? darkTheme : lightTheme;
                  });
                },
                thumbColor: WidgetStateProperty.all<Color>(scheme.primary),
                inactiveThumbColor: scheme.primary,
                activeTrackColor: scheme.onSurface,
                inactiveTrackColor: scheme.onSurface,
                trackOutlineColor:
                    WidgetStateProperty.all<Color>(scheme.onSurface),
                thumbIcon: WidgetStateProperty.all<Icon?>(
                  Icon(
                    isDark ? Icons.nightlight_round : Icons.wb_sunny,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
