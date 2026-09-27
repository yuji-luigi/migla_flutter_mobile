// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/models/user_model.dart';
import 'package:provider/provider.dart';

class MeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel? _me;
  UserModel? get me => _me;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get hasMe => _me != null;
  final ApiClientImpl _apiClient = ApiClientImpl();

  Future<UserModel?> getMe() async {
    try {
      _isLoading = true;
      final res = await _apiClient.get(apiUrlMe);
      final data = jsonDecode(res.body);
      // if (data['user'] == null) {
      //   throw Exception('User not found');
      // }

      // if (data['user'] != null) {
      //   _me = UserModel.fromJson(data['user']);
      // }
      _me = UserModel.fromJson(data['user']);
      // await Storage.setUserId(_me!.id);
      _isLoading = false;
      notifyListeners();
      return _me;
    } catch (error) {
      Logger.error('Error getting me: $error');
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post(apiUrlLogout);
      _me = null;
      await Storage.removeAll();
    } catch (e) {
      Logger.error('Error logging out: $e');
    }
    notifyListeners();
  }

  /// Changes the logged-in user's password (current password required).
  /// Throws [ApiException] on failure; its `fieldErrors`/json carry a `code`
  /// (`wrong_current`, `too_short`, `same_as_current`, `missing`).
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _apiClient.post(apiUrlChangePassword, body: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    // "Remember me" keeps the password on the device: keep it in sync.
    final saved = await Storage.getLoginCredentials();
    final String? email = _me?.email;
    if (saved != null && email != null && saved.containsKey(email)) {
      await Storage.saveCredentials(email, newPassword);
    }
    await getMe(); // refreshes mustChangePassword (now false)
  }

  /// Requests deletion of the logged-in account (App Store 5.1.1(v)).
  ///
  /// Returns the backend status: `deleted` (account removed immediately, local
  /// session cleared here) or `requested` (enrolled family: the request was
  /// forwarded to the school office). Throws [ApiException] on failure.
  Future<String> deleteAccount({String? reason, required String locale}) async {
    final res = await _apiClient.post(apiUrlDeleteAccount, body: {
      'confirm': true,
      if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim(),
      'locale': locale,
    });
    final data = jsonDecode(res.body);
    final String status = data['status']?.toString() ?? 'requested';
    if (status == 'deleted') {
      final String? email = _me?.email;
      _me = null;
      await Storage.clearForDeletedAccount(email: email);
      notifyListeners();
    }
    return status;
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
