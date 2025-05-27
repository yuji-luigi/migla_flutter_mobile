import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static const String token = 'token';

  static Future<void> saveToken(String token) async {
    await storage.write(key: token, value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: token);
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: token);
  }

  static Future<void> removeAll() async {
    await storage.deleteAll();
  }
}
