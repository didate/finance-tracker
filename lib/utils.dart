import 'package:intl/intl.dart';

class Utils {
  static final List<String> day = [
    'Mon',
    "Tue",
    "Wed",
    "Thu",
    'Fri',
    'Sat',
    'Sun'
  ];

  static final _timeFormat = DateFormat.Hm();
  static final _monthDayFormat = DateFormat.MMMd();
  static final _format = DateFormat.yMMMMd();

  static final _fgFormat =
      NumberFormat.currency(locale: "fr_FR", symbol: '', decimalDigits: 0);

  static String getDate(DateTime date) {
    String value = '';

    if (isToday(date)) {
      value = 'Today';
      // _timeFormat.format(date);
    } else if (isThisWeek(date)) {
      value = day[date.weekday - 1];
    } else if (isThisYear(date)) {
      value = _monthDayFormat.format(date);
    } else {
      value = _format.format(date);
    }
    return value;
  }

  static bool isToday(DateTime t) {
    final now = DateTime.now();
    bool istoday = false;
    if (t.year == now.year && t.month == now.month && t.day == now.day) {
      istoday = true;
    }
    return istoday;
  }

  static bool isThisWeek(DateTime t) {
    final now = DateTime.now();
    bool isweek = false;
    if (t.year == now.year && getWeek(t) == getWeek(now)) {
      isweek = true;
    }
    return isweek;
  }

  static int getWeek(DateTime date) {
    final from = DateTime.utc(date.year, 1, 1);
    final to = DateTime.utc(date.year, date.month, date.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  static bool isThisYear(DateTime t) {
    final now = DateTime.now();
    bool isYear = false;
    if (t.year == now.year) {
      isYear = true;
    }
    return isYear;
  }

  static getCurrencyFormat(int amount) {
    return _fgFormat.format(amount);
  }
}
