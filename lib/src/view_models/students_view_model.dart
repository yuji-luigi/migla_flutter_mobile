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
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:provider/provider.dart';

class StudentsViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  StudentModel? _selectedStudent;
  GraphQLClient _client;
  bool _isLoading = false;
  List<StudentModel> _students = [];
  String? _errorMessage = null;

  StudentsViewModel(this._client);

  bool get isLoading => _isLoading;
  List<StudentModel> get students => _students;
  StudentModel? get selectedStudent => _selectedStudent;

  set errorMessage(String? errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  String? get errorMessage => _errorMessage;

  set students(List<StudentModel> students) {
    _students = students;
    notifyListeners();
  }

  setSelectedStudentFromCache() async {
    errorMessage = null;
    _isLoading = true;
    notifyListeners();
    // 1. get the saved student ID
    final int? studentId = await Storage.getSelectedStudentId();
    if (studentId == null) return;
    String localeCode = await Storage.getLocale();
    // 2. run a GQL query
    final options = QueryOptions(
      document: gql(getStudentByIdQuery),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      errorPolicy: ErrorPolicy.all,
      variables: {
        'studentId': (studentId),
        'locale': localeCode,
      },
    );
    try {
      notifyListeners();
      final result = await _client.query(options);
      if (result.hasException && result.data == null) {
        throw result.exception!;
      }
      _selectedStudent = result.data != null
          ? StudentModel.fromJson(result.data!['Student'])
          : null;
      notifyListeners();
    } catch (e, stackTrace) {
      Logger.error(e.toString(), stackTrace: stackTrace);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
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

  Future<List<StudentModel>> getStudents(MeViewModel meVm) async {
    try {
      errorMessage = null;
      _isLoading = true;
      notifyListeners();
      if (meVm.me == null) {
        throw Exception('meVM is called in getStudents before me is loaded');
      }
      final localeCode = await Storage.getLocale();
      final options = QueryOptions(
        document: gql(getStudentsByParentId),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        errorPolicy: ErrorPolicy.all,
        variables: {
          'userId': meVm.me!.id,
          'locale': localeCode,
        },
      );
      final result = await _client.query(options);
      if (result.hasException && result.data == null) {
        throw result.exception!;
      }
      _students = result.data?['Students']['docs']
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
      notifyListeners();
      return result.data?['Students']['docs']
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
    } catch (e, stackTrace) {
      errorMessage = e.toString();
      Logger.error(e.toString(), stackTrace: stackTrace);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  clear() {
    _selectedStudent = null;
    _students = [];
    _isLoading = false;
    errorMessage = null;
    notifyListeners();
  }
}

StudentsViewModel $studentsViewModel(BuildContext context,
    {bool listen = true}) {
  return Provider.of<StudentsViewModel>(context, listen: listen);
}
