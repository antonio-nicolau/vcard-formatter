import 'dart:convert';
import 'package:vcard_formatter/src/constants/vcard_structure_properties.dart';
import 'package:vcard_formatter/src/models/address.model.dart';
import 'package:vcard_formatter/src/models/name.model.dart';
import 'package:vcard_formatter/src/models/property.model.dart';
import 'package:vcard_formatter/src/models/telephone.model.dart';
import 'package:vcard_formatter/src/vcard_formatter.service.dart';

class VCard {
  late VCardFormatterService _service;
  late VCard vCard;
  late String vCardString;
  late List<String> lines;
  String? version;
  Name? name;
  String? nickname;
  String? formattedName;
  List<String>? nameList;
  String? birthday;
  String? organization;
  String? title;
  String? position;
  String? categories;
  String? gender;
  String? note;
  String? rev;
  List<Property>? emails;
  List<Property>? urls;
  List<Telephone>? telephones;
  List<Address>? addresses;
  String? fullString;

  VCard(this.vCardString) {
    lines = LineSplitter().convert(vCardString);
    _service = VCardFormatterService(lines);

    _readVCard();
    _createVCardObject();
  }

  void _createVCardObject() {
    version = _service.getFirstPrefixValue(versionProperty);
    nameList = _service.getFirstPrefixValue(nameProperty).split(";");
    name = Name.fromList(nameList);
    formattedName = _service.getFirstPrefixValue(formattedNameProperty);
    nickname = _service.getFirstPrefixValue(nickNameProperty);
    birthday = _service.getFirstPrefixValue(birthDateProperty);
    organization = _service.getFirstPrefixValue(organizationProperty);
    title = _service.getFirstPrefixValue(titleProperty);
    position = _service.getFirstPrefixValue(roleProperty);
    categories = _service.getFirstPrefixValue(categoriesProperty);
    gender = _service.getFirstPrefixValue(genderProperty);
    note = _service.getFirstPrefixValue(noteProperty);
    rev = _service.getFirstPrefixValue(revProperty);
    emails = _service.typedProperty(emailProperty);
    urls = _service.typedProperty(urlProperty);
    telephones = _service.getTelephones();
    addresses = _service.getAddress();
  }

  void _readVCard() {
    for (var i = lines.length - 1; i >= 0; i--) {
      if (lines[i].startsWith(beginCardString) || lines[i].startsWith(endCardString) || lines[i].trim().isEmpty) {
        lines.removeAt(i);
      }
    }

    for (var i = lines.length - 1; i >= 0; i--) {
      if (!lines[i].startsWith(RegExp(r'^\S+(:|;)'))) {
        String tmpLine = lines[i];
        String prevLine = lines[i - 1];
        lines[i - 1] = '$prevLine, $tmpLine';
        lines.removeAt(i);
      }
    }
  }
}
