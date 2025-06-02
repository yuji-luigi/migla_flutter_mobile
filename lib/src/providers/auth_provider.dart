// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late AuthTokenProvider tokenProvider;
  bool isLoggedIn = false;

  AuthProvider(this.tokenProvider);

  Future<void> login(String token) async {
    await tokenProvider.setToken(token);
    notifyListeners();
  }

  Future<void> logout() async {
    await Storage.removeAll();
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', tokenProvider.token));
  }
}

AuthProvider $authTokenProvider(BuildContext context) {
  return Provider.of<AuthProvider>(context, listen: true);
}
