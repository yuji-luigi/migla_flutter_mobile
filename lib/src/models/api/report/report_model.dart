import 'package:migla_flutter/src/models/api/media/media_model.dart';

class ReportModel {
  final int id;
  final String title;
  final String description;
  final MediaModel? coverImage;
  final List<MediaModel>? attachments;
  final String createdAt;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.coverImage,
    this.attachments,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    try {
      return ReportModel(
        id: json['id'],
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        coverImage: json['coverImage'] != null
            ? MediaModel.fromJson(json['coverImage'])
            : null,
        attachments: json['attachments'] != null
            ? List<MediaModel>.from(
                json['attachments'].map((x) => MediaModel.fromJson(x)))
            : null,
        createdAt: json['createdAt'],
      );
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }
}
