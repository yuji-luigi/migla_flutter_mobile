import 'package:migla_flutter/src/models/api/classroom/classroom_model.dart';

class StudentModel {
  final int id;
  final String name;
  final String surname;
  final ClassroomModel classroom;

  StudentModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.classroom,
  });
  get fullname => '$name $surname';
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      classroom: json['classroom'] != null
          ? ClassroomModel.fromJson(json['classroom'])
          : ClassroomModel.empty(),
    );
  }
}
