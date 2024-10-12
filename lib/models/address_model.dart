class AddressModel {
  String address;
  String city;
  String stateOrRegion;
  String zipCode;
  String phone;

  AddressModel({
    required this.address,
    required this.city,
    required this.stateOrRegion,
    required this.zipCode,
    required this.phone,
  });

  // Factory method to convert from Firestore document
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      address: map['address'],
      city: map['city'],
      stateOrRegion: map['stateOrRegion'],
      zipCode: map['zipCode'],
      phone: map['phone'],
    );
  }

  // Method to convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'stateOrRegion': stateOrRegion,
      'zipCode': zipCode,
      'phone': phone,
    };
  }
}
