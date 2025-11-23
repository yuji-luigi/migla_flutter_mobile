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
    String osName = Platform.operatingSystem; // "android" or "ios"
    String osVersion = Platform.operatingSystemVersion;

    _apiClient.post(apiRoute, body: {
      'user': userId,
      'token': fcmToken,
      'osName': osName,
      'osVersion': osVersion,
    });
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
              Logger.error(e.toString());
              return null;
            }) ??
            'error_getting_fcm_token';
    return fcmTokenInDevice;
  }
}
