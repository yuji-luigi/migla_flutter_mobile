import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/models/api/teacher/teacher_model.dart';

class ReportSumModel {
  final int id;
  final String title;
  final TeacherModel teacher;
  final bool isRead;
  // final String body;
  final MediaModel? coverImage;
  final List<MediaModel> attachments;
  final DateTime createdAt;

  ReportSumModel({
    required this.id,
    required this.title,
    required this.isRead,
    // required this.body,
    required this.createdAt,
    required this.teacher,
    this.coverImage,
    required this.attachments,
  });

  static ReportSumModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return ReportSumModel.fromJson(json);
    } catch (error) {
      return null;
    }
  }

  factory ReportSumModel.fromJson(Map<String, dynamic> json) {
    try {
      bool isRead = json['readRecords']['docs'].length > 0;
      return ReportSumModel(
        id: json['id'],
        title: json['title'] ?? '',
        isRead: isRead,
        // body: json['body'] ?? '',
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
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }
}
