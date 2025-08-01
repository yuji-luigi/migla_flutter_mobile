import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime, {String localeCode = 'en'}) {
  if (localeCode != 'ja') {
    return DateFormat('dd MMMM yyyy', localeCode).format(
      dateTime,
    );
  } else {
    return DateFormat('yyyy/MM/dd', localeCode).format(
      dateTime,
    );
  }
}
