import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/student/graphql/students_query.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/students_avatar_stack_container.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardHomeTopSection extends StatelessWidget {
  const DashboardHomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    StudentsViewModel selectedStudentViewModel = $studentsViewModel(context);
    final meVm = $meViewModel(context);
    if (meVm.me == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Query(
      options: QueryOptions(
        document: gql(getStudentsByParentId),
        variables: {'userId': meVm.me!.id},
        // this is the query string you just created
      ),
      builder: (result, {fetchMore, refetch}) {
        List<StudentModel> students = result.data?['Students']['docs']
                .map<StudentModel>((e) => StudentModel.fromJson(e))
                .toList() ??
            [];
        if (result.hasException) {
          Logger.error(result.exception?.toString() ?? 'Unknown error');
          return Column(children: [
            Text(context.t.error_somethingWentWrong, style: textStyleBodyLarge),
            8.height,
            IconButton(
                onPressed: () {
                  if (refetch != null) {
                    refetch();
                  }
                },
                icon: const Icon(Icons.refresh)),
            Text(context.t.refreshPage)
          ]);
        }
        bool hasStudents = students.isNotEmpty;
        String title = hasStudents
            ? context.t.dashboardHomeScreenHeader
            : context.t.home_title_noStudent;

        return Stack(
          alignment: Alignment.center,
          children: [
            if (result.isLoading)
              const Center(child: CircularProgressIndicator()),
            AnimatedOpacity(
              opacity: result.isLoading ? 0.5 : 1.0,
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
                            child: StudentsAvatarStackContainer(
                                students: students),
                          ),
                        if (selectedStudentViewModel.selectedStudent != null)
                          Text(
                            selectedStudentViewModel
                                    .selectedStudent?.fullname ??
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
      },
    );
  }
}
