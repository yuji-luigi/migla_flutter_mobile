class PaymentRecordSummaryModel {
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
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      return null;
    }
  }

  factory PaymentRecordSummaryModel.fromJson(Map<String, dynamic> json) {
    print(json);
    try {
      return PaymentRecordSummaryModel(
        id: json['id'],
        paymentSchedule: PaymentScheduleModel.fromJson(json['paymentSchedule']),
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
  final int id;
  final String notificationTitle;
  final DateTime paymentDue;
  final String notificationScheduledAt;
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
      notificationScheduledAt: json['notificationScheduledAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}

// class PaymentRecordSummary {
//   final List<PaymentRecordModel> docs;

//   PaymentRecordSummary({
//     required this.docs,
//   });

//   static PaymentRecordSummary? tryFromJson(Map<String, dynamic>? json) {
//     try {
//       if (json == null) {
//         return null;
//       }
//       return PaymentRecordSummary.fromJson(json);
//     } catch (error, stackTrace) {
//       print(error.toString());
//       print(stackTrace.toString());
//       return null;
//     }
//   }

//   factory PaymentRecordSummary.fromJson(Map<String, dynamic> json) {
//     print(json);
//     try {
//       final docsList = json['docs'] as List<dynamic>? ?? [];
//       return PaymentRecordSummary(
//         docs: docsList.map((doc) => PaymentRecordModel.fromJson(doc)).toList(),
//       );
//     } catch (error, stackTrace) {
//       print(json);
//       print(error.toString());
//       print(stackTrace.toString());
//       rethrow;
//     }
//   }
// }
