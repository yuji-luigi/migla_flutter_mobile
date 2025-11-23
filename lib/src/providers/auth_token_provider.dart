// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:provider/provider.dart';

class AuthTokenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? token;

  AuthTokenProvider() {
    init();
  }
  init() async {
    String? token = await Storage.getToken();
    this.token = token;
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    this.token = token;
    await Storage.saveToken(token);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', token));
  }
}

AuthTokenProvider $authTokenProvider(
  BuildContext context, {
  bool listen = true,
}) {
  return Provider.of<AuthTokenProvider>(
    context,
    listen: listen,
  );
}
