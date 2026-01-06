class UserModel {
  final int id;
  final String phoneNumber;
  final String name;
  final String? role;
  final String? address;
  final String? city;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    this.role,
    this.address,
    this.city,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0,
      phoneNumber:
          json['phone'] ??
          json['phoneNumber'] ??
          '', // Map 'phone' from API to 'phoneNumber'
      name: json['name'] ?? '',
      role: json['role'],
      address: json['address'],
      city: json['city'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phoneNumber, // Send as 'phone' if needed, or keep standard
      'name': name,
      'role': role,
      'address': address,
      'city': city,
      'profileImage': profileImage,
    };
  }
}
