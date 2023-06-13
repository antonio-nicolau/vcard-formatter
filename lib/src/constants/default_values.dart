const vCardString = """
BEGIN:VCARD
VERSION:4.0
PRODID:-//BBros.us llc//bvCard.com//EN
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

List<String> namePrefixes = [
  "Mr",
  "Mrs",
  "Miss",
  "Ms",
  "Dr",
  "Prof",
  "Rev",
  "Fr",
  "Sr",
  "Br",
  "Capt",
  "Sgt",
  "Gov",
  "Pres",
  "Rep",
  "Sen",
  "Amb",
  "Hon",
  "Maj",
  "Gen",
  "Lt",
  "Col",
  "Cmdr",
  "Cpl",
  "Pvt"
];

List<String> addressTypes = [
  'HOME',
  'WORK',
  'POSTAL',
  'DOM',
];

List<String> propertyTypes = [
  'HOME',
  'INTERNET',
  'WORK',
  'PREF',
  'OTHER',
];

final telephoneTypes = [
  'TEXT',
  'TEXTPHONE',
  'VOICE',
  'VIDEO',
  'CELL',
  'PAGER',
  'FAX',
  'HOME',
  'WORK',
  'OTHER',
];
