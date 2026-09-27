class UserModel {
  final int id;
  final String name;
  final String surname;
  final String fullname;
  final String email;

  /// Set when the school created the account with a temporary password: the
  /// app sends the user to the change-password screen before anything else.
  final bool mustChangePassword;
  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.fullname,
    required this.email,
    this.mustChangePassword = false,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      surname: json['surname'],
      name: json['name'],
      fullname: json['fullname'],
      email: json['email'],
      mustChangePassword: json['mustChangePassword'] == true,
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
