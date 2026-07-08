import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

/// Link used in public content (hero links, CTA links, header/footer nav).
///
/// Unlike [LinkModel] this tolerates missing `appearance` (nav links have
/// none) and keeps the reference slug so the app can open the referenced
/// page natively instead of in the browser.
class PublicLinkModel {
  /// 'reference' (internal) or 'custom' (external URL)
  final String type;
  final bool newTab;
  final String label;

  /// Direct URL when [type] == 'custom'
  final String? url;

  /// 'pages' | 'posts' when [type] == 'reference'
  final String? referenceCollection;
  final String? referenceSlug;
  final String? referenceTitle;

  /// 'default' | 'outline' — null when the field is not configured
  final String? appearance;

  PublicLinkModel({
    required this.type,
    required this.newTab,
    required this.label,
    this.url,
    this.referenceCollection,
    this.referenceSlug,
    this.referenceTitle,
    this.appearance,
  });

  bool get isReference => type == 'reference';

  bool get isPageReference => isReference && referenceCollection == 'pages';

  /// Website URL equivalent of this link (fallback when the target is not
  /// available inside the app).
  String get webUrl {
    if (isReference) {
      return '$host/${referenceSlug ?? ''}';
    }
    return url ?? host;
  }

  factory PublicLinkModel.fromJson(Map<String, dynamic> json) {
    final reference = json['reference'] as Map<String, dynamic>?;
    final value = reference?['value'] as Map<String, dynamic>?;
    return PublicLinkModel(
      type: json['type'] as String? ?? 'custom',
      newTab: json['newTab'] as bool? ?? false,
      label: json['label'] as String? ?? '',
      url: json['url'] as String?,
      referenceCollection: reference?['relationTo'] as String?,
      referenceSlug: value?['slug'] as String?,
      referenceTitle: value?['title'] as String?,
      appearance: json['appearance'] as String?,
    );
  }

  static PublicLinkModel? tryFromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    try {
      return PublicLinkModel.fromJson(json);
    } catch (e, stackTrace) {
      Logger.error('Error parsing PublicLinkModel: $e', stackTrace: stackTrace);
      return null;
    }
  }

  /// Parses a Payload `links` array (`[{ link: {...} }]`) or a `navItems`
  /// array of the same shape.
  ///
  /// Rows carrying a `showInMobileApp: false` flag (Header/Footer navItems)
  /// are dropped; missing/null counts as visible (pre-flag rows).
  static List<PublicLinkModel> listFromLinksJson(dynamic links) {
    if (links is! List) return [];
    return links
        .map((e) {
          if (e is! Map<String, dynamic>) return null;
          if (e['showInMobileApp'] == false) return null;
          return tryFromJson(e['link']);
        })
        .whereType<PublicLinkModel>()
        .toList();
  }
}
