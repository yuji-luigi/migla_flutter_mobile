import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static const String _token = 'token';
  static const String _selectedStudentId = 'selectedStudentId';
  static const String _email = 'email';
  static const String _password = 'password';

  static Future<void> saveToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  static Future<void> saveSelectedStudentId(int studentId) async {
    await storage.write(key: _selectedStudentId, value: studentId.toString());
  }

  static Future<void> removeSelectedStudentId() async {
    await storage.delete(key: _selectedStudentId);
  }

  static Future<int?> getSelectedStudentId() async {
    String? studentId = await storage.read(key: _selectedStudentId);
    return studentId != null ? int.parse(studentId) : null;
  }

  static Future<String?> getToken() async {
    return await storage.read(key: _token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: _token);
  }

  static Future<void> saveCredentials(String email, String password) async {
    await storage.write(key: _email, value: email);
    await storage.write(key: _password, value: password);
  }

  static Future<void> removeAll() async {
    await storage.deleteAll();
    print(await storage.readAll());
  }
}
