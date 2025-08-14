import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime,
    {String localeCode = 'en', yearMonth = false}) {
  if (localeCode == 'ja') {
    final format = yearMonth ? 'yyyy年MMMM' : 'yyyy年MMMMd日';
    // 8月8日
    return DateFormat(format, localeCode).format(
      dateTime,
    );
  } else {
    final format = yearMonth ? 'MMMM yyyy' : 'dd MMMM yyyy';
    return DateFormat(format, localeCode).format(dateTime);
  }
}
