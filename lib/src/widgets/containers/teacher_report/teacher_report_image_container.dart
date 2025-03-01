import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportImageContainer extends StatelessWidget {
  final String image;
  final String title;
  final double? height;
  final Color? gradientBottom;
  final Color? textColor;
  const TeacherReportImageContainer({
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
      height: height ?? 260,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(0),
              colorBlack.withAlpha(200),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 16,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircleAvatar(),
                ),
                Text(
                  '4th grade',
                  style: textStyleCaptionSmall.copyWith(
                    color: colorWhite,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                24.width,
                Text(
                  title,
                  style: textStyleCaptionSmall.copyWith(
                    color: colorWhite,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                24.width,
                Text(
                  title,
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor ?? colorWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
