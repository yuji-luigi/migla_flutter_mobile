import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';

/// Thrown by [ApiClientImpl] for any non-2xx response.
///
/// `toString()` keeps the historical `Exception: <body>` format so existing
/// callers that do `error.getMessage` + `jsonDecode` keep working.
class ApiException implements Exception {
  final int statusCode;
  final String body;

  ApiException(this.statusCode, this.body);

  /// Decoded JSON body, or null when the body is not JSON.
  dynamic get json {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }

  /// Human readable messages extracted from the usual backend error shapes:
  /// - Payload: `{errors:[{message, data:{errors:[{path,message}]}}]}`
  /// - custom endpoints: `{errors:[{field,message}]}` or `{error|message: "..."}`
  List<String> get messages {
    final decoded = json;
    final List<String> result = [];
    if (decoded is Map) {
      final errors = decoded['errors'];
      if (errors is List) {
        for (final e in errors) {
          if (e is! Map) continue;
          final nested = e['data'] is Map ? e['data']['errors'] : null;
          if (nested is List && nested.isNotEmpty) {
            for (final n in nested) {
              if (n is Map && n['message'] != null) {
                result.add(n['message'].toString());
              }
            }
          } else if (e['message'] != null) {
            result.add(e['message'].toString());
          }
        }
      }
      if (result.isEmpty) {
        final msg = decoded['error'] ?? decoded['message'];
        if (msg is String && msg.isNotEmpty) result.add(msg);
      }
    }
    return result;
  }

  /// Field-level validation errors keyed by field path (e.g. `holderName`,
  /// `bankAccountHolder`). Empty when the backend did not return any.
  Map<String, String> get fieldErrors {
    final decoded = json;
    final Map<String, String> result = {};
    if (decoded is Map && decoded['errors'] is List) {
      for (final e in decoded['errors']) {
        if (e is! Map) continue;
        if (e['field'] != null && e['message'] != null) {
          result[e['field'].toString()] = e['message'].toString();
        }
        final nested = e['data'] is Map ? e['data']['errors'] : null;
        if (nested is List) {
          for (final n in nested) {
            if (n is Map && n['path'] != null && n['message'] != null) {
              result[n['path'].toString()] = n['message'].toString();
            }
          }
        }
      }
    }
    return result;
  }

  @override
  String toString() => 'Exception: $body';
}

/// Best-effort user-facing message for any error thrown by the API layer.
String apiErrorMessage(Object error, {String? fallback}) {
  if (error is ApiException) {
    final messages = error.messages;
    if (messages.isNotEmpty) return messages.join('\n');
    return fallback ?? 'HTTP ${error.statusCode}';
  }
  return fallback ?? error.toString();
}

abstract class ApiClient {
  Future<http.Response> get(String path,
      {String? otherUrl, Map<String, dynamic>? query});
  Future<http.Response> post(String path,
      {String? otherUrl, Map<String, dynamic>? body});
  Future<http.Response> put(String path,
      {String? otherUrl, Map<String, dynamic>? body});
  Future<http.Response> delete(String path,
      {String? otherUrl, Map<String, dynamic>? body});
  Future<http.Response> patch(String path,
      {String? otherUrl, Map<String, dynamic>? body});
}

class ApiClientImpl implements ApiClient {
  final String baseUrl;
  // final String apiKey;

  ApiClientImpl({
    this.baseUrl = apiUrl,
    // this.apiKey,
  });

  Future<Map<String, String>> _headers() async {
    final String? token = await Storage.getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  http.Response _check(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }
    throw ApiException(response.statusCode, response.body);
  }

  @override
  Future<http.Response> get(String path,
      {String? otherUrl, Map<String, dynamic>? query}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    if (query != null) {
      // Convert Map<String, dynamic> to Map<String, String>
      Map<String, String> queryParams = query.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      uri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParams,
      });
    }
    Logger.info('GET: uri: $uri');
    final response = await http.get(uri, headers: await _headers());
    return _check(response);
  }

  @override
  Future<http.Response> post(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    final Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    Logger.info('POST: uri: $uri');
    final response = await http.post(uri,
        body: jsonEncode(body), headers: await _headers());
    return _check(response);
  }

  @override
  Future<http.Response> put(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    final Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    Logger.info('PUT: uri: $uri');
    final response = await http.put(uri,
        body: body == null ? null : jsonEncode(body),
        headers: await _headers());
    return _check(response);
  }

  @override
  Future<http.Response> delete(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    final Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    Logger.info('DELETE: uri: $uri');
    final response = await http.delete(uri,
        body: body == null ? null : jsonEncode(body),
        headers: await _headers());
    return _check(response);
  }

  @override
  Future<http.Response> patch(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    final Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    Logger.info('PATCH: uri: $uri');
    final response = await http.patch(uri,
        body: body == null ? null : jsonEncode(body),
        headers: await _headers());
    return _check(response);
  }
}
