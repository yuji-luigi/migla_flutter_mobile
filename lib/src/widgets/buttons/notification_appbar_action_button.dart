import 'package:flutter/material.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_list_screen.dart';

class NotificationAppbarActionButton extends StatelessWidget {
  const NotificationAppbarActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationListScreen()));
        },
        icon: const Icon(
          Icons.notifications,
          size: 35,
        ));
  }
}
