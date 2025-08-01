import 'package:migla_flutter/src/models/api/product_model.dart';

class PaymentRecordModel {
  final int id;
  final PaymentScheduleDetailModel paymentSchedule;
  final String tuitionFeeDescription;
  final String tuitionFeeTotalAndSingle;
  final String totalString;
  final int studentCount;
  final double materialFee;
  final double tuitionFee;
  final String materialFeeTotalAndSingle;
  final String materialFeeDescription;
  final bool paid;
  final List<PurchaseModel> purchases;

  PaymentRecordModel({
    required this.id,
    required this.paymentSchedule,
    required this.tuitionFeeDescription,
    required this.tuitionFeeTotalAndSingle,
    required this.totalString,
    required this.studentCount,
    required this.materialFee,
    required this.tuitionFee,
    required this.materialFeeTotalAndSingle,
    required this.materialFeeDescription,
    required this.paid,
    required this.purchases,
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
    try {
      return PaymentRecordModel(
        id: json['id'],
        paymentSchedule:
            PaymentScheduleDetailModel.fromJson(json['paymentSchedule']),
        tuitionFeeDescription: json['tuitionFeeDescription'],
        tuitionFeeTotalAndSingle: json['tuitionFeeTotalAndSingle'] ?? '',
        totalString: json['totalString'],
        studentCount: json['studentCount'],
        materialFee: json['materialFee']?.toDouble() ?? 0,
        tuitionFee: json['tuitionFee']?.toDouble() ?? 0,
        materialFeeTotalAndSingle: json['materialFeeTotalAndSingle'] ?? '',
        materialFeeDescription: json['materialFeeDescription'],
        paid: json['paid'] ?? false,
        purchases: (json['purchases'] as List<dynamic>? ?? [])
            .map((purchase) => PurchaseModel.fromJson(purchase))
            .toList(),
      );
    } catch (error, stackTrace) {
      print(json);
      print(error.toString());
      print(stackTrace.toString());
      rethrow;
    }
  }
}

class PaymentScheduleDetailModel {
  final String notificationTitle;
  final String? notificationAlertMessage;
  final String notificationBody;
  final DateTime paymentDue;
  final String createdAt;

  PaymentScheduleDetailModel({
    required this.notificationTitle,
    this.notificationAlertMessage,
    required this.notificationBody,
    required this.paymentDue,
    required this.createdAt,
  });

  factory PaymentScheduleDetailModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleDetailModel(
      notificationTitle: json['notificationTitle'] ?? '',
      notificationAlertMessage: json['notificationAlertMessage'],
      notificationBody: json['notificationBody'],
      paymentDue: DateTime.parse(json['paymentDue']),
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class PurchaseModel {
  final ProductAndQuantityModel productAndQuantity;

  PurchaseModel({
    required this.productAndQuantity,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      productAndQuantity:
          ProductAndQuantityModel.fromJson(json['productAndQuantity']),
    );
  }
}

class ProductAndQuantityModel {
  final int quantity;
  final ProductModel product;
  ProductAndQuantityModel({
    required this.quantity,
    required this.product,
  });

  factory ProductAndQuantityModel.fromJson(Map<String, dynamic> json) {
    return ProductAndQuantityModel(
      quantity: json['quantity'] ?? 0,
      product: ProductModel.fromJson(json['product']),
    );
  }
}
