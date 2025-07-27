import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportListCard extends StatelessWidget {
  final String image;
  final String subtitle;
  final double? height;
  final Color? gradientBottom;
  final Color? textColor;
  final String title;
  final EdgeInsets? padding;
  const TeacherReportListCard({
    super.key,
    required this.image,
    required this.subtitle,
    this.height,
    this.gradientBottom,
    this.textColor,
    required this.title,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingXDashboardMd),
      child: Container(
        // alignment: Alignment.topLeft,
        height: height ?? 120,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(radiusMedium),
          boxShadow: [buttonShadowDefault],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 6,
                children: [
                  RowAvatarWithTitle(
                    text: subtitle,
                    color: colorTextDisabled,
                  ).buildColumns([]),
                  Text(
                    title,
                    style: textStyleCaptionMd.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2, // ✅ Restrict to 1 line
                    overflow: TextOverflow.ellipsis, // ✅ Truncate with "..."
                  )
                ],
              ),
            ),
            if (image.isNotEmpty)
              Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMedium),
                  color: colorPrimary,
                  image: DecorationImage(
                    image: Image.network(image).image,
                    fit: BoxFit
                        .cover, // 👈 Ensures the image covers the whole container
                  ),
                ),
                child: Column(
                  children: [],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
