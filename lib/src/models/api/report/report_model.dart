class ReportModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String createdAt;
  final String updatedAt;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
