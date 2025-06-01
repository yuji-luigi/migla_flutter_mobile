class UserModel {
  final int id;
  final String name;
  final String surname;
  final String email;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.surname,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      surname: json['surname'],
      name: json['name'],
      email: json['email'],
    );
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
