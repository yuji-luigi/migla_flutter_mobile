import 'package:migla_flutter/src/models/api/teacher/teacher_model.dart';

class ClassroomModel {
  final int id;
  final String name;
  final List<TeacherModel>? teachers;

  ClassroomModel({
    required this.id,
    required this.name,
    this.teachers,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id'],
      name: json['name'],
      teachers: json['teachers'] != null
          ? (json['teachers'] as List)
              .map((e) => TeacherModel.fromJson(e))
              .toList()
          : null,
    );
  }
}
