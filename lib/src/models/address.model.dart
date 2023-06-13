class Address {
  final String? street;
  final String? extendedAddress;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? type;

  const Address({
    this.street,
    this.extendedAddress,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.type,
  });

  factory Address.fromString(String? value, String? type) {
    String? street;
    String? extendedAddress;
    String? city;
    String? state;
    String? postalCode;
    String? country;

    final address = value?.split(';') ?? [];

    if (address.isEmpty) return Address();

    street = address.first;
    if (address.length > 1) {
      extendedAddress = address[1];
      city = address[2];
      state = address[3];
      postalCode = address[4];
      country = address.last;
    }

    return Address(
      street: street,
      extendedAddress: extendedAddress,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      type: type,
    );
  }

  @override
  String toString() {
    return 'Address(type:$type, street: $street, extendedAddress: $extendedAddress,city: $city,state: $state,postalCode: $postalCode,country: $country,),';
  }
}
