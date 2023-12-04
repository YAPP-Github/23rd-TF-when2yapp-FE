import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String getFormattedWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return '월';
      case DateTime.tuesday:
        return '화';
      case DateTime.wednesday:
        return '수';
      case DateTime.thursday:
        return '목';
      case DateTime.friday:
        return '금';
      case DateTime.saturday:
        return '토';
      case DateTime.sunday:
        return '일';
      default:
        return '';
    }
  }

  static String getFormattedDateRangeText({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (startDate.month == endDate.month) {
      return '${DateFormat('M월 d일').format(startDate)} - ${DateFormat('d일').format(endDate)}';
    } else {
      return '${DateFormat('M월 d일').format(startDate)} - ${DateFormat('M월 d일').format(endDate)}';
    }
  }

  static String getFormattedTimeRangeText({
    required String startTime,
    required String endTime,
  }) {
    return '${startTime.substring(0, 5)} - ${endTime.substring(0, 5)}';
  }

  static String getFormattedTime({
    required DateTime dateTime,
  }) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
