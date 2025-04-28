class CountdownTimerService {
  DateTime parseDateTime(String eventDate, String eventTime) {
    try {
      // Splitting and parsing the date
      List<String> dateParts = eventDate.split('-');
      if (dateParts.length != 3) {
        throw const FormatException(
            "Invalid date format. Expected format: YYYY-MM-DD");
      }
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);

      // Splitting and parsing the time
      eventTime = eventTime.replaceAll(' ', '');
      String period = eventTime.substring(eventTime.length - 2).toUpperCase();
      String time = eventTime.substring(0, eventTime.length - 2).trim();
      List<String> hourMinuteParts = time.split(':');
      if (hourMinuteParts.length != 2) {
        throw const FormatException(
            "Invalid time format. Expected format: hh:mmAM/PM");
      }
      int hour = int.parse(hourMinuteParts[0]);
      int minute = int.parse(hourMinuteParts[1]);

      // Adjusting for AM/PM
      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      // print('Error parsing date or time: $e');
      rethrow;
    }
  }
}
