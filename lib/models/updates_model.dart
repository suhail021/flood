class UpdatesResponse {
  final bool success;
  final bool hasUpdates;
  final List<UpdateItem> updates;
  final String serverTime;

  UpdatesResponse({
    required this.success,
    required this.hasUpdates,
    required this.updates,
    required this.serverTime,
  });

  factory UpdatesResponse.fromJson(Map<String, dynamic> json) {
    return UpdatesResponse(
      success: json['success'] ?? false,
      hasUpdates: json['has_updates'] ?? false,
      updates:
          (json['updates'] as List?)
              ?.map((e) => UpdateItem.fromJson(e))
              .toList() ??
          [],
      serverTime: json['server_time'] ?? '',
    );
  }
}

class UpdateItem {
  final int id;
  final String type; // 'critical_alert', 'risk_area'
  final String action; // 'new', 'update', 'delete'
  final String source;
  final Map<String, dynamic> data;
  final String updatedAt;

  UpdateItem({
    required this.id,
    required this.type,
    required this.action,
    required this.source,
    required this.data,
    required this.updatedAt,
  });

  factory UpdateItem.fromJson(Map<String, dynamic> json) {
    return UpdateItem(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      action: json['action'] ?? '',
      source: json['source'] ?? '',
      data: json['data'] ?? {},
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
