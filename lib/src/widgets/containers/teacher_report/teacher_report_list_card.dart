import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportListCard extends StatelessWidget {
  final String image;
  final String title;
  final double? height;
  final Color? gradientBottom;
  final Color? textColor;
  const TeacherReportListCard({
    super.key,
    required this.image,
    required this.title,
    this.height,
    this.gradientBottom,
    this.textColor,
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
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowAvatarWithTitle(
                    title: title,
                    color: colorTextDisabled,
                    image: image,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
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
                  image: AssetImage(kyubiImg),
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
