import 'package:migla_flutter/src/models/api/role/role_model.dart';
import 'package:migla_flutter/src/models/user_model.dart';

class MeModel extends UserModel {
  final RoleModel currentRole;

  MeModel({
    required super.id,
    required super.name,
    required super.surname,
    required super.email,
    required this.currentRole,
  });
  factory MeModel.fromJson(Map<String, dynamic> json) {
    try {
      return MeModel(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        currentRole: RoleModel.fromJson(json['currentRole']),
      );
    } catch (e, stackTrace) {
      print('Error parsing MeModel: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
