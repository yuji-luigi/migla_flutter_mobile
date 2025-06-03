import 'package:migla_flutter/env_vars.dart';

class MediaModel {
  final int id;
  final String url;
  final String? mimeType;
  final String? filename;
  final String? extension;
  MediaModel({
    required this.id,
    required this.url,
    this.mimeType,
    this.extension,
    this.filename,
  });
  factory MediaModel.fromJson(Map<String, dynamic> json) {
    String? extension = json['filename']?.split('.').last;
    String url = host + json['url'];
    return MediaModel(
      id: json['id'],
      url: url,
      mimeType: json['mimeType'],
      extension: extension,
      filename: json['filename'],
    );
  }
}
