import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static int getDayFromDate(DateTime date) {
    return date.day;
  }

  static int getMonthFromDate(DateTime date) {
    return date.month;
  }

  static int getYearFromDate(DateTime date) {
    return date.year;
  }

  static int getHourFromDate(DateTime date) {
    return date.hour;
  }

  static getMinutesFromDate(DateTime date) {
    if (date.minute == 0) {
      return '00';
    }
    return date.minute;
  }

  static DateTime convertToDate(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  static DateTime getCurrentDate() {
    return DateTime.now();
  }
}
