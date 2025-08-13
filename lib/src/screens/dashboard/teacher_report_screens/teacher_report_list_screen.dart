import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/teacher_report_list/teacher_report_list_view.dart';
import 'package:migla_flutter/src/widgets/buttons/notification_appbar_action_button.dart';
import 'package:migla_flutter/src/widgets/buttons/student_switch_appbar_action_button.dart';

class TeacherReportListScreen extends StatelessWidget {
  const TeacherReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      appBarBackgroundColor: Colors.transparent,
      appBarActions: [
        const StudentSwitchAppbarActionButton(),
        const NotificationAppbarActionButton()
      ],
      backgroundColor: bgColorSecondary,
      bodyColor: Colors.transparent,
      title: context.t.teacherReport,
      padding: EdgeInsets.zero,
      body: TeacherReportListView(),
    );
  }
}
