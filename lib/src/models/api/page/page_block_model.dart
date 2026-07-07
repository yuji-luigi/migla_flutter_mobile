import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

/// One block of a page's `layout`.
///
/// `blockType` values match the Payload block slugs:
/// cta / content / mediaBlock / archive / formBlock.
abstract class PageBlockModel {
  final String blockType;

  /// Block-level visibility flag controlled from the CMS.
  final bool showInMobileApp;

  PageBlockModel({required this.blockType, required this.showInMobileApp});

  /// Returns null for unknown/unrenderable block types.
  static PageBlockModel? tryFromJson(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    try {
      switch (json['blockType'] as String?) {
        case 'cta':
          return CtaBlockModel.fromJson(json);
        case 'content':
          return ContentBlockModel.fromJson(json);
        case 'mediaBlock':
          return MediaBlockModel.fromJson(json);
        case 'archive':
          return ArchiveBlockModel.fromJson(json);
        case 'formBlock':
          return FormBlockModel.fromJson(json);
        default:
          return null;
      }
    } catch (e, stackTrace) {
      Logger.error('Error parsing PageBlockModel: $e', stackTrace: stackTrace);
      return null;
    }
  }

  static bool _flag(Map<String, dynamic> json) =>
      json['showInMobileApp'] as bool? ?? true;
}

class CtaBlockModel extends PageBlockModel {
  final Map<String, dynamic>? richText;
  final List<PublicLinkModel> links;

  CtaBlockModel({
    required super.showInMobileApp,
    this.richText,
    required this.links,
  }) : super(blockType: 'cta');

  factory CtaBlockModel.fromJson(Map<String, dynamic> json) {
    return CtaBlockModel(
      showInMobileApp: PageBlockModel._flag(json),
      richText: json['richText'] as Map<String, dynamic>?,
      links: PublicLinkModel.listFromLinksJson(json['links']),
    );
  }
}

class ContentColumnModel {
  final String size;
  final Map<String, dynamic>? richText;
  final bool enableLink;
  final PublicLinkModel? link;

  ContentColumnModel({
    required this.size,
    this.richText,
    required this.enableLink,
    this.link,
  });

  factory ContentColumnModel.fromJson(Map<String, dynamic> json) {
    return ContentColumnModel(
      size: json['size'] as String? ?? 'full',
      richText: json['richText'] as Map<String, dynamic>?,
      enableLink: json['enableLink'] as bool? ?? false,
      link: PublicLinkModel.tryFromJson(json['link']),
    );
  }
}

class ContentBlockModel extends PageBlockModel {
  final List<ContentColumnModel> columns;

  ContentBlockModel({
    required super.showInMobileApp,
    required this.columns,
  }) : super(blockType: 'content');

  factory ContentBlockModel.fromJson(Map<String, dynamic> json) {
    final columns = (json['columns'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(ContentColumnModel.fromJson)
        .toList();
    return ContentBlockModel(
      showInMobileApp: PageBlockModel._flag(json),
      columns: columns,
    );
  }
}

class MediaBlockModel extends PageBlockModel {
  final MediaModel? media;

  MediaBlockModel({
    required super.showInMobileApp,
    this.media,
  }) : super(blockType: 'mediaBlock');

  factory MediaBlockModel.fromJson(Map<String, dynamic> json) {
    final mediaJson = json['media'];
    return MediaBlockModel(
      showInMobileApp: PageBlockModel._flag(json),
      media: mediaJson is Map<String, dynamic>
          ? MediaModel.fromJson(mediaJson)
          : null,
    );
  }
}

class ArchiveBlockModel extends PageBlockModel {
  final Map<String, dynamic>? introContent;

  ArchiveBlockModel({
    required super.showInMobileApp,
    this.introContent,
  }) : super(blockType: 'archive');

  factory ArchiveBlockModel.fromJson(Map<String, dynamic> json) {
    return ArchiveBlockModel(
      showInMobileApp: PageBlockModel._flag(json),
      introContent: json['introContent'] as Map<String, dynamic>?,
    );
  }
}

class FormBlockModel extends PageBlockModel {
  final bool enableIntro;
  final Map<String, dynamic>? introContent;

  FormBlockModel({
    required super.showInMobileApp,
    required this.enableIntro,
    this.introContent,
  }) : super(blockType: 'formBlock');

  factory FormBlockModel.fromJson(Map<String, dynamic> json) {
    return FormBlockModel(
      showInMobileApp: PageBlockModel._flag(json),
      enableIntro: json['enableIntro'] as bool? ?? false,
      introContent: json['introContent'] as Map<String, dynamic>?,
    );
  }
}
