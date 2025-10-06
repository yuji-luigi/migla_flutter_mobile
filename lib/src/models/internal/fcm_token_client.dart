import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

abstract class FcmTokenClient {
  /// Creates or updates an FCM token for the specified user
  ///
  /// [userId] - The ID of the user to associate the FCM token with
  Future<void> create(int userId);
  Future<String> getFcmTokenOfDevice();
}

class FcmTokenClientImpl implements FcmTokenClient {
  final ApiClient _apiClient;
  final String apiRoute = apiUrlFcmToken;
  // final String apiKey;

  FcmTokenClientImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<void> create(int userId) async {
    final String fcmToken = await getFcmTokenOfDevice();
    final osName = Platform.operatingSystem; // "android" or "ios"
    final osVersion = Platform.operatingSystemVersion;
    // http.Response resExistingFcmToken = await _apiClient.get(apiRoute, query: {
    //   'user': userId,
    //   'token': 'fcmToken',
    //   'osName': osName,
    //   'osVersion': osVersion,
    // });
    // Map<String, dynamic> body = jsonDecode(resExistingFcmToken.body);
    // inspect(body);
    // if (res.statusCode == 200) {
    //   // return res.body;
    // } else {
    //   throw Exception(res.body);
    http.Response resNewFcmToken = await _apiClient.post(apiRoute, body: {
      'user': userId,
      'token': fcmToken,
      'osName': osName,
      'osVersion': osVersion,
    });
    inspect(resNewFcmToken);
  }

  @override
  Future<String> getFcmTokenOfDevice() async {
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
    final String fcmTokenInDevice =
        await FirebaseMessaging.instance.getToken().catchError((e) {
              Logger.info(
                  '❌ Error getting FCM token. \nif this is not from a simulator, this is an error');
              return null;
            }) ??
            'error_getting_fcm_token';
    return fcmTokenInDevice;
    // context.showSnackbar(
    //     'got fcm token of the device: ${fcmTokenInDevice?.substring(0, 10)}');
    // final fcmTokenByUserIdResult = await gqlClient.query(QueryOptions(
    //   document: gql(fcmTokenQueryByUserIdAndToken),
    //   variables: {
    //     'userId': userId,
    //     'token': fcmTokenInDevice,
    //   },
    // ));
    // if (fcmTokenByUserIdResult.data?['FcmTokens']['totalDocs'] > 0) {
    //   // context.showErrorSnackbar('fcm token already saved for the user');
    //   Logger.info(
    //       '✅ same FCM Token already saved for the user. new token not needed');
    //   return;
    // }

    // final osName = Platform.operatingSystem; // "android" or "ios"
    // final osVersion = Platform
    //     .operatingSystemVersion; // e.g. "Android 14 (API 34)" or "Version 17.5 (Build 21F79)"

    // final result = await gqlClient.mutate(MutationOptions(
    //   document: gql(createFcmTokenMutation),
    //   variables: {
    //     'userId': userId,
    //     'token': fcmTokenInDevice,
    //     'osName': osName,
    //     'osVersion': osVersion,
    //   },
    // ));
    // if (result.hasException) {
    //   // context.showErrorSnackbar('GraphQL Error: ${result.exception}');
    //   Logger.error('❌ GraphQL Error: ${result.exception}');
    // } else {
    //   // context.showSnackbar(
    //   // 'FCM updated on server. \n token:${result.data!['createFcmToken']['token']} \n id:${result.data!['createFcmToken']['id']}');

    //   Logger.info('✅ FCM updated on server: '
    //       '${result.data!['createFcmToken']['token']}');
    // }
  }
}
