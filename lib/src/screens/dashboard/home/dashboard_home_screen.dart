import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/mutate_create_fcm_token.dart';
import 'package:migla_flutter/src/models/api/fcm_token/graphql/query_fcm_token.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
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
      _initMessagingForUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardHomeScaffold(
      topSection: DashboardHomeTopSection(),
      bottomSection: Column(
        children: [
          DashboardHomeBottomSection(),
        ],
      ),
    );
  }

  Future<void> _initMessagingForUser() async {
    final savedFcmToken = await Storage.getFcmToken();

    final meViewModel = $meViewModel(context, listen: false);
    if (meViewModel.me == null) {
      Logger.error('MeViewModel is null');
      return;
    }
    // (Re-)request permissions in case user denied earlier
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final String? token =
        await FirebaseMessaging.instance.getToken().catchError((e) {
      Logger.error('❌ Error getting FCM token: $e');
      return null;
    });

    if (token == null || token.isEmpty) return;
    if (savedFcmToken == token) {
      final result = await _gqlClient.query(QueryOptions(
        document: gql(fcmTokenQuery),
        variables: {
          'token': token,
          'userId': meViewModel.me?.id,
        },
      ));
      if (result.hasException) {
        Logger.error('❌ GraphQL Error: ${result.exception}');
      }
      if (result.data!['FcmTokens']['totalDocs'] > 0) {
        Logger.info('✅ FCM Token already saved: $token');
        return;
      }
    }
    await Storage.saveFcmToken(token);
    // Send this token to your server, tied to the logged-in user
    // get user agent and device info
    final osName = Platform.operatingSystem; // "android" or "ios"
    final osVersion = Platform
        .operatingSystemVersion; // e.g. "Android 14 (API 34)" or "Version 17.5 (Build 21F79)"

    final result = await _gqlClient.mutate(MutationOptions(
      document: gql(createFcmTokenMutation),
      variables: {
        'userId': meViewModel.me?.id,
        'token': token,
        'osName': osName,
        'osVersion': osVersion,
      },
    ));
    if (result.hasException) {
      // handle errors
      Logger.error('❌ GraphQL Error: ${result.exception}');
    } else {
      Logger.info('✅ FCM updated on server: '
          '${result.data!['createdFcmToken']}');
    }
  }
}
