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

  /// Deterministic version string: page ids + updatedAt, plus a content
  /// hash of the Header/Footer globals.
  ///
  /// Globals are hashed (not compared by updatedAt) because Payload does
  /// not bump a global's updatedAt on update. Requires the version query
  /// and the full query to select Header/Footer identically — see the note
  /// on publicContentVersionQuery.
  static String computeVersion(Map<String, dynamic> data) {
    final docs = (data['Pages']?['docs'] as List? ?? []);
    final entries = docs
        .whereType<Map<String, dynamic>>()
        .map((d) => '${d['id']}@${d['updatedAt']}')
        .toList()
      ..sort();
    final headerHash = _fnv1a(jsonEncode(data['Header'] ?? {}));
    final footerHash = _fnv1a(jsonEncode(data['Footer'] ?? {}));
    return [...entries, 'header#$headerHash', 'footer#$footerHash'].join('|');
  }

  /// FNV-1a 64-bit — stable across app launches (String.hashCode is not).
  static String _fnv1a(String input) {
    var hash = 0xcbf29ce484222325;
    for (final codeUnit in input.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x100000001b3) & 0xFFFFFFFFFFFFFFFF;
    }
    return hash.toRadixString(16);
  }
}
