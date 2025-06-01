import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:migla_flutter/src/models/api/student/student_model.dart';

class Storage {
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static const String _token = 'token';
  static const String _selectedStudentId = 'selectedStudentId';

  static Future<void> saveToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  static Future<void> saveSelectedStudentId(int studentId) async {
    await storage.write(key: _selectedStudentId, value: studentId.toString());
  }

  static Future<String?> getSelectedStudentId() async {
    String? studentId = await storage.read(key: _selectedStudentId);
    return studentId;
  }

  static Future<String?> getToken() async {
    return await storage.read(key: _token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: _token);
  }

  static Future<void> removeAll() async {
    await storage.deleteAll();
  }
}
