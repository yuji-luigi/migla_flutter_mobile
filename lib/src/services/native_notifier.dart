// lib/src/services/native_notifier.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NativeNotifier {
  static const _ch = MethodChannel('app.native/notifier');

  static Future<void> requestAndroidPermission() async {
    try {
      await _ch.invokeMethod('requestPermission');
    } catch (_) {}
  }

  static Future<void> showFrom(RemoteMessage m) async {
    final title = m.notification?.title ?? m.data['title'] ?? '';
    final body = m.notification?.body ?? m.data['body'] ?? '';
    await _ch.invokeMethod('showNotification', {
      'title': title,
      'body': body,
      'payload': jsonEncode(m.data),
    });
  }
}
