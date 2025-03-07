import 'package:flutter/material.dart';
import 'package:migla_flutter/src/views/dashboard_home/bottom_section/dashboard_home_bottom_section.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/dashboard_home_top_section.dart';
import 'package:migla_flutter/src/widgets/scaffold/dashboard_home_scaffold.dart';

class DashboardHomeScreen extends StatelessWidget {
  const DashboardHomeScreen({super.key});

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
