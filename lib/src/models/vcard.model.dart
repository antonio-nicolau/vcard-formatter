import 'package:vcard_formatter/src/models/address.model.dart';
import 'package:vcard_formatter/src/models/name.model.dart';
import 'package:vcard_formatter/src/models/property.model.dart';
import 'package:vcard_formatter/src/models/telephone.model.dart';

class VCard {
  final String version;
  final Name name;
  final String nickname;
  final String formattedName;
  final List<String> nameList;
  final String birthday;
  final String organization;
  final String title;
  final String position;
  final String categories;
  final String gender;
  final String note;
  final String rev;
  final List<Property> emails;
  final List<Property> urls;
  final List<Telephone> telephones;
  final List<Address> addresses;
  final String fullString;

  const VCard({
    required this.version,
    required this.name,
    required this.nickname,
    required this.formattedName,
    required this.nameList,
    required this.birthday,
    required this.organization,
    required this.title,
    required this.position,
    required this.categories,
    required this.gender,
    required this.note,
    required this.rev,
    required this.emails,
    required this.urls,
    required this.telephones,
    required this.addresses,
    required this.fullString,
  });
}
