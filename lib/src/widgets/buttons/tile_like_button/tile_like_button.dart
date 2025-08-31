import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class TileLikeButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color textColor;
  final String text;
  final Widget? icon;
  final Widget? endIcon;
  final bool withShadow;
  final Function()? onTap;
  final bool disabled;
  const TileLikeButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.endIcon,
    this.disabled = false,
    this.withShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: disabled ? 0.5 : 1,
      duration: Duration(milliseconds: 200),
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorSecondary,
            borderRadius: BorderRadius.circular(radiusMedium),
            boxShadow: withShadow ? [buttonShadowDefault] : null,
          ),
          child: Row(
            spacing: 11,
            children: [
              if (icon != null) icon!,
              Text(text, style: textStyleHeadingSmall),
              if (endIcon != null) Spacer(),
              if (endIcon != null) endIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
