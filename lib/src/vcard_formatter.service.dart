import 'package:vcard_formatter/src/constants/default_values.dart';
import 'package:vcard_formatter/src/constants/vcard_structure_properties.dart';
import 'package:vcard_formatter/src/models/address.model.dart';
import 'package:vcard_formatter/src/models/property.model.dart';
import 'package:vcard_formatter/src/models/telephone.model.dart';

class VCardFormatterService {
  final List<String> _lines;
  late String _version;

  VCardFormatterService(this._lines) {
    _version = getFirstPrefixValue(versionProperty);
  }

  String getFirstPrefixValue(String prefix) {
    final response = getAllPrefixValues(prefix);
    if (response.isEmpty) return '';

    return _stripFirstColon(response.first) ?? '';
  }

  List<String> getAllPrefixValues(String prefix) {
    final result = <String>[];

    for (int i = 0; i < _lines.length; i++) {
      if (_lines[i].toUpperCase().startsWith(prefix.toUpperCase())) {
        String word = _lines[i];
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

  List<Telephone> getTelephones() {
    final result = <Telephone>[];
    String? phone, type;
    final telephones = getAllPrefixValues(telephoneProperty);

    for (String tel in telephones) {
      if (_version == "2.1" || _version == "3.0") {
        phone = RegExp(r'(?<=:).+$').firstMatch(tel)?.group(0) ?? '';
      } else if (_version == "4.0") {
        phone = RegExp(r'(?<=:).+(?=\D|$)').stringMatch(tel) ?? '';
        type = RegExp(r'(?<=;type=)[aA-zZ]+', caseSensitive: false).stringMatch(tel);
      }

      if (!telephoneTypes.contains(type?.toUpperCase())) {
        type = null;
      }

      result.add(Telephone(phone: phone, type: type));
    }

    return result;
  }

  List<Property> typedProperty(String property) {
    // base function for getting typed EMAIL+URL
    final result = <Property>[];
    String? res, type;

    final matches = getAllPrefixValues(property);

    for (String match in matches) {
      res = RegExp(r'(?<=:).+$').firstMatch(match)?.group(0) ?? '';

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

  List<Address> getAddress() {
    final result = <Address>[];
    String? adr, type;

    final addresses = getAllPrefixValues(addressProperty);

    for (String item in addresses) {
      if (_version == '4.0' || _version == '3.0') {
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
