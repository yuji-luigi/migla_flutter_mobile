// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql/src/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';
import 'package:migla_flutter/src/models/api/student/graphql/students_query.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:provider/provider.dart';

class StudentsViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  StudentModel? _selectedStudent;
  GraphQLClient _client;
  // bool _isLoading = false;
  List<StudentModel> _students = [];
  StudentsViewModel(this._client) {
    init();
  }

  // bool get isLoading => _isLoading;

  init() async {
    // 1. get the saved student ID
    final int? studentId = await Storage.getSelectedStudentId();
    if (studentId == null) return;
    String localeCode = await Storage.getLocale();
    // 2. run a GQL query
    final options = QueryOptions(
      document: gql(getStudentByIdQuery),
      variables: {
        'studentId': (studentId),
        'locale': localeCode,
      },
    );
    try {
      notifyListeners();
      final result = await _client.query(options);
      if (result.hasException && result.exception != null) {
        throw result.exception!;
      }
      _selectedStudent = result.data != null
          ? StudentModel.fromJson(result.data!['Student'])
          : null;
      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  StudentModel? get selectedStudent => _selectedStudent;

  void setSelectedStudent(StudentModel? student) {
    _selectedStudent = student;
    if (student != null) {
      Storage.saveSelectedStudentId(student.id);
    } else {
      Storage.removeSelectedStudentId();
    }
    notifyListeners();
  }

  clear() {
    _selectedStudent = null;
    _students = [];
    notifyListeners();
  }
}

StudentsViewModel $studentsViewModel(BuildContext context,
    {bool listen = true}) {
  return Provider.of<StudentsViewModel>(context, listen: listen);
}
