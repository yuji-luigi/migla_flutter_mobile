import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';

class ApiClient {
  final String baseUrl;
  // final String apiKey;

  ApiClient({
    this.baseUrl = apiUrl,
    // this.apiKey,
  });

  Future<http.Response> get(String path, {String? otherUrl}) async {
    String? token = await Storage.getToken();
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    String? token = await Storage.getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    print('POST: uri: $uri');
    http.Response response =
        await http.post(uri, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(response.body);
    }
  }

  Future<http.Response> put(String path, {String? otherUrl}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    http.Response response = await http.put(uri);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> delete(String path, {String? otherUrl}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    http.Response response = await http.delete(uri);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> patch(String path, {String? otherUrl}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    http.Response response = await http.patch(uri);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
