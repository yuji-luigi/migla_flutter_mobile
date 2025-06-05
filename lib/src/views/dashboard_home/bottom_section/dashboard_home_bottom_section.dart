import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_list_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/photo_videos_screens/photo_videos_top_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_list_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/tile_like_button/tile_like_button_home.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardHomeBottomSection extends StatelessWidget {
  const DashboardHomeBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentsViewModel studentsVm = $studentsViewModel(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: AnimatedOpacity(
        opacity: studentsVm.selectedStudent != null ? 1 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: AbsorbPointer(
          absorbing: studentsVm.selectedStudent == null,
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
                  TeacherReportListScreen().launch(context);
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
                  NotificationListScreen().launch(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
