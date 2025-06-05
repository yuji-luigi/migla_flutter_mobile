import 'package:migla_flutter/src/models/api/media/media_model.dart';

class NotificationModel {
  final int id;
  final String type;
  final String title;
  final String body;
  final String createdAt;
  final List<MediaModel> attachments;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.attachments,
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
    try {
      return NotificationModel(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        body: json['body'],
        createdAt: json['createdAt'],
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
