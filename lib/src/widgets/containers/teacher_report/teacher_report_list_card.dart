import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
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
  const TeacherReportListCard({
    super.key,
    required this.image,
    required this.subtitle,
    this.height,
    this.gradientBottom,
    this.textColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMedium),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover, // 👈 Ensures the image covers the whole container
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        color: colorWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  RowAvatarWithTitle(
                    text: subtitle,
                    color: colorTextDisabled,
                    image: image,
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
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMedium),
                color: colorPrimary,
                image: DecorationImage(
                  image: AssetImage(image),
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
