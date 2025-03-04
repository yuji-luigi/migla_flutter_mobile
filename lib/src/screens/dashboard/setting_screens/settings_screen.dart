import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/tiles/settings/language_tile.dart';
import 'package:migla_flutter/src/widgets/tiles/settings/logout_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: context.t.settings,
      bodyColor: colorTertiary,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: paddingYDashboardMd,
        ),
        child: Column(
          children: [
            // locale
            const LanguageTile(),
            const LogoutTile(),
          ],
        ),
      ),
    );
  }
}
