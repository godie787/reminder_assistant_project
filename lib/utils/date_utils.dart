class MyDateUtils {
  static int getHourFromDate(DateTime date) {
    return date.hour;
  }

  static getMinutesFromDate(DateTime date) {
    if (date.minute == 0) {
      return '00';
    }
    return date.minute;
  }
}
