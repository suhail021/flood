import 'package:intl/intl.dart';

class DateUtilsHelper {
  /// Parses "HH:mm:ss" string to Duration
  static Duration parseTimeRemaining(String timeRemaining) {
    if (timeRemaining.isEmpty) return Duration.zero;
    try {
      final parts = timeRemaining.split(':');
      if (parts.length == 3) {
        return Duration(
          hours: int.parse(parts[0]),
          minutes: int.parse(parts[1]),
          seconds: int.parse(parts[2]),
        );
      }
    } catch (_) {}
    return Duration.zero;
  }

  /// Parses "X minutes/hours/days ago" to DateTime
  static DateTime parseTimeAgo(String timeAgo) {
    if (timeAgo.isEmpty) return DateTime(2000);

    final now = DateTime.now();
    final lower = timeAgo.toLowerCase();

    try {
      // Basic English parsing
      if (lower.contains('min') || lower.contains('minute')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(minutes: val));
      } else if (lower.contains('hour')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(hours: val));
      } else if (lower.contains('day')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(days: val));
      } else if (lower.contains('sec') || lower.contains('second')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(seconds: val));
      }

      // Basic Arabic parsing (if API returns Arabic)
      if (lower.contains('دقيقة') || lower.contains('دقائق')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(minutes: val));
      } else if (lower.contains('ساعة') || lower.contains('ساعات')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(hours: val));
      } else if (lower.contains('يوم') || lower.contains('أيام')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(days: val));
      } else if (lower.contains('ثانية') || lower.contains('ثواني')) {
        final val =
            int.tryParse(RegExp(r'\d+').firstMatch(lower)?.group(0) ?? '0') ??
            0;
        return now.subtract(Duration(seconds: val));
      }
    } catch (_) {}

    return DateTime(2000);
  }
}
