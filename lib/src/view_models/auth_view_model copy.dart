// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';
import 'package:migla_flutter/src/models/user_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  String? token;
  bool isLoggedIn = false;
  ApiClient _apiClient = ApiClient();

  AuthViewModel() {
    init();
  }
  init() async {
    String? token = await Storage.getToken();
    this.token = token;
    notifyListeners();
  }

  void setToken(String token) {
    this.token = token;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _apiClient.post(apiUrlLogout);
      _me = null;
      token = null;
      await Storage.removeAll();
    } catch (e) {
      print('Error logging out: $e');
    }
    notifyListeners();
  }

  /// Makes `UserProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

AuthViewModel $meViewModel(BuildContext context) {
  return Provider.of<AuthViewModel>(context, listen: true);
}
