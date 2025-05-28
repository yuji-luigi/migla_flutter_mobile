class TeacherModel {
  final int id;
  final String name;

  TeacherModel({
    required this.id,
    required this.name,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
