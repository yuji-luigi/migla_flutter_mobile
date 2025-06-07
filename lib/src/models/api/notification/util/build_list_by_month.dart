import 'package:intl/intl.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';

List<Object> buildDisplayList(List<NotificationModel> notifications) {
  // a) group by year-month
  final map = <String, List<NotificationModel>>{};
  for (var n in notifications) {
    final dt = DateTime.parse(n.createdAt);
    final key = DateFormat.yMMMM().format(dt); // e.g. "June 2025"
    map.putIfAbsent(key, () => []).add(n);
  }
  // b) sort the keys however you like (newest month first?)
  final sortedKeys = map.keys.toList()
    ..sort((a, b) => map[b]![0]
        .createdAt
        .compareTo(map[a]![0].createdAt)); // or parse the dates for accuracy

  // c) flatten into a single list of dynamic entries
  final display = <Object>[];
  for (var month in sortedKeys) {
    display.add(month); // a String header
    display.addAll(map[month]!); // then the notifications for that month
  }
  return display;
}
