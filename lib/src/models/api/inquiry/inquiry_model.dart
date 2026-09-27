import 'package:migla_flutter/src/models/internal/logger.dart';

enum InquiryStatus { newStatus, open, answered, closed }

extension InquiryStatusX on InquiryStatus {
  static InquiryStatus fromJson(dynamic value) {
    switch (value) {
      case 'open':
        return InquiryStatus.open;
      case 'answered':
        return InquiryStatus.answered;
      case 'closed':
        return InquiryStatus.closed;
      case 'new':
      default:
        return InquiryStatus.newStatus;
    }
  }
}

/// Inquiry categories accepted by `POST /inquiries/submit`.
const List<String> inquiryCategories = [
  'general',
  'admission',
  'payment',
  'app',
  'other',
];

class InquiryModel {
  final String id;
  final String subject;
  final String category;
  final InquiryStatus status;
  final bool unreadByUser;
  final DateTime? lastMessageAt;
  final DateTime? createdAt;

  InquiryModel({
    required this.id,
    required this.subject,
    required this.category,
    required this.status,
    required this.unreadByUser,
    this.lastMessageAt,
    this.createdAt,
  });

  bool get isClosed => status == InquiryStatus.closed;

  DateTime? get sortDate => lastMessageAt ?? createdAt;

  static InquiryModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) return null;
      return InquiryModel.fromJson(json);
    } catch (error) {
      Logger.error('InquiryModel.fromJson: $error');
      return null;
    }
  }

  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
      id: json['id'].toString(),
      subject: json['subject'] ?? '',
      category: json['category'] ?? 'general',
      status: InquiryStatusX.fromJson(json['status']),
      unreadByUser: json['unreadByUser'] == true,
      lastMessageAt: DateTime.tryParse(json['lastMessageAt']?.toString() ?? ''),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
    );
  }

  InquiryModel copyWith({bool? unreadByUser, DateTime? lastMessageAt}) {
    return InquiryModel(
      id: id,
      subject: subject,
      category: category,
      status: status,
      unreadByUser: unreadByUser ?? this.unreadByUser,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      createdAt: createdAt,
    );
  }
}
