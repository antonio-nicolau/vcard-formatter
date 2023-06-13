class Telephone {
  final String? phone;
  final String? type;

  const Telephone({required this.phone, required this.type});

  @override
  String toString() {
    return 'Telephone(phone: $phone, type: $type)';
  }
}
