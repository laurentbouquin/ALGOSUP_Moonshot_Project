import 'package:flutter/material.dart';
import 'customisables.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Add your stateful widget implementation here


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Customisables'),
        ),
        body: const customisables(
        ),
      ),
    );
  }
}
