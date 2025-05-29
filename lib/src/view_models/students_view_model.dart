// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql/src/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/user/graphql/students_query.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';
import 'package:provider/provider.dart';

class StudentsViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  StudentModel? _selectedStudent;
  GraphQLClient _client;
  List<StudentModel> _students = [];
  StudentsViewModel(this._client) {
    init();
  }

  init() async {
    // 1. get the saved student ID
    final studentId = await Storage.getSelectedStudentId();
    if (studentId == null) return;

    // 2. run a GQL query
    final options = QueryOptions(
      document: gql(getStudentByIdQuery(studentId)),
      variables: {'id': studentId},
      fetchPolicy: FetchPolicy.networkOnly,
    );
    final result = await _client.query(options);
    _selectedStudent = StudentModel.fromJson(result.data!['Student']);
    notifyListeners();
  }

  StudentModel? get selectedStudent => _selectedStudent;

  void setSelectedStudent(StudentModel student) {
    _selectedStudent = student;
    Storage.saveSelectedStudentId(student.id);
    notifyListeners();
  }
}

StudentsViewModel $selectedStudentViewModel(BuildContext context) {
  return Provider.of<StudentsViewModel>(context, listen: true);
}

StudentsViewModel getSelectedStudentViewModel(BuildContext context) {
  return Provider.of<StudentsViewModel>(context, listen: false);
}
