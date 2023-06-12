import 'package:vcard_formatter/vcard_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = VCard();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
