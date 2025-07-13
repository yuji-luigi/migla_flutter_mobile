import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/views/dashboard_home/bottom_section/dashboard_home_bottom_section.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/dashboard_home_top_section.dart';
import 'package:migla_flutter/src/widgets/scaffold/dashboard_home_scaffold.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  @override
  void initState() {
    super.initState();
    // initFirebaseMessaging();
  }

  Future<void> initFirebaseMessaging() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmToken: $fcmToken');
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
}
