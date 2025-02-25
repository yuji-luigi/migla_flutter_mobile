import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class DashboardHomeBottomSection extends StatelessWidget {
  const DashboardHomeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            context.t.dashboardHomeScreenHeader,
            textAlign: TextAlign.center,
            style: textStyleBodySmall,
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              avatarPlaceholder,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          context.t.dashboardHomeScreenHeader,
          textAlign: TextAlign.center,
          style: textStyleHeadingMedium.copyWith(),
        ),
        Text(
          context.t.dashboardHomeScreenHeader,
          textAlign: TextAlign.center,
          style: textStyleHeadingMedium.copyWith(),
        ),
        Text(
          context.t.dashboardHomeScreenHeader,
          textAlign: TextAlign.center,
          style: textStyleHeadingMedium.copyWith(),
        ),
        Text(
          context.t.dashboardHomeScreenHeader,
          textAlign: TextAlign.center,
          style: textStyleHeadingMedium.copyWith(),
        ),
        Text(
          context.t.dashboardHomeScreenHeader,
          textAlign: TextAlign.center,
          style: textStyleHeadingMedium.copyWith(),
        ),
      ],
    );
  }
}
