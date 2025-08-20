import 'package:migla_flutter/src/models/api/role/role_model.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/models/user_model.dart';

class MeModel extends UserModel {
  final RoleModel currentRole;

  MeModel({
    required super.id,
    required super.name,
    required super.surname,
    required super.email,
    required super.fullname,
    required this.currentRole,
  });
  factory MeModel.fromJson(Map<String, dynamic> json) {
    try {
      return MeModel(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        fullname: json['fullname'],
        currentRole: RoleModel.fromJson(json['currentRole']),
      );
    } catch (e) {
      Logger.error('Error parsing MeModel: $e');
      rethrow;
    }
  }
}
