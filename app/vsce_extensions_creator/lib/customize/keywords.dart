import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class KeywordsPage extends StatefulWidget {
  const KeywordsPage({super.key});

  @override
  State<KeywordsPage> createState() => _KeywordsPageState();
}

class _KeywordsPageState extends State<KeywordsPage> {
  final _formKey = GlobalKey<FormState>();

  String currentKeyword = '';

  List<String> keywords = ["if"];

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = AdaptiveTheme.of(context).theme.colorScheme;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (keywords.isEmpty)
              Text(
                'No Keywords Found',
                style: TextStyle(
                  fontSize: 20,
                  color: theme.onSurface,
                ),
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
                        controller: TextEditingController(text: keywords[i]),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.onSurface,
                        ),
                        onChanged: (value) {
                          keywords[i] = value;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.highlight_remove_sharp,
                          color: theme.onSurface),
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
                                  onChanged: (value) => currentKeyword = value,
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
              icon: Icon(Icons.add, color: theme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
