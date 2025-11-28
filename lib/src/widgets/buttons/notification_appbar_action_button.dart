import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/notification/notification_query.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_list_screen.dart';

class NotificationAppbarActionButton extends StatelessWidget {
  const NotificationAppbarActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(notificationListQuery),
        variables: {
          'locale': 'ja', // anything is okay here. just to show the red tip.
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        bool hasUnread = (result.data?['Notifications']['docs'] as List?)
                ?.any((notification) {
              return (notification['readRecords']['docs'] as List).isEmpty;
            }) ??
            false;
        return IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationListScreen()));
          },
          icon: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications,
                size: 35,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 7,
                  height: 7,
                  margin: EdgeInsets.only(left: 15, top: 8),
                  decoration: BoxDecoration(
                    color: hasUnread ? Colors.red : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
