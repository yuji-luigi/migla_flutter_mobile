import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/containers/image_bg_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_image_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_list_card.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportTopListView extends StatelessWidget {
  const TeacherReportTopListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        children: [
          16.height,
          TeacherReportImageContainer(
            textColor: colorWhite,
            image:
                placeholderImages[Random().nextInt(placeholderImages.length)],
            title: 'Teacher Report',
          ),
          TeacherReportListCard(
            image:
                placeholderImages[Random().nextInt(placeholderImages.length)],
            title: 'Teacher Report',
          ),
          16.height,
        ],
      ),
    );
  }
}
