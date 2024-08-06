import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class MisceleanousPage extends StatefulWidget {
  const MisceleanousPage({super.key});

  @override
  State<MisceleanousPage> createState() => _MisceleanousPageState();
}

class _MisceleanousPageState extends State<MisceleanousPage> {
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
              'Miscelaneous: ',
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
