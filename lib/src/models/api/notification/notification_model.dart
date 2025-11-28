import 'dart:ffi';

import 'package:migla_flutter/src/models/api/api_model_abstract.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

class NotificationModel extends ApiModel {
  final int id;
  final String type;
  final String title;
  final String body;
  final String collection;
  final int collectionRecordId;
  final String createdAt;
  final bool isRead;
  final bool hasAttachments;
  // final List<LinkModel> links;
  // final List<MediaModel> attachments;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.collection,
    required this.collectionRecordId,
    required this.createdAt,
    // required this.attachments,
    required this.isRead,
    required this.hasAttachments,
    // required this.links,
  });

  static NotificationModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return NotificationModel.fromJson(json);
    } catch (error) {
      Logger.error(error.toString());
      return null;
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationModel(
        id: json['id'],
        type: json['data']['type'],
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        collection: json['data']['collection'] ?? '',
        collectionRecordId:
            int.tryParse(json['data']['collectionRecordId']) ?? -1,
        createdAt: json['createdAt'],
        isRead: json['readRecords'] != null &&
            json['readRecords']['docs'].isNotEmpty,
        // links: json['links'] is List && json['links'].isNotEmpty
        // ? json['links']
        //     .map<LinkModel>(
        //         (linkObj) => LinkModel.fromJson(linkObj['link']))
        //     .toList()
        // : [],
        hasAttachments: json['hasAttachments'] ?? false,
      );
    } catch (error, stackTrace) {
      Logger.error(json.toString());
      Logger.error(error.toString());
      Logger.error(stackTrace.toString());
      rethrow;
    }
  }
}
