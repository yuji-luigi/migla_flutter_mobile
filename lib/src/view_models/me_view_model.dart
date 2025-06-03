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
  UserModel? _me;
  UserModel? get me => _me;
  bool get hasMe => _me != null;
  ApiClient _apiClient = ApiClient();

  MeViewModel() {
    init();
  }
  init() async {
    try {
      await getMe();
      notifyListeners();
    } catch (e) {
      print('Error getting me on init: $e');
    }
  }

  Future<void> getMe() async {
    final res = await _apiClient.get(apiUrlMe);
    final data = jsonDecode(res.body);
    if (data['user'] != null) {
      _me = UserModel.fromJson(data['user']);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _apiClient.post(apiUrlLogout);
      _me = null;

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

MeViewModel $meViewModel(BuildContext context, {bool listen = true}) {
  return Provider.of<MeViewModel>(context, listen: listen);
}
