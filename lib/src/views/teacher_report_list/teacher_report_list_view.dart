import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/models/api/report/report_model.dart';
import 'package:migla_flutter/src/models/api/report/report_query.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_detail_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_image_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_list_card.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportListView extends StatelessWidget {
  const TeacherReportListView({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentsViewModel studentsVm = $studentsViewModel(context);
    if (studentsVm.selectedStudent == null) {
      return Text('No student selected');
    }
    return Query(
      options: QueryOptions(
        document: gql(reportByStudentIdQuery(studentsVm.selectedStudent!.id)),
      ),
      builder: (result, {fetchMore, refetch}) {
        final List<ReportModel> reports = result.data?['Reports']['docs']
                .map<ReportModel>((e) => ReportModel.fromJson(e))
                .toList() ??
            [];
        if (result.hasException) {
          return Text(
              result.exception?.graphqlErrors.toString() ?? 'error occurred');
        }
        if (reports.isEmpty) {
          return Text('There is no report for this student');
        }
        return SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              16.height,
              ...reports.asMap().entries.map(
                (e) {
                  final ReportModel report = e.value;
                  if (e.key == 0) {
                    return GestureDetector(
                      onTap: () {
                        TeacherReportDetailScreen(id: report.id)
                            .launch(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: paddingXDashboardMd),
                        child: TeacherReportImageContainer(
                          textColor: colorWhite,
                          image: report.coverImage?.url,
                          title: report.title,
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      TeacherReportDetailScreen(id: report.id).launch(context);
                    },
                    child: TeacherReportListCard(
                      image: report.coverImage?.url ?? '',
                      subtitle: report.title,
                      title: report.title,
                    ),
                  );
                },
              ),
              16.height,
            ],
          ),
        );
      },
    );
  }
}
