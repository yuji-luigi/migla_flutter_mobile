class RoleModel {
  final int id;
  final bool isParent;
  final bool isTeacher;
  final bool isSuperAdmin;
  final bool isAdminLevel;

  RoleModel({
    required this.id,
    required this.isParent,
    required this.isTeacher,
    required this.isSuperAdmin,
    required this.isAdminLevel,
  });
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      isParent: json['isParent'] ?? false,
      isTeacher: json['isTeacher'] ?? false,
      isSuperAdmin: json['isSuperAdmin'] ?? false,
      isAdminLevel: json['isAdminLevel'] ?? false,
    );
  }
}
