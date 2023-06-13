import 'dart:convert';

import 'package:vcard_formatter/src/constants/default_values.dart';
import 'package:vcard_formatter/src/constants/vcard_structure_properties.dart';
import 'package:vcard_formatter/src/models/address.model.dart';
import 'package:vcard_formatter/src/models/name.model.dart';
import 'package:vcard_formatter/src/models/property.model.dart';
import 'package:vcard_formatter/src/models/telephone.model.dart';

class VCard {
  String vCardString;
  late List<String> lines;

  VCard(this.vCardString) {
    lines = LineSplitter().convert(vCardString);
    for (var i = lines.length - 1; i >= 0; i--) {
      if (lines[i].startsWith("BEGIN:VCARD") || lines[i].startsWith("END:VCARD") || lines[i].trim().isEmpty) {
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

  String get fullString => vCardString;

  String? getFirstPrefixValue(String prefix) {
    final response = getAllPrefixValues(prefix);
    if (response.isEmpty) return null;
    return response.first;
  }

  List<String> getAllPrefixValues(String prefix) {
    final result = <String>[];

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].toUpperCase().startsWith(prefix.toUpperCase())) {
        String word = lines[i];
        word = word.substring(prefix.length, word.length);
        result.add(word);
      }
    }
    return result;
  }

  String? _stripFirstColon(String? baseString) {
    if (baseString == null) return null;

    return RegExp(r'(?<=:).+').firstMatch(baseString)?.group(0);
  }

  List<String>? get name => _stripFirstColon(getFirstPrefixValue(nameProperty))?.split(";");
  Name get nameAsObject => Name.fromList(name);
  String? get formattedName => _stripFirstColon(getFirstPrefixValue(formattedNameProperty));
  String? get nickname => _stripFirstColon(getFirstPrefixValue(nickNameProperty));
  String? get birthday => _stripFirstColon(getFirstPrefixValue(birthDateProperty));
  String? get organization => _stripFirstColon(getFirstPrefixValue(organizationProperty));
  String? get title => _stripFirstColon(getFirstPrefixValue(titleProperty));
  String? get position => _stripFirstColon(getFirstPrefixValue(roleProperty));
  String? get categories => _stripFirstColon(getFirstPrefixValue(categoriesProperty));
  String? get gender => _stripFirstColon(getFirstPrefixValue(genderProperty));
  String? get note => _stripFirstColon(getFirstPrefixValue(noteProperty));
  String? get rev => _stripFirstColon(getFirstPrefixValue(revProperty));
  String? get version => getFirstPrefixValue(versionProperty) ?? "3.0";
  List<Property> get emails => _typedProperty(emailProperty);
  List<Property> get urls => _typedProperty(urlProperty);

  List<Telephone> get typedTelephone {
    final phones = <Telephone>[];
    String? phone, type;
    final telephones = getAllPrefixValues(telephoneProperty);

    for (String tel in telephones) {
      if (version == "2.1" || version == "3.0") {
        phone = RegExp(r'(?<=:).+$').firstMatch(tel)?.group(0) ?? '';
      } else if (version == "4.0") {
        phone = RegExp(r'(?<=:).+(?=\D|$)').stringMatch(tel) ?? '';
        type = RegExp(r'(?<=;type=)[aA-zZ]+', caseSensitive: false).stringMatch(tel);
      }

      if (!telephoneTypes.contains(type?.toUpperCase())) {
        type = null;
      }

      phones.add(Telephone(phone: phone, type: type));
    }

    return phones;
  }

  List<Property> _typedProperty(String property) {
    // base function for getting typed EMAIL+URL
    final result = <Property>[];
    String? res, type;

    final matches = getAllPrefixValues(property);

    for (String match in matches) {
      res = RegExp(r'(?<=:).+$').firstMatch(match)?.group(0) ?? '';
      print(match);

      for (final element in propertyTypes) {
        if (match.toUpperCase().contains(element)) {
          type = (type ?? '') + element;
        }
      }

      if (res.isNotEmpty) {
        result.add(Property(res, type));
      }
      type = null;
    }

    return result;
  }

  List<Address> get address {
    final result = <Address>[];
    String? adr, type;

    final addresses = getAllPrefixValues(addressProperty);

    for (String item in addresses) {
      if (version == '4.0' || version == '3.0') {
        adr = RegExp(r'(?<=(;|:);).+$').firstMatch(item)?.group(0);
      } else {
        adr = RegExp(r'(?<=LABEL=").+(?=":;)').firstMatch(item)?.group(0);
      }

      // Get address type
      type = RegExp(r'(?<=;type=)[aA-zZ]+', caseSensitive: false).stringMatch(item);

      //remove leading semicolon
      if (adr?.startsWith(r';') == true) {
        adr = adr?.substring(1);
      }

      result.add(Address.fromString(adr, type));
      adr = null;
      type = null;
    }

    return result;
  }
}
