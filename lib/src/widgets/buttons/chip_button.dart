import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class ChipButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final void Function() onTap;
  final bool withShadow;
  final bool withOpacity;
  final bool disabled;
  const ChipButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.withShadow = false,
    this.withOpacity = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: AnimatedOpacity(
        opacity: withOpacity ? 0.6 : 1,
        duration: Duration(milliseconds: 200),
        child: Container(
          alignment: Alignment.center,
          height: 54,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorTertiary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: withShadow ? [buttonShadowDefault] : null,
          ),
          child: Text(text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }
}
