import 'package:flutter/material.dart';
import 'package:migla_flutter/src/widgets/dialog/students_select_dialog/students_select_dialog.dart';

void openStudentsSelectDialog(BuildContext rootContext) {
  showDialog(
    context: rootContext,
    builder: (context) => StudentsSelectDialog(),
  );
}
