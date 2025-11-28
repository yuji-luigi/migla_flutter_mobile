import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportImageContainer extends StatelessWidget {
  final String? image;
  final String title;
  final String? subtitle;
  final double? height;
  final Color? gradientBottom;
  final Color? textColor;
  final bool isRead;
  const TeacherReportImageContainer({
    super.key,
    this.image,
    required this.title,
    this.subtitle,
    this.height,
    this.gradientBottom,
    this.textColor,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: height ?? 260,
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorPrimaryDark,
            borderRadius: BorderRadius.circular(radiusMedium),
            boxShadow: [buttonShadowDefault],
            image: DecorationImage(
              image: image != null
                  ? Image.network(image!).image
                  : AssetImage(placeholderRainbow),
              fit: BoxFit.cover,
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
                ).buildColumns([
                  Text(
                    subtitle ?? '',
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
        ),
        if (!isRead)
          Container(
            margin: EdgeInsets.only(top: 16, right: 16),
            child: Icon(
              Icons.fiber_new_rounded,
              color: colorWhite,
              size: 50,
            ),
          ),
      ],
    );
  }
}
