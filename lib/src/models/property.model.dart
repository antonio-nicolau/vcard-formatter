class Property {
  final String? value;
  final String? type;

  const Property(this.value, this.type);

  @override
  String toString() {
    return 'Property(value: $value, type: $type)';
  }
}
