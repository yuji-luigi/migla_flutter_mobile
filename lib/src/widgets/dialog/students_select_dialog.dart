import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';

class StudentsSelectDialog extends StatelessWidget {
  final List<StudentModel> students;
  const StudentsSelectDialog({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.selectStudent),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...students.map((student) => ListTile(
                onTap: () => print(student.fullName),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(student.fullName[0]),
                ),
                title: Text(student.fullName),
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
