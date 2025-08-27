class UserModel {
  final String id;
  final String phoneNumber;
  final String name;
  final String address;
  final String city;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.city,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'address': address,
      'city': city,
      'profileImage': profileImage,
    };
  }
}
