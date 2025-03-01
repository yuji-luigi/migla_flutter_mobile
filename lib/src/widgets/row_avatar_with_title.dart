import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class RowAvatarWithTitle extends StatelessWidget {
  final String title;
  final String image;
  final Color? color;
  const RowAvatarWithTitle({
    super.key,
    required this.title,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: CircleAvatar(),
        ),
        Text(
          title,
          style: textStyleCaptionSmall.copyWith(
            color: color ?? colorWhite,
          ),
        ),
      ],
    );
  }
}
