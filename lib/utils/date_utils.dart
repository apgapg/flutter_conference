import 'package:intl/intl.dart';

class DateUtils {
  static final _dateFormat = new DateFormat("dd/MM/yyyy");

  static String format(DateTime dateTime) {
    return _dateFormat.format(dateTime);
  }
}
