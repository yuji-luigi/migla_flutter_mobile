import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/views/teacher_report_top/teacher_report_top_list_view.dart';

class TeacherReportTopScreen extends StatelessWidget {
  const TeacherReportTopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: context.t.teacherReport,
      body: TeacherReportTopListView(),
    );
  }
}
