import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/mutate_create_fcm_token.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/query_fcm_token.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/auth/auth_gate.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/views/dashboard_home/bottom_section/dashboard_home_bottom_section.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/dashboard_home_top_section.dart';
import 'package:migla_flutter/src/widgets/scaffold/dashboard_home_scaffold.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen>
    with RouteAware {
  late GraphQLClient _gqlClient;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gqlClient = GraphQLProvider.of(context).value;
      StudentsViewModel studentsViewModel =
          $studentsViewModel(context, listen: false);
      studentsViewModel.getStudents(context);
      _initMessagingForUser();
    });
  }

  @override
  void didUpdateWidget(DashboardHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gqlClient = GraphQLProvider.of(context).value;
      StudentsViewModel studentsViewModel =
          $studentsViewModel(context, listen: false);
      studentsViewModel.getStudents(context);
      _initMessagingForUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: DashboardHomeScaffold(
        topSection: DashboardHomeTopSection(),
        bottomSection: Column(
          children: [
            DashboardHomeBottomSection(),
          ],
        ),
      ),
    );
  }

  Future<void> _initMessagingForUser() async {
    final meViewModel = $meViewModel(context, listen: false);
    // final resultTest = await _gqlClient.mutate(MutationOptions(
    //   document: gql(createFcmTokenMutation),
    //   variables: {
    //     'userId': meViewModel.me?.id,
    //     'token': 'fcmTokenInDevice',
    //     'osName': 'osName',
    //     'osVersion': 'osVersion',
    //   },
    // ));
    // inspect(resultTest);
    // return;
    if (meViewModel.me == null) {
      context.showErrorSnackbar('meViewModel is null');
      Logger.error('MeViewModel is null');
      return;
    }
    context.showSnackbar('initializing messaging for user...');

    // (Re-)request permissions in case user denied earlier
    // sound on if the app is open
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
    final fcmTokenByUserIdResult = await _gqlClient.query(QueryOptions(
      document: gql(fcmTokenQueryByUserIdAndToken),
      variables: {
        'userId': meViewModel.me?.id,
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

    final result = await _gqlClient.mutate(MutationOptions(
      document: gql(createFcmTokenMutation),
      variables: {
        'userId': meViewModel.me?.id,
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
}
