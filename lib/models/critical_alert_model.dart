class CriticalAlertResponse {
  final bool success;
  final bool hasAlerts;
  final AlertCounts count;
  final AlertsList? alerts;
  final String lastUpdated;

  CriticalAlertResponse({
    required this.success,
    required this.hasAlerts,
    required this.count,
    this.alerts,
    required this.lastUpdated,
  });

  factory CriticalAlertResponse.fromJson(Map<String, dynamic> json) {
    return CriticalAlertResponse(
      success: json['success'] ?? false,
      hasAlerts: json['has_alerts'] ?? false,
      count: AlertCounts.fromJson(json['count']),
      alerts:
          json['alerts'] != null ? AlertsList.fromJson(json['alerts']) : null,
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}

class AlertCounts {
  final int fromAi;
  final int fromEmployees;
  final int total;

  AlertCounts({
    required this.fromAi,
    required this.fromEmployees,
    required this.total,
  });

  factory AlertCounts.fromJson(Map<String, dynamic> json) {
    return AlertCounts(
      fromAi: json['from_ai'] ?? 0,
      fromEmployees: json['from_employees'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class AlertsList {
  final List<CriticalAlert> fromAi;
  final List<CriticalAlert> fromEmployees;

  AlertsList({required this.fromAi, required this.fromEmployees});

  factory AlertsList.fromJson(Map<String, dynamic> json) {
    return AlertsList(
      fromAi:
          (json['from_ai'] as List?)
              ?.map((e) => CriticalAlert.fromJson(e))
              .toList() ??
          [],
      fromEmployees:
          (json['from_employees'] as List?)
              ?.map((e) => CriticalAlert.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class CriticalAlert {
  final int id;
  final String type;
  final String source;
  final String locationName;
  final double latitude;
  final double longitude;
  final int riskLevel;
  final int predictionsCount;
  final String alertType;
  final String alertTypeName;
  final int durationHours;
  final String firstDetectedAt;
  final String lastUpdatedAt;
  final String expiresAt;
  final String timeRemaining;

  CriticalAlert({
    required this.id,
    required this.type,
    required this.source,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.riskLevel,
    required this.predictionsCount,
    required this.alertType,
    required this.alertTypeName,
    required this.durationHours,
    required this.firstDetectedAt,
    required this.lastUpdatedAt,
    required this.expiresAt,
    required this.timeRemaining,
  });

  factory CriticalAlert.fromJson(Map<String, dynamic> json) {
    return CriticalAlert(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      source: json['source'] ?? '',
      locationName: json['location_name'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['risk_level'] ?? 0,
      predictionsCount: json['predictions_count'] ?? 0,
      alertType: json['alert_type'] ?? '',
      alertTypeName: json['alert_type_name'] ?? '',
      durationHours: json['duration_hours'] ?? 0,
      firstDetectedAt: json['first_detected_at'] ?? '',
      lastUpdatedAt: json['last_updated_at'] ?? '',
      expiresAt: json['expires_at'] ?? '',
      timeRemaining: json['time_remaining'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'source': source,
      'location_name': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'risk_level': riskLevel,
      'predictions_count': predictionsCount,
      'alert_type': alertType,
      'alert_type_name': alertTypeName,
      'duration_hours': durationHours,
      'first_detected_at': firstDetectedAt,
      'last_updated_at': lastUpdatedAt,
      'expires_at': expiresAt,
      'time_remaining': timeRemaining,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CriticalAlert &&
        other.id == id &&
        other.type == type &&
        other.source == source &&
        other.locationName == locationName &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.riskLevel == riskLevel &&
        other.predictionsCount == predictionsCount &&
        other.alertType == alertType &&
        other.alertTypeName == alertTypeName &&
        other.durationHours == durationHours &&
        other.firstDetectedAt == firstDetectedAt &&
        other.lastUpdatedAt == lastUpdatedAt &&
        other.expiresAt == expiresAt &&
        other.timeRemaining == timeRemaining;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        source.hashCode ^
        locationName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        riskLevel.hashCode ^
        predictionsCount.hashCode ^
        alertType.hashCode ^
        alertTypeName.hashCode ^
        durationHours.hashCode ^
        firstDetectedAt.hashCode ^
        lastUpdatedAt.hashCode ^
        expiresAt.hashCode ^
        timeRemaining.hashCode;
  }
}
