import 'package:vcard_formatter/src/constants/default_values.dart';
import 'package:vcard_formatter/vcard_formatter.dart';

void main() {
  final vCard = VCard(vCardString);
  print(vCard.formattedName);
}
