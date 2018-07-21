import 'package:intl/intl.dart';

class DateUtils {
  static final _dateFormat = new DateFormat("dd/MM/yyyy");

  static String formatDate(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }

  static String formatTime(int dateTime) {
    return new DateFormat.jm().format(new DateTime.fromMillisecondsSinceEpoch(dateTime));
  }

}
