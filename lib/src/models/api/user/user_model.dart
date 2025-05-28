class UserModel {
  final int id;
  final String name;
  final String surname;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}
