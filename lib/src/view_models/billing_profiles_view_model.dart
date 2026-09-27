// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/models/api/billing_profile/billing_profile_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:provider/provider.dart';

/// Receipt addressees (領収書の宛名, `billing-profiles`) of the logged-in user. The backend scopes the
/// `billing-profiles` collection to its owner, so no user filter is needed.
class BillingProfilesViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final ApiClient _apiClient;

  BillingProfilesViewModel({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClientImpl();

  List<BillingProfileModel> _profiles = [];
  List<BillingProfileModel> get profiles => _profiles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  String? errorMessage;

  BillingProfileModel? get defaultProfile {
    if (_profiles.isEmpty) return null;
    return _profiles.firstWhere((p) => p.isDefault,
        orElse: () => _profiles.first);
  }

  Future<void> fetch() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final res = await _apiClient.get(apiUrlBillingProfiles, query: {
        'sort': '-isDefault',
        'limit': 50,
        'depth': 0,
      });
      final data = jsonDecode(res.body);
      _profiles = (data['docs'] as List<dynamic>? ?? [])
          .map((e) => BillingProfileModel.tryFromJson(e))
          .whereType<BillingProfileModel>()
          .toList();
      _hasLoaded = true;
    } catch (error) {
      Logger.error('Error fetching billing profiles: $error');
      errorMessage = apiErrorMessage(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Creates or updates a profile. Throws [ApiException] on validation errors
  /// so the form can show field errors.
  Future<BillingProfileModel?> save(Map<String, dynamic> body,
      {String? id}) async {
    final res = id == null
        ? await _apiClient.post(apiUrlBillingProfiles, body: body)
        : await _apiClient.patch('$apiUrlBillingProfiles/$id', body: body);
    final data = jsonDecode(res.body);
    final saved = BillingProfileModel.tryFromJson(data['doc']);
    // The backend may have changed other profiles' isDefault: reload all.
    await fetch();
    return saved;
  }

  Future<void> delete(String id) async {
    await _apiClient.delete('$apiUrlBillingProfiles/$id');
    _profiles = _profiles.where((p) => p.id != id).toList();
    notifyListeners();
    await fetch();
  }

  Future<void> setDefault(String id) async {
    await _apiClient
        .patch('$apiUrlBillingProfiles/$id', body: {'isDefault': true});
    await fetch();
  }

  void clear() {
    _profiles = [];
    _hasLoaded = false;
    errorMessage = null;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('profiles', _profiles.length));
  }
}

BillingProfilesViewModel $billingProfilesViewModel(BuildContext context,
    {bool listen = true}) {
  return Provider.of<BillingProfilesViewModel>(context, listen: listen);
}
