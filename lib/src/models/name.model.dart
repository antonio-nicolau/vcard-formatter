import 'package:vcard_formatter/src/constants/default_values.dart';

class Name {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? prefix;
  final String? suffix;

  const Name({
    this.firstName,
    this.middleName,
    this.lastName,
    this.prefix,
    this.suffix,
  });

  static Name fromList(List<String>? names) {
    if (names == null) return Name();

    String? firstName, middleName, lastName, prefix, suffix;

    if (names.length > 1) {
      lastName = names.first;
      firstName = names[1];
    }
    if (names.length >= 2) {
      prefix = getCommonNamePrefix(names);
    }
    if (names.length >= 2 && !_isNamePrefix(names[2])) {
      middleName = names[2];
    }
    if (names.length >= 4) {
      suffix = names.last;
    }

    return Name(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      prefix: prefix,
      suffix: suffix,
    );
  }

  static String? getCommonNamePrefix(List<String> names) {
    final data = names.join();
    return RegExp('(${namePrefixes.join("|")})').stringMatch(data);
  }

  static bool _isNamePrefix(String prefix) {
    return RegExp('(${namePrefixes.join("|")})').stringMatch(prefix) != null;
  }
}
