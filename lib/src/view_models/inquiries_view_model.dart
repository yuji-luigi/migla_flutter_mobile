// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_message_model.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:provider/provider.dart';

/// Inquiries (お問い合わせ) of the logged-in user and their message threads.
class InquiriesViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final ApiClient _apiClient;

  InquiriesViewModel({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClientImpl();

  List<InquiryModel> _inquiries = [];
  List<InquiryModel> get inquiries => _inquiries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  String? errorMessage;

  int get unreadCount => _inquiries.where((i) => i.unreadByUser).length;

  InquiryModel? findById(String id) {
    for (final i in _inquiries) {
      if (i.id == id) return i;
    }
    return null;
  }

  Future<void> fetchInquiries() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final res = await _apiClient.get(apiUrlInquiries, query: {
        'sort': '-lastMessageAt',
        'limit': 50,
        'depth': 0,
      });
      final data = jsonDecode(res.body);
      _inquiries = (data['docs'] as List<dynamic>? ?? [])
          .map((e) => InquiryModel.tryFromJson(e))
          .whereType<InquiryModel>()
          .toList();
      _hasLoaded = true;
    } catch (error) {
      Logger.error('Error fetching inquiries: $error');
      errorMessage = apiErrorMessage(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Loads a single inquiry (used when opening a thread from a push before
  /// the list was loaded). Returns null when not accessible.
  Future<InquiryModel?> fetchInquiry(String id) async {
    try {
      final res =
          await _apiClient.get('$apiUrlInquiries/$id', query: {'depth': 0});
      return InquiryModel.tryFromJson(jsonDecode(res.body));
    } catch (error) {
      Logger.error('Error fetching inquiry $id: $error');
      return null;
    }
  }

  Future<List<InquiryMessageModel>> fetchMessages(String inquiryId) async {
    final res = await _apiClient.get(apiUrlInquiryMessages, query: {
      'where[inquiry][equals]': inquiryId,
      'sort': 'createdAt',
      'limit': 200,
      'depth': 0,
    });
    final data = jsonDecode(res.body);
    return (data['docs'] as List<dynamic>? ?? [])
        .map((e) => InquiryMessageModel.tryFromJson(e))
        .whereType<InquiryMessageModel>()
        .toList();
  }

  Future<InquiryMessageModel?> sendMessage(
      String inquiryId, String message) async {
    final res = await _apiClient.post(apiUrlInquiryPostMessage(inquiryId),
        body: {'message': message});
    final data = jsonDecode(res.body);
    final sent = InquiryMessageModel.tryFromJson(
        data['message'] is Map<String, dynamic> ? data['message'] : null);
    _updateLocal(inquiryId,
        (i) => i.copyWith(lastMessageAt: sent?.createdAt ?? DateTime.now()));
    return sent;
  }

  Future<void> markRead(String inquiryId) async {
    try {
      await _apiClient.post(apiUrlInquiryRead(inquiryId));
      _updateLocal(inquiryId, (i) => i.copyWith(unreadByUser: false));
    } catch (error) {
      Logger.error('Error marking inquiry $inquiryId read: $error');
    }
  }

  /// Creates a new inquiry. For guests pass [name], [email] and
  /// [privacyConsent]. Returns the new inquiry id.
  Future<String?> submit({
    required String subject,
    required String message,
    required String category,
    required String locale,
    String? name,
    String? email,
    bool? privacyConsent,
  }) async {
    final res = await _apiClient.post(apiUrlInquirySubmit, body: {
      'subject': subject,
      'message': message,
      'category': category,
      'locale': locale,
      'source': 'app',
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (privacyConsent != null) 'privacyConsent': privacyConsent,
    });
    final data = jsonDecode(res.body);
    return data['id']?.toString();
  }

  void _updateLocal(String id, InquiryModel Function(InquiryModel) update) {
    final index = _inquiries.indexWhere((i) => i.id == id);
    if (index < 0) return;
    _inquiries = [..._inquiries]..[index] = update(_inquiries[index]);
    notifyListeners();
  }

  void clear() {
    _inquiries = [];
    _hasLoaded = false;
    errorMessage = null;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('inquiries', _inquiries.length));
  }
}

InquiriesViewModel $inquiriesViewModel(BuildContext context,
    {bool listen = true}) {
  return Provider.of<InquiriesViewModel>(context, listen: listen);
}
