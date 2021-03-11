import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ExtendedClipboard {
  static const MethodChannel _channel = const MethodChannel('extended_clipboard');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> clipboard() async {
    final clipBoard = await _channel.invokeMethod('getClipboard');
    if (clipBoard != null && clipBoard is Map) {
      Map<String, dynamic> result = Map<String, dynamic>.from(clipBoard);
      if (result["data"] == null) return null;
      switch (result["type"]) {
        case "image":
          return File(result["data"]);
          break;
        case "text":
          String text = result["data"];
          if (text.contains("file://"))
            return null;
          else
            return text;
          break;
        default:
          return null;
      }
    } else
      return null;
  }
}

class ExtendedCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  final Function(File image) onPasteImage;

  ExtendedCupertinoTextSelectionControls({@required this.onPasteImage});

  @override
  Future<void> handlePaste(TextSelectionDelegate delegate) async {
    final TextEditingValue value = delegate.textEditingValue;
    final data = await ExtendedClipboard.clipboard();
    if (data != null) {
      if (data is File) {
        onPasteImage(data);
      } else if (data is String) {
        delegate.textEditingValue = TextEditingValue(
          text:
              value.selection.textBefore(value.text) + data + value.selection.textAfter(value.text),
          selection: TextSelection.collapsed(offset: value.selection.start + data.length),
        );
      }
    }
    delegate.bringIntoView(delegate.textEditingValue.selection.extent);
    delegate.hideToolbar();
  }
}
