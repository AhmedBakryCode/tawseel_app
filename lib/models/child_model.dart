class Child {
  final String name;
  final String phone;
  final String gender;
  final String level;
  final String birthDate;

  Child({
    required this.name,
    required this.phone,
    required this.gender,
    required this.level,
    required this.birthDate,
  });

  factory Child.fromFirestore(Map<String, dynamic> data) {
    return Child(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      gender: data['gender'] ?? '',
      level: data['level'] ?? '',
      birthDate: data['birth_date'] ?? '',
    );
  }
}
