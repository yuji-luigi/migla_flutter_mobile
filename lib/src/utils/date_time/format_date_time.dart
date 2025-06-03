import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('dd MMMM yyyy').format(dateTime);
}
