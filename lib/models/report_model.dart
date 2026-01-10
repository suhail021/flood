class ReportModel {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final String description;
  final String image;
  final String status;
  final String? statusName;
  final String? statusColor;
  final String addedAt;
  final String updatedAt;

  ReportModel({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
    required this.status,
    this.statusName,
    this.statusColor,
    required this.addedAt,
    required this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    // Check if location is nested
    double lat = 0.0;
    double lng = 0.0;

    if (json['location'] != null && json['location'] is Map) {
      lat = double.tryParse(json['location']['lat'].toString()) ?? 0.0;
      lng = double.tryParse(json['location']['lng'].toString()) ?? 0.0;
    } else {
      // Fallback for single alarm response format
      lat = double.tryParse(json['latitude'].toString()) ?? 0.0;
      lng = double.tryParse(json['longitude'].toString()) ?? 0.0;
    }

    return ReportModel(
      id: json['id'] ?? json['alarm_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      latitude: lat,
      longitude: lng,
      description: json['description'] ?? '',
      image: _parseImage(json['image_url'] ?? json['image']),
      status: json['status'] ?? 'pending',
      statusName: json['status_name'],
      statusColor: json['status_color'],
      addedAt: json['date'] ?? json['added_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
  }

  String _parseImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    
    // Remove /api from base url to get root domain
    // Old: https://domain.com/api
    // New: https://domain.com
    const String baseUrl = 'https://mintcream-kudu-673423.hostingersite.com';
    
    if (imagePath.startsWith('/')) {
      return '$baseUrl$imagePath';
    }
    return '$baseUrl/$imagePath';
  }
