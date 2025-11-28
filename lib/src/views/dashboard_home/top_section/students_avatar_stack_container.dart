import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog/students_select_dialog.dart';

class StudentsAvatarStackContainer extends StatelessWidget {
  const StudentsAvatarStackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    StudentsViewModel vm = $studentsViewModel(context);
    MeViewModel meVm = $meViewModel(context);
    print(vm.students.length);
    return GestureDetector(
      onTap: () {
        vm.getStudents(meVm);
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
            ...vm.students.asMap().entries.map((entry) => Positioned(
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
          ],
        ),
      ),
    );
  }
}
