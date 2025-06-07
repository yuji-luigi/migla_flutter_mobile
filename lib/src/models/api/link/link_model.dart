import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/models/api/link/link_appearance.dart';
import 'package:migla_flutter/src/models/api/link/link_type.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

/// All the possible link types

/// Model for generic link object
class LinkModel {
  // final String? id;

  /// Open in new tab? Null if unspecified
  final bool? newTab;

  /// CMS reference details if type == 'reference'
  // final LinkReference? reference;

  /// Direct URL if type == 'custom'
  final String? url;

  /// Label to display for the link
  final String label;

  /// UI appearance modifier (e.g., 'default', 'primary')
  final String appearance;

  LinkModel({
    this.newTab,
    // this.reference,
    this.url,
    // this.id,
    required this.label,
    required this.appearance,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    print(json);
    String? url;
    if (LinkTypeX.fromJson(json['type']) == LinkType.reference.name) {
      url = '$host/${json['reference']['value']['slug']}';
    } else {
      url = json['url'];
    }

    try {
      return LinkModel(
        // id: json['id'] as String?,
        newTab: json['newTab'] as bool?,
        // reference: json['reference'] != null
        //     ? LinkReference.fromJson(json['reference'] as Map<String, dynamic>)
        //     : null,
        url: url,
        label: json['label'] as String,
        appearance: LinkAppearanceX.fromJson(json['appearance']),
      );
    } catch (e, stackTrace) {
      Logger.error(json.toString());
      Logger.error(
          'Error parsing LinkModel from JSON: ${e.toString()}\nStack trace: ${stackTrace.toString()}',
          stackTrace: stackTrace);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'newTab': newTab,
        // 'reference': reference?.toJson(),
        'url': url,
        'label': label,
        'appearance': appearance,
      };
}

/// Details for a CMS reference link
class LinkReference {
  /// The collection or block being referenced (e.g. 'pages')

  /// The actual referenced item
  final ReferenceValue value;

  LinkReference({
    required this.value,
  });

  factory LinkReference.fromJson(Map<String, dynamic> json) {
    return LinkReference(
      value: ReferenceValue.fromJson(json['value'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value.toJson(),
      };
}

/// Value object for a CMS reference
class ReferenceValue {
  /// Unique identifier of the referenced item
  final int id;

  /// Title of the referenced item
  final String title;

  /// URL-friendly slug for the referenced item
  final String slug;

  ReferenceValue({
    required this.id,
    required this.title,
    required this.slug,
  });

  factory ReferenceValue.fromJson(Map<String, dynamic> json) {
    return ReferenceValue(
      id: json['id'] as int,
      title: json['title'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
      };
}
