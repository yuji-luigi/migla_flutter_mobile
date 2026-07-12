import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/screens/public/public_home_screen.dart';
import 'package:migla_flutter/src/services/native_notifier.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
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

    // 3) Route by auth state:
    //    - a valid session goes straight to the dashboard (the parent's real
    //      home); public content is reachable from the dashboard drawer.
    //    - otherwise land on the public home (visitor experience + login).
    //    getMe() returns null on an expired/unreachable session (never throws),
    //    which is our fallback to the public home. We do NOT clear the token on
    //    a null result so a transient offline start can recover next launch.
    final token = await Storage.getToken();
    if (token != null && token.isNotEmpty && mounted) {
      final me = await $meViewModel(context, listen: false).getMe();
      if (!mounted) return;
      if (me != null) {
        DashboardHomeScreen().launch(context, isNewTask: true);
        return;
      }
    }

    if (!mounted) return;
    PublicHomeScreen().launch(context, isNewTask: true);
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
