class FloodAlertModel {
  final String id;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String userId;
  final DateTime createdAt;
  final String status; // pending, confirmed, resolved

  FloodAlertModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.createdAt,
    required this.status,
  });

  factory FloodAlertModel.fromJson(Map<String, dynamic> json) {
    return FloodAlertModel(
      id: json['id'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
