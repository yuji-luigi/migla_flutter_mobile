import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/tile_like_button/tile_like_button.dart';

class TileLikeButtonHome extends TileLikeButton {
  final Color? endIconColor;
  @override
  final bool disabled;
  TileLikeButtonHome({
    super.key,
    required super.text,
    required super.icon,
    required super.onTap,
    super.textColor = Colors.white,
    super.backgroundColor,
    super.withShadow = true,
    this.disabled = false,
    this.endIconColor,
    super.badgeText,
    Widget? endIcon, // 👈 Allow null initially
  }) : super(
          endIcon: endIcon ??
              SvgPicture.asset(svgArrowRightCircle,
                  colorFilter: ColorFilter.mode(
                    endIconColor ?? colorBlack,
                    BlendMode.srcIn,
                  )), // 👈 Initialize inside constructor
        );
}
