import 'package:intl/intl.dart';

String formatDateAndDay(DateTime savedAt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  if (savedAt.isAfter(today)) {
    return 'Today';
  } else if (savedAt.isAfter(yesterday)) {
    return 'Yesterday';
  } else {
    final formatter = DateFormat('d, MMM yyyy'); // Example: 15, Sept 2024
    return formatter.format(savedAt);
  }
}

String getFormattedTimeOnly(DateTime savedAt) {
  //final now = DateTime.now();
  final DateFormat timeFormat = DateFormat('hh:mm a'); // Example: 02:30 PM
  return timeFormat.format(savedAt);
}
