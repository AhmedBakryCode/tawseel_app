class CartItem {
  final String name;
  final String nationality;
  final String level;
  final double amount;

  CartItem({
    required this.name,
    required this.nationality,
    required this.level,
    required this.amount,
  });

  // Factory method to create a CartItem from Firestore data
  factory CartItem.fromMap(Map<String, dynamic> data) {
    return CartItem(
      name: data['name'] ?? '',
      nationality: data['nationality'] ?? '',
      level: data['level'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
    );
  }
}
