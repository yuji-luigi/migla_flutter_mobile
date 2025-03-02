import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class DateMarkAsReadTile extends StatelessWidget {
  final double padding;
  const DateMarkAsReadTile({super.key, this.padding = paddingXDashboardMd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      color: colorWhite,
      child: Row(
        children: [
          Text('date',
              style: textStyleBodyLarge.copyWith(fontWeight: FontWeight.bold)),
          Spacer(),
          Text(context.t.markAsRead,
              style: textStyleBodyMedium.copyWith(
                  fontWeight: FontWeight.bold, color: colorSecondary)),
        ],
      ),
    );
  }
}
