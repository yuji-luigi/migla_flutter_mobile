import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/models/api/page/graphql/public_content_queries.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/models/api/page/public_page_model.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/internal/public_content_cache.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:provider/provider.dart';

/// Public (pre-login) website content: pages flagged `showInMobileApp`
/// plus the Header/Footer navigation, cached on disk per locale.
///
/// Flow on app open:
/// 1. Load the cache for the current locale and render immediately.
/// 2. Probe the server with a lightweight version query.
/// 3. If the version differs, set [isUpdating] (UI shows the localized
///    "new contents available" notice), refetch everything and re-cache.
class PublicContentViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final GraphQLClient _client;

  PublicContentViewModel(this._client);

  String _locale = 'ja';
  bool _isLoading = false;
  bool _isUpdating = false;
  String? _errorMessage;
  String? _version;
  bool _initialized = false;

  List<PublicPageModel> _pages = [];
  List<PublicLinkModel> _headerNav = [];
  List<PublicLinkModel> _footerNav = [];

  bool get isLoading => _isLoading;

  /// True while new content is being downloaded after a version mismatch.
  bool get isUpdating => _isUpdating;
  String? get errorMessage => _errorMessage;
  bool get hasContent => _pages.isNotEmpty;
  List<PublicPageModel> get pages => _pages;
  List<PublicLinkModel> get headerNav => _headerNav;
  List<PublicLinkModel> get footerNav => _footerNav;

  PublicPageModel? get homePage {
    if (_pages.isEmpty) return null;
    return _pages.firstWhere(
      (p) => p.slug == 'home',
      orElse: () => _pages.first,
    );
  }

  PublicPageModel? pageBySlug(String? slug) {
    if (slug == null) return null;
    for (final page in _pages) {
      if (page.slug == slug) return page;
    }
    return null;
  }

  /// Idempotent: safe to call from every public screen's initState.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    await _load();
  }

  /// Re-loads content after a locale change (cache per locale).
  Future<void> onLocaleChanged() async {
    _initialized = true;
    await _load();
  }

  /// Pull-to-refresh: force a version check (or full fetch if empty).
  Future<void> refresh() async {
    if (!hasContent) {
      await _fetchFull(showFullLoading: true);
    } else {
      await _checkForUpdates(force: false);
    }
  }

  Future<void> _load() async {
    _errorMessage = null;
    _locale = await Storage.getLocale();
    final cached = await PublicContentCache.read(_locale);
    if (cached != null && cached['data'] is Map<String, dynamic>) {
      _applyData(cached['data'] as Map<String, dynamic>);
      _version = cached['version'] as String?;
      notifyListeners();
      await _checkForUpdates();
    } else {
      await _fetchFull(showFullLoading: true);
    }
  }

  Future<void> _checkForUpdates({bool force = false}) async {
    try {
      final result = await _client.query(QueryOptions(
        document: gql(publicContentVersionQuery),
        fetchPolicy: FetchPolicy.networkOnly,
        errorPolicy: ErrorPolicy.all,
      ));
      if (result.hasException && result.data == null) {
        throw result.exception!;
      }
      final remoteVersion =
          PublicContentCache.computeVersion(result.data ?? {});
      if (force || remoteVersion != _version) {
        _isUpdating = true;
        notifyListeners();
        await _fetchFull(showFullLoading: false);
      }
    } catch (e, stackTrace) {
      // Offline or server unreachable: keep serving the cached content.
      Logger.warn('Public content version check failed: $e');
      Logger.error(e.toString(), stackTrace: stackTrace);
    } finally {
      if (_isUpdating) {
        _isUpdating = false;
        notifyListeners();
      }
    }
  }

  Future<void> _fetchFull({required bool showFullLoading}) async {
    if (showFullLoading) {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
    }
    try {
      final result = await _client.query(QueryOptions(
        document: gql(publicContentQuery),
        fetchPolicy: FetchPolicy.networkOnly,
        errorPolicy: ErrorPolicy.all,
        variables: {'locale': _locale},
      ));
      if (result.hasException && result.data == null) {
        throw result.exception!;
      }
      final data = result.data!;
      _applyData(data);
      _version = PublicContentCache.computeVersion(data);
      await PublicContentCache.write(_locale, data, _version!);
      notifyListeners();
    } catch (e, stackTrace) {
      _errorMessage = e.toString();
      Logger.error(e.toString(), stackTrace: stackTrace);
      notifyListeners();
    } finally {
      if (showFullLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void _applyData(Map<String, dynamic> data) {
    _pages = (data['Pages']?['docs'] as List? ?? [])
        .map(PublicPageModel.tryFromJson)
        .whereType<PublicPageModel>()
        .toList();
    _headerNav = PublicLinkModel.listFromLinksJson(data['Header']?['navItems']);
    _footerNav = PublicLinkModel.listFromLinksJson(data['Footer']?['navItems']);
  }
}

PublicContentViewModel $publicContentViewModel(BuildContext context,
    {bool listen = true}) {
  return Provider.of<PublicContentViewModel>(context, listen: listen);
}
