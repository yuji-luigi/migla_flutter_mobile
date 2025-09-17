import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static const String _token = 'token';
  static const String _selectedStudentId = 'selectedStudentId';
  static const String _email = 'email';
  static const String _password = 'password';
  static const String _seenOnboarding = 'seenOnboarding';
  static const String _locale = 'locale';
  static const String _fcmToken = 'fcmToken';

  static Future<String?> _read({required String key}) async {
    try {
      return await storage.read(key: key);
    } on PlatformException catch (e) {
      // failed to decrypt (or any other storage error) → clear it and use defaults
      await storage.delete(key: key);
      return null;
    }
  }

  static Future<Map<String, String>?> getLoginCredentials() async {
    String? email = await _read(key: _email);
    String? password = await _read(key: _password);
    return email != null && password != null ? {email: password} : null;
  }

  static Future<void> saveFcmToken(String fcmToken) async {
    await storage.write(key: _fcmToken, value: fcmToken);
  }

  static Future<String?> getFcmToken() async {
    return await _read(key: _fcmToken);
  }

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
    String? studentId = await _read(key: _selectedStudentId);
    return studentId != null ? int.parse(studentId) : null;
  }

  static Future<String?> getToken() async {
    return await _read(key: _token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: _token);
  }

  static Future<void> setSeenOnboarding(bool seen) async {
    await storage.write(key: _seenOnboarding, value: seen.toString());
  }

  static Future<bool> getSeenOnboarding() async {
    String? seen = await _read(key: _seenOnboarding);
    return seen != null ? bool.parse(seen) : false;
  }

  static Future<void> saveCredentials(String email, String password) async {
    await storage.write(key: _email, value: email);
    await storage.write(key: _password, value: password);
  }

  static Future<void> removeAll() async {
    String? email = await _read(key: _email);
    String? password = await _read(key: _password);
    await storage.deleteAll();
    setSeenOnboarding(true);
    if (email != null && password != null) {
      await saveCredentials(email, password);
    }
  }

  static Future<void> forceRemoveAll() async {
    await storage.deleteAll();
    print('storage deleted');
  }

  static Future<void> setLocale(String locale) async {
    await storage.write(key: _locale, value: locale);
  }

  static Future<String> getLocale() async {
    return await _read(key: _locale) ?? 'ja';
  }
}
