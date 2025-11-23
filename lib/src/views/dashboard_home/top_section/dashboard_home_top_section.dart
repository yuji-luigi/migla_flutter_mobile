import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/students_avatar_stack_container.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardHomeTopSection extends StatefulWidget {
  const DashboardHomeTopSection({super.key});

  @override
  State<DashboardHomeTopSection> createState() =>
      _DashboardHomeTopSectionState();
}

class _DashboardHomeTopSectionState extends State<DashboardHomeTopSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MeViewModel meVm = $meViewModel(context, listen: false);
      StudentsViewModel studentsViewModel =
          $studentsViewModel(context, listen: false);
      studentsViewModel.getStudents(meVm);
    });
  }

  @override
  Widget build(BuildContext context) {
    StudentsViewModel selectedStudentViewModel = $studentsViewModel(context);
    final meVm = $meViewModel(context);
    final studentsVM = $studentsViewModel(context);
    if (meVm.me == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (studentsVM.errorMessage != null) {
      return Column(children: [
        Text(context.t.error_somethingWentWrong, style: textStyleBodyLarge),
        8.height,
        IconButton(
            onPressed: () {
              studentsVM.getStudents(meVm);
            },
            icon: const Icon(Icons.refresh)),
        Text(context.t.refreshPage)
      ]);
    }

    bool hasStudents = studentsVM.students.isNotEmpty;
    String title = hasStudents
        ? context.t.dashboardHomeScreenHeader
        : context.t.home_title_noStudent;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (studentsVM.isLoading)
          const Center(child: CircularProgressIndicator()),
        AnimatedOpacity(
          opacity: studentsVM.isLoading ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: hasStudents
                            ? textStyleBodySmall
                            : textStyleBodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ),
                    if (hasStudents)
                      Center(
                        child: StudentsAvatarStackContainer(),
                      ),
                    if (selectedStudentViewModel.selectedStudent != null)
                      Text(
                        selectedStudentViewModel.selectedStudent?.fullname ??
                            '',
                        textAlign: TextAlign.center,
                        style: textStyleHeadingMedium.copyWith(
                            color: textColorWhite),
                      ),
                    4.height,
                    if (hasStudents)
                      Text(
                        selectedStudentViewModel
                                .selectedStudent?.classroom.name ??
                            context.t.home_pleaseSelectStudent,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: textStyleHeadingMedium.copyWith(
                          color: textColorWhite,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // return Query(
    //   options: QueryOptions(
    //     pollInterval: const Duration(seconds: 1),
    //     fetchPolicy: FetchPolicy.cacheAndNetwork,
    //     document: gql(getStudentsByParentId),
    //     variables: {
    //       'userId': meVm.me!.id,
    //       'locale': locale.languageCode,
    //     },

    //     errorPolicy: ErrorPolicy.all,

    //     // this is the query string you just created
    //   ),
    //   builder: (result, {fetchMore, refetch}) {
    //     List<StudentModel> students = result.data?['Students']['docs']
    //             .map<StudentModel>((e) => StudentModel.fromJson(e))
    //             .toList() ??
    //         [];
    //     if (result.hasException) {
    //       if (result.hasException) {
    //         for (final e in result.exception!.graphqlErrors) {
    //           print(
    //               'GraphQL error: ${e.message} | path: ${e.path} | extensions: ${e.extensions}');
    //         }
    //       }
    //       Logger.error(result.exception?.toString() ?? 'Unknown error');
    //       if (gqlResultHas403(result)) {
    //         WidgetsBinding.instance.addPostFrameCallback((_) {
    //           // check still mounted before navigating:
    //           if (context.mounted) {
    //             LoginScreen().launch(context, isNewTask: true);
    //           }
    //         });
    //       }
    //       return Column(children: [
    //         Text(context.t.error_somethingWentWrong, style: textStyleBodyLarge),
    //         8.height,
    //         IconButton(
    //             onPressed: () {
    //               if (refetch != null) {
    //                 refetch();
    //               }
    //             },
    //             icon: const Icon(Icons.refresh)),
    //         Text(context.t.refreshPage)
    //       ]);
    //     }
    //     bool hasStudents = students.isNotEmpty;
    //     String title = hasStudents
    //         ? context.t.dashboardHomeScreenHeader
    //         : context.t.home_title_noStudent;

    //     return Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         if (result.isLoading)
    //           const Center(child: CircularProgressIndicator()),
    //         AnimatedOpacity(
    //           opacity: result.isLoading ? 0.5 : 1.0,
    //           duration: const Duration(milliseconds: 300),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Column(
    //                   children: [
    //                     SizedBox(
    //                       width: 200,
    //                       child: Text(
    //                         title,
    //                         textAlign: TextAlign.center,
    //                         style: hasStudents
    //                             ? textStyleBodySmall
    //                             : textStyleBodyLarge.copyWith(
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                       ),
    //                     ),
    //                     if (hasStudents)
    //                       Center(
    //                         child: StudentsAvatarStackContainer(),
    //                       ),
    //                     if (selectedStudentViewModel.selectedStudent != null)
    //                       Text(
    //                         selectedStudentViewModel
    //                                 .selectedStudent?.fullname ??
    //                             '',
    //                         textAlign: TextAlign.center,
    //                         style: textStyleHeadingMedium.copyWith(
    //                             color: textColorWhite),
    //                       ),
    //                     4.height,
    //                     if (hasStudents)
    //                       Text(
    //                         selectedStudentViewModel
    //                                 .selectedStudent?.classroom.name ??
    //                             context.t.home_pleaseSelectStudent,
    //                         textAlign: TextAlign.center,
    //                         maxLines: 3,
    //                         style: textStyleHeadingMedium.copyWith(
    //                           color: textColorWhite,
    //                         ),
    //                       ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
