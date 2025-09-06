import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/services/native_notifier.dart';

class StartupGate extends StatefulWidget {
  const StartupGate({super.key});
  @override
  State<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<StartupGate> {
  bool _asked = false;

  @override
  void initState() {
    super.initState();

    // Make all “first-run” UI changes AFTER the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _asked) return;
      _asked = true;

      // 1) Request notifications permission ONCE
      if (Platform.isAndroid) {
        // Ask Android 13+ only (your helper should internally no-op on <33)
        await NativeNotifier.requestAndroidPermission();
      } else if (Platform.isIOS || Platform.isMacOS) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // 2) Foreground presentation (iOS/macOS only)
      if (!Platform.isAndroid) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      // 3) Set up foreground listener (safe to do here too)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await NativeNotifier.showFrom(message);
      });

      // 4) Continue navigation to your real home
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox()); // lightweight placeholder
  }
}
