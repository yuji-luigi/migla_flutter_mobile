import 'package:migla_flutter/src/models/api/link/link_model.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';

class NotificationDetailModel extends NotificationModel {
  final String body;
  final List<LinkModel> links;
  final List<MediaModel> attachments;

  NotificationDetailModel({
    required super.id,
    required super.type,
    required super.title,
    required this.body,
    required super.createdAt,
    required this.attachments,
    required super.isRead,
    required super.hasAttachments,
    this.links = const [],
  });

  static NotificationDetailModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return NotificationDetailModel.fromJson(json);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      return NotificationDetailModel(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        body: json['body'],
        createdAt: json['createdAt'],
        isRead: json['isRead'] ?? false,
        links: json['links'] is List && json['links'].isNotEmpty
            ? json['links']
                .map<LinkModel>(
                    (linkObj) => LinkModel.fromJson(linkObj['link']))
                .toList()
            : [],
        hasAttachments: json['hasAttachments'] ?? false,
        attachments: json['attachments'].isNotEmpty
            ? json['attachments']
                .map<MediaModel>(
                    (attachment) => MediaModel.fromJson(attachment))
                .toList()
            : [],
      );
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      rethrow;
    }
  }
}
