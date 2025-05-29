import 'package:flutter/material.dart';

class NavItem {
  final String icon;
  final String title;
  final Widget widget;
  final void Function()? onTap;

  NavItem({
    required this.icon,
    required this.title,
    required this.widget,
    this.onTap,
  });
}
