import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog.dart';

class StudentsAvatarStackContainer extends StatelessWidget {
  final List<StudentModel> students;
  const StudentsAvatarStackContainer({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => StudentsSelectDialog(),
        );
      },
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: 300,
          maxHeight: 100,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...students
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
    );
  }
}
