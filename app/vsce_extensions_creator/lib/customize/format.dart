import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:path_provider/path_provider.dart';

import '../functionals/functions.dart';
import 'dart:convert';
import 'dart:io';

class FormatPage extends StatefulWidget {
  const FormatPage({super.key});


  @override
  State<FormatPage> createState() => _FormatPageState();
}

class _FormatPageState extends State<FormatPage> {
  _FormatPageState();
  final _formKey = GlobalKey<FormState>();

  String currentKeyword = '';

  List<String> keywords = [];

  @override
  void initState() {
    super.initState();
    _asyncCallForKeywords();
  }

  _asyncCallForKeywords() async {
    final dir = await getApplicationDocumentsDirectory();
    File jsonFile = File(
        "${dir.path}/GitHub/Moonshot_Docs/ALGOSUP_Moonshot_Project/app/vsce_extensions_creator/lib/storage/format.json");
    var jsonData = json.decode(jsonFile.readAsStringSync());
    setState(() {
      keywords = jsonData['keywords'].cast<String>();
    });
  }

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
                      width: keywords[i].length * 10.0,
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
                      onPressed: () async {
                        keywords.removeAt(i);
                        Map<String, dynamic> data = {
                          'keywords': keywords,
                        };
                        String datas = jsonEncode(data);
                        await writeData(
                                datas,
                                '../vsce_extensions_creator/lib/storage',
                                'keywords.json')
                            .then((value) {
                          setState(() {});
                        });
                      },
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
                                  onPressed: () async {
                                    keywords.add(currentKeyword);
                                    if (currentKeyword.isNotEmpty) {
                                      Map<String, dynamic> data = {
                                        'keywords': keywords,
                                      };
                                      String datas = jsonEncode(data);
                                      await writeData(
                                              datas,
                                              '../vsce_extensions_creator/lib/storage',
                                              'keywords.json')
                                          .then((value) {
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      });
                                    }
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
      floatingActionButton: FloatingActionButton(
        // backgroundColor: theme.onSurface,
        onPressed: () async {
          Map<String, dynamic> data = {
            'keywords': keywords,
          };
          String datas = jsonEncode(data);
          await writeData(datas, '../vsce_extensions_creator/lib/storage',
                  'keywords.json')
              .then((value) {
            keywords = data['keywords'].cast<String>();
            return Future.delayed(const Duration(seconds: 1));
            // sleep(const Duration(seconds: 1));
          }).then((onValue) {
            setState(() {});
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
