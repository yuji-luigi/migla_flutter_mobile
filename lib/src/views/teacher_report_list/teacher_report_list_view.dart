import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/models/api/report/report_query.dart';
import 'package:migla_flutter/src/models/api/report/report_sum_model.dart';
import 'package:migla_flutter/src/screens/dashboard/teacher_report_screens/teacher_report_detail_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_image_container.dart';
import 'package:migla_flutter/src/widgets/containers/teacher_report/teacher_report_list_card.dart';
import 'package:migla_flutter/src/widgets/list/info_empty_list.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/graphql/graphql_error_view.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/graphql/graphql_list_view_general.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/list_view_general.dart';
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
    return GraphqlListViewGeneral<ReportSumModel>(
      fromJson: ReportSumModel.fromJson,
      options: QueryOptions(
        document: gql(reportByStudentIdQuery),
        variables: {
          'studentId': studentsVm.selectedStudent!.id,
          'locale': locale.languageCode,
        },
      ),
      dataKey: 'Reports',
      separatorBuilder: (context, index) {
        return 8.height;
      },
      itemBuilder: (context, index, reports) {
        if (index == reports.length) {
          return 16.height;
        }
        final ReportSumModel report = reports[index];
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.only(
                top: paddingXDashboardMd, right: paddingXDashboardMd),
            child: GestureDetector(
              onTap: () {
                TeacherReportDetailScreen(id: report.id).launch(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: paddingXDashboardMd),
                child: TeacherReportImageContainer(
                  textColor: colorWhite,
                  image: report.coverImage?.url,
                  title: report.title,
                  isRead: report.isRead,
                ),
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
    );
    return Column(
      children: [
        Expanded(
          child: Query(
            options: QueryOptions(
              document: gql(reportByStudentIdQuery),
              variables: {
                'studentId': studentsVm.selectedStudent!.id,
                'locale': locale.languageCode,
              },
            ),
            builder: (result, {fetchMore, refetch}) {
              setRefetchFunction(refetch);

              final List<ReportSumModel> reports = result.data?['Reports']
                          ['docs']
                      .map<ReportSumModel>((e) => ReportSumModel.fromJson(e))
                      .toList() ??
                  [];
              if (result.hasException) {
                return GraphqlErrorView(result: result, refetch: refetch);
              }
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (reports.isEmpty) {
                return InfoEmptyList(
                  title: context.t.noReportsFound,
                  onRefresh: refetch,
                );
              }
              return ListViewGeneral(
                items: reports,
                itemCount: reports.length,
                refetch: refetch,
                itemBuilder: (context, index) {
                  if (index == reports.length) {
                    return 16.height;
                  }
                  final ReportSumModel report = reports[index];
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.only(
                          top: paddingXDashboardMd, right: paddingXDashboardMd),
                      child: GestureDetector(
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
                      ),
                    );
                  }
                  return GestureDetector(
                      onTap: () {
                        TeacherReportDetailScreen(id: report.id)
                            .launch(context);
                      },
                      child: TeacherReportListCard(
                        image: report.coverImage?.url ?? '',
                        subtitle: formatDateTime(report.createdAt),
                        title: report.title,
                        isRead: report.isRead,
                      ));
                },
              );
              return RefreshIndicator(
                  onRefresh: () async {
                    if (refetch != null) {
                      refetch();
                    }
                  },
                  child: ListView.separated(
                    itemCount: reports.length + 1,
                    shrinkWrap: false,
                    padding: EdgeInsets.all(0),
                    separatorBuilder: (context, index) {
                      return 8.height;
                    },
                    itemBuilder: (context, index) {
                      if (index == reports.length) {
                        return 16.height;
                      }
                      final ReportSumModel report = reports[index];
                      if (index == 0) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: paddingXDashboardMd,
                              right: paddingXDashboardMd),
                          child: GestureDetector(
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
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          TeacherReportDetailScreen(id: report.id)
                              .launch(context);
                        },
                        child: TeacherReportListCard(
                          image: report.coverImage?.url ?? '',
                          subtitle: formatDateTime(report.createdAt),
                          title: report.title,
                          isRead: report.isRead,
                        ),
                      );
                    },
                  )

                  // child: Column(
                  //   spacing: 8,
                  //   children: [
                  //     16.height,
                  //     ...reports.asMap().entries.map(
                  //       (e) {
                  //         final ReportSumModel report = e.value;
                  //         if (e.key == 0) {
                  //           return GestureDetector(
                  //             onTap: () {
                  //               TeacherReportDetailScreen(id: report.id)
                  //                   .launch(context);
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: paddingXDashboardMd),
                  //               child: TeacherReportImageContainer(
                  //                 textColor: colorWhite,
                  //                 image: report.coverImage?.url,
                  //                 title: report.title,
                  //                 isRead: report.isRead,
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //         return GestureDetector(
                  //           onTap: () {
                  //             TeacherReportDetailScreen(id: report.id)
                  //                 .launch(context);
                  //           },
                  //           child: TeacherReportListCard(
                  //             image: report.coverImage?.url ?? '',
                  //             subtitle: formatDateTime(report.createdAt),
                  //             title: report.title,
                  //             isRead: report.isRead,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //     16.height,
                  //   ],
                  // ),
                  );
            },
          ),
        ),
      ],
    );
  }
}
