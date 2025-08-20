import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog/students_select_dialog.dart';
import 'package:provider/provider.dart';

class StudentSwitchAppbarActionButton extends StatelessWidget {
  const StudentSwitchAppbarActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          StudentsViewModel studentsViewModel =
              $studentsViewModel(context, listen: false);
          showDialog(
            context: context,
            builder: (context) =>
                ChangeNotifierProvider<StudentsViewModel>.value(
              value: studentsViewModel,
              child: const StudentsSelectDialog(),
            ),
          );
        },
        icon: SvgPicture.asset(
          svgChangeBoyGirl,
          width: 35,
          height: 35,
        ));
  }
}
