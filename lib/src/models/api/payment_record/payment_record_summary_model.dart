import 'package:migla_flutter/src/models/api/api_model_abstract.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';

class PaymentRecordSummaryModel extends ApiModel {
  final int id;
  final PaymentScheduleModel paymentSchedule;
  final bool paid;

  PaymentRecordSummaryModel({
    required this.id,
    required this.paymentSchedule,
    required this.paid,
  });

  static PaymentRecordSummaryModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return PaymentRecordSummaryModel.fromJson(json);
    } catch (error) {
      Logger.error(error.toString());
      return null;
    }
  }

  factory PaymentRecordSummaryModel.fromJson(Map<String, dynamic> json) {
    try {
      return PaymentRecordSummaryModel(
        id: json['id'],
        paymentSchedule: PaymentScheduleModel.fromJson(json['paymentSchedule']),
        paid: json['paid'] ?? false,
      );
    } catch (error) {
      Logger.error(json.toString());
      Logger.error(error.toString());
      rethrow;
    }
  }
}

class PaymentScheduleModel {
  final int id;
  final String notificationTitle;
  final DateTime paymentDue;
  final DateTime notificationScheduledAt;
  final String createdAt;

  PaymentScheduleModel({
    required this.id,
    required this.notificationTitle,
    required this.paymentDue,
    required this.notificationScheduledAt,
    required this.createdAt,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleModel(
      id: json['id'],
      notificationTitle: json['notificationTitle'] ?? '',
      paymentDue: DateTime.parse(json['paymentDue']),
      notificationScheduledAt: DateTime.parse(json['notificationScheduledAt']),
      createdAt: json['createdAt'] ?? '',
    );
  }
}
