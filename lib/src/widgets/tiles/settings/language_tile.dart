import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/suppported_language.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class LanguageTile extends StatefulWidget {
  const LanguageTile({super.key});

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  final String _selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = $settingsController(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(context.t.settingScreenLanguage,
          style: textStyleBodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          )),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(900),
        ),
        child: SizedBox(
          width: 150,
          child: DropdownButton(
            isExpanded: true,
            underline: Container(),
            items: supportedLanguages
                .map((e) => DropdownMenuItem(
                      value: e.code,
                      child: SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            Text(e.name),
                            SvgPicture.asset(e.iconPath, width: 24, height: 24),
                          ],
                        ),
                      ),
                    ))
                .toList(),
            value: settingsController.locale.languageCode,
            onChanged: (value) {
              if (value == null) return;
              settingsController.updateLocale(value);
            },
          ),
        ),
      ),
    );
  }
}
