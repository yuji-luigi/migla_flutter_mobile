class UserModel {
  final int id;
  final String name;
  final String surname;
  final String fullname;
  final String email;
  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.fullname,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      id: json['id'],
      surname: json['surname'],
      name: json['name'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }
  toJson() {
    return {
      'id': id,
      'name': name,
      'fullname': fullname,
      'email': email,
    };
  }
}
