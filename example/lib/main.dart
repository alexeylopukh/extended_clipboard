import 'dart:io';

import 'package:extended_clipboard/extended_clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  File file;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                selectionControls: Platform.isAndroid
                    ? null
                    : ExtendedCupertinoTextSelectionControls(onPasteImage: (File image) {
                        file = image;
                        setState(() {});
                      }),
              ),
              if (file != null) Image.file(file)
            ],
          ),
        ),
      ),
    );
  }
}
