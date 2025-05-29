import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/firebase_options.dart';
import 'package:migla_flutter/src/providers/feature_providers.dart';
import 'package:migla_flutter/src/providers/my_graphql_provider.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MeViewModel()),
      // ChangeNotifierProvider(create: (context) => StudentsViewModel()),
    ],
    child: MyGraphqlProvider(
        child: FeatureProviders(
            child: MyApp(settingsController: settingsController))),
  ));
}
