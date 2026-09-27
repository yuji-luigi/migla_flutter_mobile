import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/dashboard/inquiry_screens/inquiry_thread_screen.dart';

/// Routes notification taps to the right screen and re-broadcasts foreground
/// messages so open screens (e.g. an inquiry thread) can refresh themselves.
///
/// FCM data contract (backend): `{type, collection, collectionRecordId}`.
class PushNavigationService {
  PushNavigationService._();

  /// Attached to the MaterialApp so we can navigate without a BuildContext.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final StreamController<RemoteMessage> _foregroundController =
      StreamController<RemoteMessage>.broadcast();

  /// Messages received while the app is in the foreground.
  static Stream<RemoteMessage> get foregroundMessages =>
      _foregroundController.stream;

  static bool _initialized = false;
  static RemoteMessage? _pending;

  /// Idempotent; call once Firebase is initialized.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    FirebaseMessaging.onMessage.listen(_foregroundController.add);
    FirebaseMessaging.onMessageOpenedApp.listen(handleOpened);
    try {
      // Can hang without APNs (e.g. simulator); never block the splash on it.
      final initial = await FirebaseMessaging.instance
          .getInitialMessage()
          .timeout(const Duration(seconds: 3), onTimeout: () => null);
      if (initial != null) _pending = initial;
    } catch (error) {
      Logger.error('getInitialMessage failed: $error');
    }
  }

  /// A notification was tapped while the app was in the background.
  static Future<void> handleOpened(RemoteMessage message) async {
    final token = await Storage.getToken();
    if (token == null || token.isEmpty) {
      _pending = message;
      return;
    }
    routeData(message.data);
  }

  /// Opens the screen for a notification that launched the app from a
  /// terminated state. Call after the post-login home screen was pushed.
  static void flushPending() {
    final message = _pending;
    _pending = null;
    if (message == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeData(message.data);
    });
  }

  /// Drops a pending tap (e.g. the user is not logged in).
  static void discardPending() => _pending = null;

  /// Returns true when the payload was routed.
  static bool routeData(Map<String, dynamic> data) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) return false;
    final String? inquiryId = inquiryIdFrom(data);
    if (inquiryId != null) {
      navigator.push(MaterialPageRoute(
        builder: (_) => InquiryThreadScreen(inquiryId: inquiryId),
      ));
      return true;
    }
    return false;
  }

  /// The inquiry id when [data] is an inquiry notification, else null.
  static String? inquiryIdFrom(Map<String, dynamic> data) {
    final bool isInquiry =
        data['type'] == 'inquiry' || data['collection'] == 'inquiries';
    final id = data['collectionRecordId']?.toString();
    if (!isInquiry || id == null || id.isEmpty) return null;
    return id;
  }
}
