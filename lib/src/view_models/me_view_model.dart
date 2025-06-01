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

class MeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  String? token;
  UserModel? _me;
  UserModel? get me => _me;
  ApiClient _apiClient = ApiClient();

  MeViewModel() {
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

  Future<void> getMe() async {
    final res = await _apiClient.get(apiUrlMe);
    final data = jsonDecode(res.body);
    _me = UserModel.fromJson(data['user']);
    notifyListeners();
  }

  /// Makes `UserProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}

MeViewModel $meViewModel(BuildContext context) {
  return Provider.of<MeViewModel>(context, listen: true);
}
