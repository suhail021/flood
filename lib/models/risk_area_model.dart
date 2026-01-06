class RiskAreaResponse {
  final bool success;
  final RiskData data;
  final RiskSummary summary;
  final String lastUpdated;

  RiskAreaResponse({
    required this.success,
    required this.data,
    required this.summary,
    required this.lastUpdated,
  });

  factory RiskAreaResponse.fromJson(Map<String, dynamic> json) {
    return RiskAreaResponse(
      success: json['success'] ?? false,
      data: RiskData.fromJson(json['data'] ?? {}),
      summary: RiskSummary.fromJson(json['summary'] ?? {}),
      lastUpdated: json['last_updated'] ?? '',
    );
  }
}

class RiskData {
  final CriticalAlerts criticalAlerts;
  final List<AiPrediction> aiPredictions;

  RiskData({required this.criticalAlerts, required this.aiPredictions});

  factory RiskData.fromJson(Map<String, dynamic> json) {
    return RiskData(
      criticalAlerts: CriticalAlerts.fromJson(json['critical_alerts'] ?? {}),
      aiPredictions:
          (json['ai_predictions'] as List?)
              ?.map((e) => AiPrediction.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class CriticalAlerts {
  final List<ManualAlert> fromEmployees;

  CriticalAlerts({required this.fromEmployees});

  factory CriticalAlerts.fromJson(Map<String, dynamic> json) {
    return CriticalAlerts(
      fromEmployees:
          (json['from_employees'] as List?)
              ?.map((e) => ManualAlert.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ManualAlert {
  final int id;
  final String locationName;
  final double latitude;
  final double longitude;
  final int riskLevel; // 1-100 probably
  final String alertType; // e.g., "extended"
  final String alertTypeName;
  final int durationHours;
  final String timeRemaining;

  ManualAlert({
    required this.id,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.riskLevel,
    required this.alertType,
    required this.alertTypeName,
    required this.durationHours,
    required this.timeRemaining,
  });

  factory ManualAlert.fromJson(Map<String, dynamic> json) {
    return ManualAlert(
      id: json['id'] ?? 0,
      locationName: json['location_name'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['risk_level'] ?? 0,
      alertType: json['alert_type'] ?? '',
      alertTypeName: json['alert_type_name'] ?? '',
      durationHours: json['duration_hours'] ?? 0,
      timeRemaining: json['time_remaining'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManualAlert &&
        other.id == id &&
        other.locationName == locationName &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.riskLevel == riskLevel &&
        other.alertType == alertType &&
        other.alertTypeName == alertTypeName &&
        other.durationHours == durationHours &&
        other.timeRemaining == timeRemaining;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        locationName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        riskLevel.hashCode ^
        alertType.hashCode ^
        alertTypeName.hashCode ^
        durationHours.hashCode ^
        timeRemaining.hashCode;
  }
}

class AiPrediction {
  final int id;
  final String event;
  final int riskLevel;
  final String riskCategory; // e.g., "normal"
  final String riskLevelName; // e.g., "طبيعي"
  final String riskColor; // Hex string e.g., "#22c55e"
  final double latitude;
  final double longitude;
  final String locationName;
  final String timeAgo;

  AiPrediction({
    required this.id,
    required this.event,
    required this.riskLevel,
    required this.riskCategory,
    required this.riskLevelName,
    required this.riskColor,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.timeAgo,
  });

  factory AiPrediction.fromJson(Map<String, dynamic> json) {
    return AiPrediction(
      id: json['id'] ?? 0,
      event: json['event'] ?? '',
      riskLevel: json['risk_level'] ?? 0,
      riskCategory: json['risk_category'] ?? '',
      riskLevelName: json['risk_level_name'] ?? '',
      riskColor: json['risk_color'] ?? '#000000',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      locationName: json['location_name'] ?? '',
      timeAgo: json['time_ago'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AiPrediction &&
        other.id == id &&
        other.event == event &&
        other.riskLevel == riskLevel &&
        other.riskCategory == riskCategory &&
        other.riskLevelName == riskLevelName &&
        other.riskColor == riskColor &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.locationName == locationName &&
        other.timeAgo == timeAgo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event.hashCode ^
        riskLevel.hashCode ^
        riskCategory.hashCode ^
        riskLevelName.hashCode ^
        riskColor.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        locationName.hashCode ^
        timeAgo.hashCode;
  }
}

class RiskSummary {
  final int criticalAlertsCount;
  final int aiPredictionsCount;
  final int totalDangerAreas;

  RiskSummary({
    required this.criticalAlertsCount,
    required this.aiPredictionsCount,
    required this.totalDangerAreas,
  });

  factory RiskSummary.fromJson(Map<String, dynamic> json) {
    return RiskSummary(
      criticalAlertsCount: json['critical_alerts_count'] ?? 0,
      aiPredictionsCount: json['ai_predictions_count'] ?? 0,
      totalDangerAreas: json['total_danger_areas'] ?? 0,
    );
  }
}
