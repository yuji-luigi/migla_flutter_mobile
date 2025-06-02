import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/user/graphql/students_query.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/students_avatar_stack_container.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardHomeTopSection extends StatelessWidget {
  const DashboardHomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    StudentsViewModel selectedStudentViewModel =
        $selectedStudentViewModel(context);
    final meVm = $meViewModel(context);
    if (meVm.me == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Query(
      options: QueryOptions(
        document: gql(getStudentsByParentId(
            meVm.me!.id)), // this is the query string you just created
      ),
      builder: (result, {fetchMore, refetch}) {
        List<StudentModel> students = result.data?['Students']['docs']
            .map<StudentModel>((e) => StudentModel.fromJson(e))
            .toList();
        bool hasStudents = students.length > 0;
        String title = hasStudents
            ? context.t.dashboardHomeScreenHeader
            : context.t.home_title_noStudent;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                    child: StudentsAvatarStackContainer(students: students),
                  ),
                Text(
                  selectedStudentViewModel.selectedStudent?.fullName ?? '',
                  textAlign: TextAlign.center,
                  style: textStyleHeadingMedium.copyWith(color: textColorWhite),
                ),
                4.height,
                Text(
                  selectedStudentViewModel.selectedStudent?.classroom.name ??
                      '',
                  textAlign: TextAlign.center,
                  style: textStyleHeadingMedium.copyWith(color: textColorWhite),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
