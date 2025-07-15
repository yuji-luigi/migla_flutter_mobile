import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class SwitchBase extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Color? activeColor;
  final Color? inactiveTrackColor;
  final Color? inactiveThumbColor;
  final Color? thumbColor;
  const SwitchBase(
      {super.key,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.inactiveTrackColor,
      this.inactiveThumbColor,
      this.thumbColor});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: activeColor ?? colorSecondary,
      trackColor: WidgetStateProperty.fromMap({
        WidgetState.selected: activeColor ?? colorSecondary,
        WidgetState.any: colorTextDisabled,
      }),
      inactiveTrackColor: inactiveTrackColor ?? colorTextDisabled,
      inactiveThumbColor: inactiveThumbColor ?? colorWhite,
      thumbColor: WidgetStateProperty.all(thumbColor ?? colorWhite),
      onChanged: onChanged,
    );
  }
}
