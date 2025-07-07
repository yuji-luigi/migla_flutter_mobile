import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/models/internal/suppported_language.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class SwitchLanguageFlagButton extends StatefulWidget {
  const SwitchLanguageFlagButton({super.key});

  @override
  State<SwitchLanguageFlagButton> createState() =>
      _SwitchLanguageFlagButtonState();
}

class _SwitchLanguageFlagButtonState extends State<SwitchLanguageFlagButton> {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = $settingsController(context);
    return DropdownButton(
      value: settingsController.locale.languageCode,
      dropdownColor: colorWhite,
      items: supportedLanguages
          .map((e) => DropdownMenuItem(
                value: e.code,
                child: SvgPicture.asset(e.iconPath, width: 24, height: 24),
              ))
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        settingsController.updateLocale(value);
      },
    );
  }
}
