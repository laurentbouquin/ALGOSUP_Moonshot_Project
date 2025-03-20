import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class MiscellaneousPage extends StatefulWidget {
  const MiscellaneousPage({super.key});

  @override
  State<MiscellaneousPage> createState() => _MiscellaneousPageState();
}

class _MiscellaneousPageState extends State<MiscellaneousPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Snippets: ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.025,
                color: theme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
