import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/models/api/report/report_model.dart';
import 'package:migla_flutter/src/models/api/report/report_query.dart';
import 'package:migla_flutter/src/models/api/report/report_sum_model.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_detail_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/gql_result_has_403.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_image_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_list_card.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportListView extends StatefulWidget {
  const TeacherReportListView({super.key});

  @override
  State<TeacherReportListView> createState() => _TeacherReportListViewState();
}

class _TeacherReportListViewState extends State<TeacherReportListView>
    with RouteAwareRefetchMixin {
  @override
  Widget build(BuildContext context) {
    final StudentsViewModel studentsVm = $studentsViewModel(context);
    final locale = $settingsController(context).locale;
    if (studentsVm.selectedStudent == null) {
      return Text('No student selected');
    }
    return Query(
      options: QueryOptions(
        document: gql(reportByStudentIdQuery),
        variables: {
          'studentId': studentsVm.selectedStudent!.id,
          'locale': locale.languageCode,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        setRefetchFunction(refetch);

        final List<ReportSumModel> reports = result.data?['Reports']['docs']
                .map<ReportSumModel>((e) => ReportSumModel.fromJson(e))
                .toList() ??
            [];
        if (result.hasException) {
          if (gqlResultHas403(result)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // check still mounted before navigating:
              if (context.mounted) {
                LoginScreen().launch(context, isNewTask: true);
              }
            });
          }
          return Text(
              result.exception?.graphqlErrors.toString() ?? 'error occurred');
        }
        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (reports.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.t.noReportsFound,
                textAlign: TextAlign.center,
                style: textStyleHeadingSmall,
              ),
              IconButton(
                onPressed: () {
                  if (refetch != null) {
                    refetch();
                  }
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          );
        }
        return SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              16.height,
              ...reports.asMap().entries.map(
                (e) {
                  final ReportSumModel report = e.value;
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
                          isRead: report.isRead,
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
                      subtitle: formatDateTime(report.createdAt),
                      title: report.title,
                      isRead: report.isRead,
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
