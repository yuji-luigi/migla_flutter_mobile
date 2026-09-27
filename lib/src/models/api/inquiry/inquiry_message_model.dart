import 'package:migla_flutter/src/models/internal/logger.dart';

class InquiryMessageModel {
  final String id;
  final String body;

  /// 'user' or 'staff'
  final String sender;
  final DateTime? createdAt;

  InquiryMessageModel({
    required this.id,
    required this.body,
    required this.sender,
    this.createdAt,
  });

  bool get isMine => sender == 'user';

  static InquiryMessageModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) return null;
      return InquiryMessageModel.fromJson(json);
    } catch (error) {
      Logger.error('InquiryMessageModel.fromJson: $error');
      return null;
    }
  }

  factory InquiryMessageModel.fromJson(Map<String, dynamic> json) {
    return InquiryMessageModel(
      id: json['id'].toString(),
      body: json['body']?.toString() ?? '',
      sender: json['sender']?.toString() ?? 'user',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
    );
  }
}
