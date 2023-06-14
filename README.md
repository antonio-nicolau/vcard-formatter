Dart library to read and write vCard files.

## Features

- Read vCard data
- Easily create vCard data

## Getting started

This package uses Dart 3 so make sure you have your pubspec.yaml updated
```yaml
environment
  sdk: ^3.0.0
```

## Usage


```dart
import 'package:vcard_formatter/vcard_formatter.dart';

void main() {
  const vCardString = """
    BEGIN:VCARD
    VERSION:4.0
    N:Nicolau;Antonio;Pedro;Sr;APN
    FN:Sr Antonio Pedro Nicolau, APN
    EMAIL:antonio.tioypedro1234@gmail.com
    ORG:Flutter Developer
    TITLE:Software Engineer
    TEL:+244942492886
    TEL;type=FAX:123-123-1234
    TEL;TYPE=WORK,VOICE:(123) 456-7890
    URL;type=pref:https://antonionicolau.com
    ADR;TYPE=work:;;123 Main St;Anytown;NY;12345;USA
    BDAY:1990-06-13
    NOTE:This is a note about John Doe.
    REV:2023-06-13T12:00:00Z
    PHOTO;VALUE=URL:https://example.com/fake-photo.jpg
    PHOTO;TYPE=JPEG;VALUE=URI:data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gA7Q1JFQVRPU
    URL:https://www.linkedin.com/in/antonio-pedronicolau/
    END:VCARD
""";

  final vCardFormatter = VCard(vCardString);
  final firstName = vCardFormatter.name?.firstName;
  final lastName = vCardFormatter.name?.firstName;
  final role = vCardFormatter.position;
  final emails = vCardFormatter.emails;
}
```

## Additional information


