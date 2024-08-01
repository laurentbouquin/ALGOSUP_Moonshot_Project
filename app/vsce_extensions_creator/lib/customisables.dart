import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

import 'functions.dart';

class customisables extends StatefulWidget {
  const customisables({super.key});

  @override
  State<customisables> createState() => _customisablesState();
}

class _customisablesState extends State<customisables> {
  final _formKey = GlobalKey<FormState>();

  String currentKeyword = '';

    List<String> keywords = ["if"];
  @override
  Widget build(BuildContext context) {

    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.outline,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Comments: ',
                  style: TextStyle(fontSize: 20),
                ),
                test('Single line\'s Comments', <String>['"//"', '"#"', '"##"'],
                    0),
                test('Multi-line Comments',
                    <String>['"/* */"', '"<!-- -->"', '"<!--- --->"'], 0),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Keywords: ',
                  style: TextStyle(fontSize: 20),
                ),
                if (keywords.isEmpty)
                  const Text(
                    'No Keywords Found',
                    style: TextStyle(fontSize: 20),
                  )
                else
                  for (int i = 0; i < keywords.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: "else".length * 10.0,
                          child: TextField(
                            readOnly: true,
                            controller:
                                TextEditingController(text: keywords[i]),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              keywords[i] = value;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.highlight_remove_sharp),
                        ),
                      ],
                    ),
                IconButton(
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40,
                              top: -40,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Add Keywords'),
                                    TextField(
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Keyword',
                                      ),
                                      onChanged: (value) =>
                                          currentKeyword = value,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (currentKeyword.isNotEmpty) {
                                          setState(() {
                                            keywords.add(currentKeyword);
                                          });
                                          Navigator.of(context).pop();
                                        }
                                        print(keywords);
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Miscelaneous: ',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.surface,
        onPressed: () {
          print('Floating Button Clicked');
        },
        child: Icon(Icons.publish, color: theme.primary),
      ),
    );
  }
}
