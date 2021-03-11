import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:extended_clipboard/extended_clipboard.dart';

void main() {
  const MethodChannel channel = MethodChannel('extended_clipboard');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ExtendedClipboard.platformVersion, '42');
  });
}
