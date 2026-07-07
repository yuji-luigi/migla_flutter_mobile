import 'dart:convert';
import 'dart:io';

import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:path_provider/path_provider.dart';

/// File-based cache for the public website content (pages + header/footer),
/// one file per locale, so the app can render without any network call.
///
/// Stored shape:
/// `{ "version": "...", "fetchedAt": "<iso>", "data": <raw GraphQL data> }`
class PublicContentCache {
  static const _filePrefix = 'public_content_';

  static Future<File> _fileFor(String locale) async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}/$_filePrefix$locale.json');
  }

  static Future<Map<String, dynamic>?> read(String locale) async {
    try {
      final file = await _fileFor(locale);
      if (!await file.exists()) return null;
      final decoded = jsonDecode(await file.readAsString());
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (e, stackTrace) {
      Logger.error('PublicContentCache.read failed: $e',
          stackTrace: stackTrace);
      return null;
    }
  }

  static Future<void> write(
    String locale,
    Map<String, dynamic> data,
    String version,
  ) async {
    try {
      final file = await _fileFor(locale);
      await file.writeAsString(jsonEncode({
        'version': version,
        'fetchedAt': DateTime.now().toIso8601String(),
        'data': data,
      }));
    } catch (e, stackTrace) {
      Logger.error('PublicContentCache.write failed: $e',
          stackTrace: stackTrace);
    }
  }

  static Future<void> clearAll() async {
    try {
      final dir = await getApplicationSupportDirectory();
      await for (final entity in dir.list()) {
        if (entity is File &&
            entity.uri.pathSegments.last.startsWith(_filePrefix)) {
          await entity.delete();
        }
      }
    } catch (e, stackTrace) {
      Logger.error('PublicContentCache.clearAll failed: $e',
          stackTrace: stackTrace);
    }
  }

  /// Deterministic version string from ids + updatedAt timestamps.
  /// Works for both the full query and the lightweight version query,
  /// since both include Pages.docs(id, updatedAt) and the globals' updatedAt.
  static String computeVersion(Map<String, dynamic> data) {
    final docs = (data['Pages']?['docs'] as List? ?? []);
    final entries = docs
        .whereType<Map<String, dynamic>>()
        .map((d) => '${d['id']}@${d['updatedAt']}')
        .toList()
      ..sort();
    final header = data['Header']?['updatedAt'];
    final footer = data['Footer']?['updatedAt'];
    return [...entries, 'header@$header', 'footer@$footer'].join('|');
  }
}
