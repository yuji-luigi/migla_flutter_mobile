import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/tiles/settings/language_tile.dart';
import 'package:migla_flutter/src/widgets/tiles/settings/logout_tile.dart';
import 'package:migla_flutter/src/widgets/tiles/settings/notification_switch_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      title: context.t.settings,
      bodyColor: colorTertiary,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: paddingYDashboardMd,
          horizontal: paddingXDashboardMd,
        ),
        child: Column(
          children: [
            // locale
            const LanguageTile(),
            const NotificationSwitchTile(),
            const LogoutTile(),
          ],
        ),
      ),
    );
  }
}
