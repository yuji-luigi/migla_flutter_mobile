import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class LanguageTile extends StatefulWidget {
  const LanguageTile({super.key});

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  String _selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
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
          width: 100,
          child: DropdownButton(
            isExpanded: true,
            underline: Container(),
            items: [
              DropdownMenuItem(
                value: "en",
                child: Text("EN"),
              ),
              DropdownMenuItem(
                value: "it",
                child: Text("IT"),
              ),
              DropdownMenuItem(
                value: "ja",
                child: Text("JA"),
              ),
            ],
            value: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedLanguage = value;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
