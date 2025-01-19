import 'package:intl/intl.dart';

class TimeFunctions {
  static String getTimeFromTimestamp(
      {required num timestamp, required int offset, bool onlyHours = false}) {
    if (onlyHours) {
      return DateFormat('h a').format(
          getDateTimeFromTimestamp(timestamp: timestamp, offset: offset));
    }
    return DateFormat('h:mm a')
        .format(getDateTimeFromTimestamp(timestamp: timestamp, offset: offset));
  }

  static String getDayFromTimestamp(
      {required num timestamp, required int offset}) {
    DateTime givenDate =
        getDateTimeFromTimestamp(timestamp: timestamp, offset: offset);

    DateTime today = DateTime.now();
    DateTime todayDate = DateTime(today.year, today.month, today.day);

    DateTime tomorrowDate = todayDate.add(const Duration(days: 1));

    if (givenDate.year == todayDate.year &&
        givenDate.month == todayDate.month &&
        givenDate.day == todayDate.day) {
      return "Today";
    } else if (givenDate.year == tomorrowDate.year &&
        givenDate.month == tomorrowDate.month &&
        givenDate.day == tomorrowDate.day) {
      return "Tomorrow";
    } else {
      return DateFormat('dd MMMM yyyy').format(givenDate);
    }
  }

  static DateTime getDateTimeFromTimestamp(
      {required num timestamp, required int offset}) {
    return (DateTime.fromMillisecondsSinceEpoch(
      timestamp.toInt() * 1000,
      isUtc: true,
    ).add(Duration(seconds: offset)));
  }
}
