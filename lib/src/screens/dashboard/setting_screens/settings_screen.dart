import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: context.t.settings,
      body: Column(
        children: [
          // locale
          ListTile(
            title: Text(context.t.settingScreenLanguage),
          ),
          ListTile(
            title: Text(context.t.logout),
          ),
        ],
      ),
    );
  }
}
