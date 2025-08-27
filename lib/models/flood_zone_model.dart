import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

// ... existing code ...
enum FloodRiskLevel { low, medium, high, critical }

class FloodZoneModel {
  final String id;
  final String name;
  final String description;
  final List<LatLng> coordinates;
  final FloodRiskLevel riskLevel;
  final DateTime lastUpdated;

  FloodZoneModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coordinates,
    required this.riskLevel,
    required this.lastUpdated,
  });

  Color get riskColor {
    switch (riskLevel) {
      case FloodRiskLevel.low:
        return Colors.green;
      case FloodRiskLevel.medium:
        return Colors.yellow;
      case FloodRiskLevel.high:
        return Colors.orange;
      case FloodRiskLevel.critical:
        return Colors.red;
    }
  }

  String get riskText {
    switch (riskLevel) {
      case FloodRiskLevel.low:
        return 'منخفض';
      case FloodRiskLevel.medium:
        return 'متوسط';
      case FloodRiskLevel.high:
        return 'عالي';
      case FloodRiskLevel.critical:
        return 'حرج';
    }
  }

  factory FloodZoneModel.fromJson(Map<String, dynamic> json) {
    return FloodZoneModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coordinates: (json['coordinates'] as List)
          .map((coord) => LatLng(coord['lat'].toDouble(), coord['lng'].toDouble()))
          .toList(),
      riskLevel: FloodRiskLevel.values.firstWhere(
        (e) => e.toString() == 'FloodRiskLevel.${json['riskLevel']}',
      ),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coordinates': coordinates
          .map((coord) => {'lat': coord.latitude, 'lng': coord.longitude})
          .toList(),
      'riskLevel': riskLevel.toString().split('.').last,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
