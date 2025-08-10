import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/models/api/read_notification/create_read_notification_query.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/providers/my_graphql_provider.dart';
import 'package:migla_flutter/src/screens/dashboard/payment_record_screens/payment_record_detail_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationListTileOnTapController {
  final NotificationModel notification;
  final BuildContext context;
  final int userId;
  final GraphQLClient _gqlClient;

  NotificationListTileOnTapController({
    required this.notification,
    required this.context,
    required this.userId,
  }) : _gqlClient = getGqlClient(context);

  void handleOnTap() {
    switch (notification.collection) {
      case 'payment-schedules':
        _callReadNotification();
        _navigateToPaymentRecordDetail(context);
        break;
      case 'reports':
        _navigateToReportDetail(context);
        break;
      default:
        // For unknown collections, you might want to show a default screen
        // or handle it differently based on your requirements
        _showDefaultNotificationDetail(context);
        break;
    }
  }

  void _navigateToPaymentRecordDetail(BuildContext context) {
    if (notification.collectionRecordId > 0) {
      PaymentRecordDetailScreen(scheduleId: notification.collectionRecordId)
          .launch(context);
    } else {
      _showErrorDialog(context, 'Invalid payment record ID');
    }
  }

  void _navigateToReportDetail(BuildContext context) {
    if (notification.collectionRecordId > 0) {
      TeacherReportDetailScreen(id: notification.collectionRecordId)
          .launch(context);
    } else {
      _showErrorDialog(context, 'Invalid report ID');
    }
  }

  Future<void> _callReadNotification() async {
    final gqlClient = getGqlClient(context);

    final result = await gqlClient.mutate(MutationOptions(
      document: gql(createReadNotificationQuery),
      variables: {
        'notificationId': notification.id,
        'userId': userId,
      },
    ));
    Logger.info('✅ Read notification result: $result');
  }

  void _showDefaultNotificationDetail(BuildContext context) {
    // You can implement a default notification detail screen here
    // or show a dialog indicating the notification type is not supported
    _showErrorDialog(context, 'This notification type is not supported yet');
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
