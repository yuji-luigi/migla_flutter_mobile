import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/models/api/page/page_block_model.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

class PageHeroModel {
  /// none / lowImpact / mediumImpact / highImpact
  final String type;
  final Map<String, dynamic>? richText;
  final MediaModel? media;
  final List<PublicLinkModel> links;

  PageHeroModel({
    required this.type,
    this.richText,
    this.media,
    required this.links,
  });

  bool get hasContent =>
      type != 'none' && (richText != null || media != null || links.isNotEmpty);

  factory PageHeroModel.fromJson(Map<String, dynamic> json) {
    final mediaJson = json['media'];
    return PageHeroModel(
      type: json['type'] as String? ?? 'none',
      richText: json['richText'] as Map<String, dynamic>?,
      media: mediaJson is Map<String, dynamic>
          ? MediaModel.fromJson(mediaJson)
          : null,
      links: PublicLinkModel.listFromLinksJson(json['links']),
    );
  }
}

/// A CMS website page flagged to appear in the mobile app.
class PublicPageModel {
  final int id;
  final String title;
  final String slug;
  final String updatedAt;
  final PageHeroModel? hero;
  final List<PageBlockModel> layout;

  PublicPageModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.updatedAt,
    this.hero,
    required this.layout,
  });

  /// Blocks that passed the CMS block-level `showInMobileApp` flag.
  List<PageBlockModel> get visibleBlocks =>
      layout.where((b) => b.showInMobileApp).toList();

  factory PublicPageModel.fromJson(Map<String, dynamic> json) {
    final heroJson = json['hero'];
    return PublicPageModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      hero: heroJson is Map<String, dynamic>
          ? PageHeroModel.fromJson(heroJson)
          : null,
      layout: (json['layout'] as List? ?? [])
          .map(PageBlockModel.tryFromJson)
          .whereType<PageBlockModel>()
          .toList(),
    );
  }

  static PublicPageModel? tryFromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    try {
      return PublicPageModel.fromJson(json);
    } catch (e, stackTrace) {
      Logger.error('Error parsing PublicPageModel: $e', stackTrace: stackTrace);
      return null;
    }
  }
}
