import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/graphql/users_query.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/user/graphql/students_query.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog.dart';

class DashboardHomeTopSection extends StatelessWidget {
  const DashboardHomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(getStudentsByParentId(
            16)), // this is the query string you just created

        pollInterval: const Duration(seconds: 10),
      ),
      builder: (result, {fetchMore, refetch}) {
        List<StudentModel> students = result.data?['Students']['docs']
            .map<StudentModel>((e) => StudentModel.fromJson(e))
            .toList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                context.t.dashboardHomeScreenHeader,
                textAlign: TextAlign.center,
                style: textStyleBodySmall,
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        StudentsSelectDialog(students: students),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 150,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ...(result.data?['Students']['docs'] as List)
                          .asMap()
                          .entries
                          .map((entry) => Positioned(
                                left: 30,
                                top: 0,
                                bottom: 0,
                                right: 30 * (entry.key).toDouble(),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    avatarPlaceholder,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                ),
              ),
            ),
            Text(
              context.t.dashboardHomeScreenHeader,
              textAlign: TextAlign.center,
              style: textStyleHeadingMedium.copyWith(color: textColorWhite),
            ),
          ],
        );
      },
    );
  }
}
