import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class RowAvatarWithTitle extends StatelessWidget {
  final String text;
  final Color? color;
  final double avatarSize;
  const RowAvatarWithTitle({
    super.key,
    required this.text,
    this.color,
    this.avatarSize = 24,
  });
  _avatarRow() {
    return Row(
      spacing: 8,
      children: [
        SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: CircleAvatar(),
        ),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyleCaptionSmall.copyWith(
              color: color ?? colorWhite,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _avatarRow();
  }

  Widget buildColumns(List<Widget> children) {
    return Column(
      children: [
        _avatarRow(),
        ...children.map((widget) => Row(
              spacing: 8,
              children: [
                avatarSize.toInt().width,
                Flexible(child: widget),
              ],
            )),
      ],
    );
  }
}
