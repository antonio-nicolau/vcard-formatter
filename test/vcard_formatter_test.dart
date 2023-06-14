import 'package:vcard_formatter/src/constants/default_values.dart';
import 'package:vcard_formatter/src/models/name.model.dart';
import 'package:vcard_formatter/vcard_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('VCard tests', () {
    final vcard = VCard(vCardString);

    test('should get Name', () {
      expect(vcard.name, isA<Name>());
      expect(vcard.name?.firstName, isNotEmpty);
      expect(vcard.name?.middleName, isNotEmpty);
      expect(vcard.name?.lastName, isNotEmpty);
    });

    test('should get Name List', () {
      expect(vcard.nameList, isList);
      expect(vcard.nameList, isNotEmpty);
    });

    test('should get Formatted name', () {
      expect(vcard.formattedName, isNotEmpty);
      expect(vcard.formattedName, 'Sr Antonio Pedro Nicolau, APN');
    });
  });
}
