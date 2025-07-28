class PaymentRecordModel {
  final int id;
  final PaymentScheduleModel? paymentSchedule;
  final bool paid;

  PaymentRecordModel({
    required this.id,
    this.paymentSchedule,
    required this.paid,
  });

  static PaymentRecordModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return PaymentRecordModel.fromJson(json);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  factory PaymentRecordModel.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      return PaymentRecordModel(
        id: json['id'],
        paymentSchedule: json['paymentSchedule'] != null
            ? PaymentScheduleModel.fromJson(json['paymentSchedule'])
            : null,
        paid: json['paid'] ?? false,
      );
    } catch (error, stackTrace) {
      print(json);
      print(error.toString());
      print(stackTrace.toString());
      rethrow;
    }
  }
}

class PaymentScheduleModel {
  final String notificationTitle;
  final String paymentDue;
  final String notificationScheduledAt;
  final String createdAt;

  PaymentScheduleModel({
    required this.notificationTitle,
    required this.paymentDue,
    required this.notificationScheduledAt,
    required this.createdAt,
  });

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleModel(
      notificationTitle: json['notificationTitle'] ?? '',
      paymentDue: json['paymentDue'] ?? '',
      notificationScheduledAt: json['notificationScheduledAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class PaymentRecordSummary {
  final List<PaymentRecordModel> docs;

  PaymentRecordSummary({
    required this.docs,
  });

  static PaymentRecordSummary? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        return null;
      }
      return PaymentRecordSummary.fromJson(json);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  factory PaymentRecordSummary.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      final docsList = json['docs'] as List<dynamic>? ?? [];
      return PaymentRecordSummary(
        docs: docsList.map((doc) => PaymentRecordModel.fromJson(doc)).toList(),
      );
    } catch (error, stackTrace) {
      print(json);
      print(error.toString());
      print(stackTrace.toString());
      rethrow;
    }
  }
}
