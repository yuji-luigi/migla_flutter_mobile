import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/services/native_notifier.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> _bootstrap;
  bool _asked = false;

  @override
  void initState() {
    super.initState();

    // Make all “first-run” UI changes AFTER the first frame
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Kick off once (safe to call here because we have a BuildContext)
    _bootstrap = _init();
  }

  Future<void> _init() async {
    await _initFirebase();
    // 1) Make sure the splash image is decoded & ready
    await precacheImage(const AssetImage(placeholderRainbow), context);

    // 2) Do your first-run logic
    final seen = await Storage.getSeenOnboarding();
    if (!seen) await Storage.setSeenOnboarding(true);

    // 3) Navigate
    if (!mounted) return;
    LoginScreen().launch(context, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    // Build the splash immediately; _bootstrap runs in the background
    return Scaffold(
      backgroundColor: bgColorSecondary,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 270,
          width: 270,
          decoration: BoxDecoration(
            color: bgPrimaryColor,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            placeholderRainbow,
            fit: BoxFit.cover,
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }

  _initFirebase() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _asked) return;
      _asked = true;

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Foreground → show a local (native) notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        await NativeNotifier.showFrom(message);
      });
    });
  }
}
