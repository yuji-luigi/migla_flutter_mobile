import 'package:migla_flutter/src/models/api/classroom/classroom_model.dart';

class StudentModel {
  final int id;
  final String name;
  final String surname;
  final String fullname;
  final ClassroomModel classroom;

  StudentModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.fullname,
    required this.classroom,
  });
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return StudentModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      fullname: json['fullname'],
      classroom: json['classroom'] != null
          ? ClassroomModel.fromJson(json['classroom'])
          : ClassroomModel.empty(),
    );
  }
}
