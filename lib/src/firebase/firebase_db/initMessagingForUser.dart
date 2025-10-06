import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/mutate_create_fcm_token.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/query_fcm_token.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

Future<void> initMessagingForUser({
  required int userId,
  required GraphQLClient gqlClient,
}) async {
  if (Platform.isAndroid) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

// current fcmToken from Device(APP)
  final String? fcmTokenInDevice =
      await FirebaseMessaging.instance.getToken().catchError((e) {
    Logger.info(
        '❌ Error getting FCM token. \nif this is not from a simulator, this is an error');
    return null;
  });
  // context.showSnackbar(
  //     'got fcm token of the device: ${fcmTokenInDevice?.substring(0, 10)}');
  final fcmTokenByUserIdResult = await gqlClient.query(QueryOptions(
    document: gql(fcmTokenQueryByUserIdAndToken),
    variables: {
      'userId': userId,
      'token': fcmTokenInDevice,
    },
  ));
  if (fcmTokenByUserIdResult.data?['FcmTokens']['totalDocs'] > 0) {
    // context.showErrorSnackbar('fcm token already saved for the user');
    Logger.info(
        '✅ same FCM Token already saved for the user. new token not needed');
    return;
  }

  final osName = Platform.operatingSystem; // "android" or "ios"
  final osVersion = Platform
      .operatingSystemVersion; // e.g. "Android 14 (API 34)" or "Version 17.5 (Build 21F79)"

  final result = await gqlClient.mutate(MutationOptions(
    document: gql(createFcmTokenMutation),
    variables: {
      'userId': userId,
      'token': fcmTokenInDevice,
      'osName': osName,
      'osVersion': osVersion,
    },
  ));
  if (result.hasException) {
    // context.showErrorSnackbar('GraphQL Error: ${result.exception}');
    Logger.error('❌ GraphQL Error: ${result.exception}');
  } else {
    // context.showSnackbar(
    // 'FCM updated on server. \n token:${result.data!['createFcmToken']['token']} \n id:${result.data!['createFcmToken']['id']}');

    Logger.info('✅ FCM updated on server: '
        '${result.data!['createFcmToken']['token']}');
  }
}
