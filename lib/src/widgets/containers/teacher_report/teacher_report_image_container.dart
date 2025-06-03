import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
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
        boxShadow: [buttonShadowDefault],
        image: DecorationImage(
          image: Image.network(host + image).image,
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
            RowAvatarWithTitle(
              text: title,
              color: colorTextDisabled,
              image: image,
            ).buildColumns([
              Text(
                'Cerimonia del té',
                style: textStyleCaptionSmall.copyWith(
                  color: colorWhite,
                ),
              ),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor ?? colorWhite,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
