import 'dart:convert';
import 'package:intl/intl.dart';

class DateTimeUtils {
  /// Formats a timestamp (in milliseconds) into a human-readable string.
  ///
  /// The default format is 'dd-MM-yyyy HH:mm a'. You can customize the format using the `format` parameter.
  static String formatTimestamp(int timestamp, {String format = 'dd-MM-yyyy HH:mm a'}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(format).format(dateTime);
  }

  /// Converts a timestamp (in milliseconds) to a DateTime object.
  static DateTime convertMillisecondsToDateTime(int millisecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  /// An alias for `convertMillisecondsToDateTime` for convenience.
  static DateTime getDateFromTimestamp(int timestamp) {
    return convertMillisecondsToDateTime(timestamp);
  }

  /// Extracts the date part from a timestamp and formats it as 'MMMM dd, yyyy'.
  static String extractDate(int timestamp) {
    final dateTime = convertMillisecondsToDateTime(timestamp);
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  /// Extracts the time part from a timestamp and formats it as 'HH:mm a'.
  static String extractTime(int timestamp) {
    final dateTime = convertMillisecondsToDateTime(timestamp);
    return DateFormat('HH:mm a').format(dateTime);
  }
}
