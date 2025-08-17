import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationSwitchTile extends StatefulWidget {
  const NotificationSwitchTile({super.key});

  @override
  State<NotificationSwitchTile> createState() => _NotificationSwitchTileState();
}

class _NotificationSwitchTileState extends State<NotificationSwitchTile> {
  bool _isNotificationEnabled = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(context.t.pushNotificationSetting,
          style: textStyleBodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          )),
      trailing: Switch(
        value: _isNotificationEnabled,
        activeColor: colorSecondary,
        trackColor: WidgetStateProperty.fromMap({
          WidgetState.selected: colorSecondary,
          WidgetState.any: colorTextDisabled,
        }),
        inactiveTrackColor: colorTextDisabled,
        inactiveThumbColor: colorWhite,
        thumbColor: WidgetStateProperty.all(colorWhite),
        onChanged: (value) {
          setState(() {
            _isNotificationEnabled = value;
          });
        },
      ),
    );
  }
}
