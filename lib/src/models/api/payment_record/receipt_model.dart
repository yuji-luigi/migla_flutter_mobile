import 'package:migla_flutter/src/models/internal/logger.dart';

/// Minimal billing profile info embedded in a payment record's receipt group.
class ReceiptBillingProfileRef {
  final String id;
  final String? label;
  final String? holderName;
  final String? bankAccountHolder;

  ReceiptBillingProfileRef({
    required this.id,
    this.label,
    this.holderName,
    this.bankAccountHolder,
  });

  /// Accepts either a populated object
  /// `{id,label,holderName,bankAccountHolder}` or a bare id.
  static ReceiptBillingProfileRef? tryParse(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      if (value['id'] == null) return null;
      return ReceiptBillingProfileRef(
        id: value['id'].toString(),
        label: value['label'],
        holderName: value['holderName'],
        bankAccountHolder: value['bankAccountHolder'],
      );
    }
    return ReceiptBillingProfileRef(id: value.toString());
  }
}

/// The `receipt` group of a payment record: whether the parent asked for a
/// receipt (領収書 / ricevuta, +2€ marca da bollo) and whether the school
/// verified the bollo. MIGLA is a non-profit, so it issues a receipt, not a
/// fattura.
class ReceiptModel {
  final bool requested;
  final bool bolloVerified;
  final String? confirmationCode;
  final DateTime? requestedAt;
  final ReceiptBillingProfileRef? billingProfile;

  const ReceiptModel({
    this.requested = false,
    this.bolloVerified = false,
    this.confirmationCode,
    this.requestedAt,
    this.billingProfile,
  });

  static const ReceiptModel empty = ReceiptModel();

  factory ReceiptModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty;
    try {
      return ReceiptModel(
        requested: json['requested'] == true,
        bolloVerified: json['bolloVerified'] == true,
        confirmationCode:
            (json['confirmationCode'] as String?)?.isNotEmpty == true
                ? json['confirmationCode']
                : null,
        requestedAt: json['requestedAt'] != null
            ? DateTime.tryParse(json['requestedAt'].toString())
            : null,
        billingProfile:
            ReceiptBillingProfileRef.tryParse(json['billingProfile']),
      );
    } catch (error) {
      Logger.error('ReceiptModel.fromJson: $error');
      return empty;
    }
  }

  /// Keeps the populated billing profile info from [previous] when the API
  /// only returned the id.
  ReceiptModel mergeProfileFrom(ReceiptModel previous) {
    final ref = billingProfile;
    final prev = previous.billingProfile;
    if (ref != null && prev != null && ref.id == prev.id && ref.label == null) {
      return ReceiptModel(
        requested: requested,
        bolloVerified: bolloVerified,
        confirmationCode: confirmationCode,
        requestedAt: requestedAt,
        billingProfile: prev,
      );
    }
    return this;
  }
}
