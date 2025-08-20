import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/firebase_options.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/providers/feature_providers.dart';
import 'package:migla_flutter/src/providers/my_graphql_provider.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

/// This must be a top-level function (not a class method).
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // If you're using other Firebase services in here, re-initialize:
  await Firebase.initializeApp();

  // You can access message.data, message.notification, etc.
  Logger.info(
      '🔔 [background] Handling a background message: ${message.messageId}');
  Logger.info('Data payload: ${message.data}');
  if (message.notification != null) {
    Logger.info('Notification title: ${message.notification!.title}');
    Logger.info('Notification body: ${message.notification!.body}');
  }

  // TODO: If you want to show a local notification, call your notification
  // plugin here. E.g.:
  // await LocalNotifications.show(
  //   id: message.hashCode,
  //   title: message.notification?.title,
  //   body: message.notification?.body,
  // );
}

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  WidgetsFlutterBinding.ensureInitialized();
  await settingsController.loadSettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // 1️⃣ Background handler:
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  // 2️⃣ (Optional) Request permissions on iOS:
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  Logger.info('host: $host');
  Logger.info('apiUrl: $apiUrl');
  Logger.info('apiGraphqlUrl: $apiGraphqlUrl');
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthTokenProvider()),
      ChangeNotifierProvider(create: (context) => settingsController)
    ],
    child: MyGraphqlProvider(
        child: FeatureProviders(
            child: MyApp(settingsController: settingsController))),
  ));
}
