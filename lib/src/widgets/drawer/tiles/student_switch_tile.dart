import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/student/graphql/students_query.dart';
import 'package:migla_flutter/src/models/internal/objects/nav_item.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog.dart';
import 'package:migla_flutter/src/widgets/drawer/tiles/drawer_list_tile.dart';
import 'package:provider/provider.dart';

class StudentSwitchTile extends StatelessWidget {
  const StudentSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    final meVm = $meViewModel(context);
    final locale = $settingsController(context).locale;
    final gqlClient = GraphQLProvider.of(context).value;

    return AnimatedOpacity(
      opacity: meVm.hasMe ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: DrawerListTile(
          item: NavItem(
              icon: svgChangeBoyGirl,
              title: context.t.switchStudent,
              widget: SizedBox.shrink(),
              onTap: () async {
                if (meVm.hasMe) {
                  final result = await gqlClient.query(QueryOptions(
                    document: gql(getStudentsByParentId),
                    variables: {
                      'userId': meVm.me!.id,
                      'locale': locale.languageCode,
                    },
                  ));
                  List<StudentModel> students = result.data?['Students']['docs']
                      .map<StudentModel>((e) => StudentModel.fromJson(e))
                      .toList();
                  if (students.length > 1) {
                    GraphQLClient gqlClient = GraphQLProvider.of(context).value;
                    StudentsViewModel studentsViewModel =
                        $studentsViewModel(context, listen: false);
                    showDialog(
                        context: context,
                        builder: (context) =>
                            ChangeNotifierProvider<StudentsViewModel>.value(
                                value: studentsViewModel,
                                child: StudentsSelectDialog()));
                  }
                }
              })),
    );
  }
}
