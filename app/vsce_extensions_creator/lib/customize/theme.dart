import 'package:flutter/material.dart';

import 'package:flex_color_picker/flex_color_picker.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  // Color for the picker shown in Card on the screen.
  Color backgroundC = Colors.white;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Background: ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Primary: ',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.025,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.black,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens),
                        color: Colors.black,
                        onPressed: (){
                          setState(() {
                            backgroundC = Colors.black;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens),
                        color: Colors.blue,
                        onPressed: (){
                          setState(() {
                            backgroundC = Colors.blue;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens),
                        color: Colors.red,
                        onPressed: (){
                          setState(() {
                            backgroundC = Colors.red;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey,
                      child: IconButton(
                        icon: const Icon(Icons.color_lens),
                        color: Colors.grey,
                        onPressed: (){
                          setState(() {
                            backgroundC = Colors.grey;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.83,
                  color: backgroundC,
                  child: Text(
                    'Theme: ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.025,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
