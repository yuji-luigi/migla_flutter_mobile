import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class InfoEmptyList extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? icon;
  final VoidCallback? onRefresh;
  const InfoEmptyList(
      {super.key,
      required this.title,
      this.description,
      this.icon,
      this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: textStyleHeadingSmall,
        ),
        if (onRefresh != null)
          IconButton(
            onPressed: () {
              if (onRefresh != null) {
                onRefresh!();
              }
            },
            icon: icon ?? const Icon(Icons.refresh),
          )
      ],
    );
    ;
  }
}
