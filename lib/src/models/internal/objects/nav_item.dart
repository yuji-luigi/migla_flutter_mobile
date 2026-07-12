import 'package:flutter/material.dart';

class NavItem {
  /// SVG asset path for the leading icon. Optional when [materialIcon] is set.
  final String? icon;

  /// Material icon used instead of [icon] when provided (no SVG asset needed).
  final IconData? materialIcon;
  final String title;
  final Widget widget;
  final void Function()? onTap;

  NavItem({
    this.icon,
    this.materialIcon,
    required this.title,
    required this.widget,
    this.onTap,
  }) : assert(icon != null || materialIcon != null,
            'NavItem needs either an svg icon path or a materialIcon');
}
