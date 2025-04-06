import 'package:flutter/material.dart';
import 'package:vsce_extensions_creator/src/constants/classes.dart';
import 'package:vsce_extensions_creator/src/constants/variables.dart';
import 'package:vsce_extensions_creator/src/features/nav_bar/nav_bar.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final windowSize = WindowSize();

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = currentTheme.colorScheme;
    windowSize.width = MediaQuery.of(context).size.width;
    windowSize.height = MediaQuery.of(context).size.height;
    return Container(
      height: windowSize.height,
      width: windowSize.width / 7,
      decoration: BoxDecoration(
        color: scheme.onSurface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(windowSize.width * 0.02),
          bottomLeft: Radius.circular(windowSize.width * 0.02),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'NavBar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // navBarButton(Icons.home_rounded, scheme),
          navBarButton(Icons.format_align_center_rounded, scheme, "/formatPage", context),
          navBarButton(Icons.format_color_fill_rounded, scheme, "/themePage", context),
          navBarButton(Icons.snippet_folder_rounded, scheme, "/snippetsPage", context),
          navBarButton(Icons.format_quote_rounded, scheme, "/commentsAndStringsPage", context),
          navBarButton(Icons.code_rounded, scheme, "/functionalitiesPage", context),
          navBarButton(Icons.save, scheme, "/menu", context),
          navBarButton(Icons.settings_rounded, scheme, "/settings", context),
        ],
      ),
    );
  }
}
