import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';

class StudentsSelectDialog extends StatelessWidget {
  final List<StudentModel> students;
  const StudentsSelectDialog({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    StudentsViewModel stVm = $studentsViewModel(context);
    return AlertDialog(
      title: Text(context.t.selectStudent),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...students.map((student) => ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: student.id == stVm.selectedStudent?.id
                    ? colorPrimary.withAlpha(120)
                    : null,
                onTap: () => {
                  stVm.setSelectedStudent(student),
                  Navigator.pop(context),
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(student.fullname[0]),
                ),
                title: Text(student.fullname),
                subtitle: Text(student.classroom.name),

                // subtitle: Text(student.classroom.name),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...(student.classroom.teachers ?? []).map((teacher) => Text(
                          teacher.name,
                          textAlign: TextAlign.left,
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
