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
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:provider/provider.dart';

class StudentsViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  StudentModel? _selectedStudent;
  GraphQLClient _client;
  // bool _isLoading = false;
  List<StudentModel> _students = [];

  StudentsViewModel(this._client);

  // bool get isLoading => _isLoading;
  List<StudentModel> get students => _students;
  StudentModel? get selectedStudent => _selectedStudent;

  setSelectedStudentFromCache() async {
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

  void setSelectedStudent(StudentModel? student) {
    _selectedStudent = student;
    if (student != null) {
      Storage.saveSelectedStudentId(student.id);
    } else {
      Storage.removeSelectedStudentId();
    }
    notifyListeners();
  }

  Future<List<StudentModel>> getStudents(BuildContext context) async {
    try {
      MeViewModel meVm = $meViewModel(context, listen: false);
      if (meVm.me == null) {
        throw Exception('meVM is called in getStudents before me is loaded');
      }
      final localeCode = await Storage.getLocale();
      final options = QueryOptions(
        document: gql(getStudentsByParentId),
        variables: {
          'userId': meVm.me!.id,
          'locale': localeCode,
        },
      );
      final result = await _client.query(options);
      if (result.hasException && result.exception != null) {
        print('result.exception: ${result.exception}');
        throw result.exception!;
      }
      _students = result.data?['Students']['docs']
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
      notifyListeners();
      print('result.data: ${result.data}');
      return result.data?['Students']['docs']
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
    } catch (e, stackTrace) {
      print('error in getStudents: $e');
      Logger.error(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
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
