import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_detail_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/containers/image_bg_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_image_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_list_card.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportTopListView extends StatelessWidget {
  const TeacherReportTopListView({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        children: [
          16.height,
          GestureDetector(
            onTap: () {
              TeacherReportDetailScreen(id: 0).launch(context);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: paddingXDashboardMd),
              child: TeacherReportImageContainer(
                textColor: colorWhite,
                image: teacherReportList.first["coverImage"],
                title: teacherReportList.first["title"],
              ),
            ),
          ),
          ...teacherReportList.sublist(1).asMap().entries.map(
            (e) {
              return GestureDetector(
                onTap: () {
                  TeacherReportDetailScreen(id: e.key + 1).launch(context);
                },
                child: TeacherReportListCard(
                  image: e.value["coverImage"],
                  subtitle: e.value["subtitle"],
                  title: e.value["title"],
                ),
              );
            },
          ),
          TeacherReportListCard(
            image: placeholderImages[random.nextInt(placeholderImages.length)],
            subtitle: 'Teacher Report',
            title:
                'The teacher report is a report that is used to evaluate the teacher\'s performance.',
          ),
          TeacherReportListCard(
            image: placeholderImages[random.nextInt(placeholderImages.length)],
            subtitle: 'Teacher Report',
            title: 'The festival was on fire',
          ),
          16.height,
        ],
      ),
    );
  }
}
