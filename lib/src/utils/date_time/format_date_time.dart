import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime, {String localeCode = 'en'}) {
  if (localeCode == 'ja') {
    // 8月8日
    return DateFormat('yyyy年MMMMd日', localeCode).format(
      dateTime,
    );
  } else {
    return DateFormat('dd MMMM yyyy', localeCode).format(
      dateTime,
    );
  }
}
