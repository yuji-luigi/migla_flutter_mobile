import 'package:migla_flutter/src/models/api/link/link_model.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';

class NotificationModel {
  final int id;
  final String type;
  final String title;
  // final String body;
  final String createdAt;
  final bool isRead;
  final bool hasAttachments;
  // final List<LinkModel> links;
  // final List<MediaModel> attachments;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    // required this.body,
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
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      return NotificationModel(
        id: json['id'],
        type: json['type'],
        title: json['title'] ?? '',
        // body: json['body'],
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
      print(json);
      print(error.toString());
      print(stackTrace.toString());
      rethrow;
    }
  }
}
