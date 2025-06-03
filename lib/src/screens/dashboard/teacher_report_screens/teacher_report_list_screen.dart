import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/teacher_report_top/teacher_report_top_list_view.dart';

class TeacherReportListScreen extends StatelessWidget {
  const TeacherReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      appBarBackgroundColor: Colors.transparent,
      backgroundColor: bgColorSecondary,
      bodyColor: Colors.transparent,
      title: context.t.teacherReport,
      padding: EdgeInsets.zero,
      body: TeacherReportTopListView(),
    );
  }
}
