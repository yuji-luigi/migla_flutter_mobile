import 'package:migla_flutter/src/models/api/api_model_abstract.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/models/api/teacher/teacher_model.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

class ReportDetailModel extends ApiModel {
  final int id;
  final String title;
  final TeacherModel teacher;
  final String body;
  final MediaModel? coverImage;
  final List<MediaModel> attachments;
  final DateTime createdAt;

  ReportDetailModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.teacher,
    this.coverImage,
    required this.attachments,
  });

  static ReportDetailModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return ReportDetailModel.fromJson(json);
    } catch (error) {
      return null;
    }
  }

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      return ReportDetailModel(
        id: json['id'],
        title: json['title'] ?? '',
        body: json['body'] ?? '',
        teacher: TeacherModel.fromJson(json['teacher']),
        coverImage: json['coverImage'] != null
            ? MediaModel.fromJson(json['coverImage'])
            : null,
        attachments: json['attachments'] != null
            ? List<MediaModel>.from(
                json['attachments'].map((x) => MediaModel.fromJson(x)))
            : [],
        createdAt: DateTime.parse(json['createdAt']),
      );
    } catch (error) {
      Logger.error(error.toString());
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
