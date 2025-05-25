import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:migla_flutter/env_vars.dart';

class ApiClient {
  final String baseUrl;
  // final String apiKey;

  ApiClient({
    this.baseUrl = apiUrl,
    // this.apiKey,
  });

  Future<http.Response> get(String path, {String? otherUrl}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String path,
      {String? otherUrl, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(otherUrl ?? '$baseUrl$path');

    http.Response response =
        await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
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
