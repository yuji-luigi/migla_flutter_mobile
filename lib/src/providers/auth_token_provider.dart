// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';
import 'package:provider/provider.dart';

class AuthTokenProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? token;

  AuthTokenProvider() {
    init();
  }
  init() async {
    String? token = await Storage.getToken();
    print(token);
    this.token = token;
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    await Storage.saveToken(token);
    this.token = token;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', token));
  }
}

AuthTokenProvider $authTokenProvider(BuildContext context) {
  return Provider.of<AuthTokenProvider>(context, listen: true);
}
