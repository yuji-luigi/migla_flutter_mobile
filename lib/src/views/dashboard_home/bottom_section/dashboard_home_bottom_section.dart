import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_top.dart';
import 'package:migla_flutter/src/screens/dashboard/photo_videos_screens/photo_videos_top_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_top_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/tile_like_button/tile_like_button.dart';
import 'package:migla_flutter/src/widgets/buttons/tile_like_button/tile_like_button_home.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardHomeBottomSection extends StatelessWidget {
  const DashboardHomeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TileLikeButtonHome(
            text: context.t.photoAndVideoTextButton,
            endIconColor: colorSecondaryDark,
            icon: SvgPicture.asset(
              svgSmile,
            ),
            onTap: () {
              PhotoVideosTopScreen().launch(context);
            },
          ),
          TileLikeButtonHome(
            text: context.t.teacherReport,
            backgroundColor: colorPrimary,
            endIconColor: colorPrimaryDark,
            icon: SvgPicture.asset(
              svgBlog,
            ),
            onTap: () {
              TeacherReportTopScreen().launch(context);
            },
          ),
          TileLikeButtonHome(
            backgroundColor: colorTertiary,
            endIconColor: colorTertiaryDark,
            text: context.t.notificationTextButton,
            icon: SvgPicture.asset(
              svgMail,
            ),
            onTap: () {
              NotificationTopScreen().launch(context);
            },
          ),
        ],
      ),
    );
  }
}
