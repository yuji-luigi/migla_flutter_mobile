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
      teachers: json['teachers']['docs'] != null
          ? (json['teachers']['docs'] as List)
              .map((e) => TeacherModel.fromJson(e))
              .toList()
          : null,
    );
  }
  factory ClassroomModel.empty({
    Map<String, dynamic> overrides = const {},
  }) {
    Map<String, dynamic> json = {
      'id': 0,
      'name': 'Classroom is not set',
      'teachers': {"docs": []},
    };
    json.addAll(overrides);
    return ClassroomModel.fromJson(json);
  }
}
