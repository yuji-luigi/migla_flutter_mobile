class MediaModel {
  final int id;
  final String url;
  MediaModel({
    required this.id,
    required this.url,
  });
  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      url: json['url'],
    );
  }
}
