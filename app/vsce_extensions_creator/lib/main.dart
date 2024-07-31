import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: IconButton(onPressed: (){
            print('Button Clicked');
          }, icon: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
