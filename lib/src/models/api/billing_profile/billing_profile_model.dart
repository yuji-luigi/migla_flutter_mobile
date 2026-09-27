import 'package:migla_flutter/src/models/internal/logger.dart';

enum BillingProfileType { individual, company }

extension BillingProfileTypeX on BillingProfileType {
  static BillingProfileType fromJson(dynamic value) => value == 'company'
      ? BillingProfileType.company
      : BillingProfileType.individual;
}

/// Converts an id coming from Payload (int for Postgres, string otherwise)
/// into the value to send back in a relationship field.
dynamic idForApi(String id) => int.tryParse(id) ?? id;

class BillingAddressModel {
  final String street;
  final String postalCode;
  final String city;
  final String province;
  final String country;

  const BillingAddressModel({
    this.street = '',
    this.postalCode = '',
    this.city = '',
    this.province = '',
    this.country = 'IT',
  });

  factory BillingAddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BillingAddressModel();
    return BillingAddressModel(
      street: json['street'] ?? '',
      postalCode: json['postalCode']?.toString() ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
      country: (json['country'] as String?)?.isNotEmpty == true
          ? json['country']
          : 'IT',
    );
  }
}

/// A receipt addressee (領収書の宛名 / Dati per la ricevuta) of the logged-in
/// user, from the `billing-profiles` collection.
///
/// MIGLA is a non-profit: it issues a receipt (ricevuta + marca da bollo), not
/// a fattura, so only [label], [holderName], [bankAccountHolder], [notes] and
/// [isDefault] are used. The backend still has the fattura-oriented fields
/// (type, codice fiscale, partita IVA, SDI, PEC, address) for a possible
/// for-profit fork; they are parsed here as optional/read-only and never sent.
class BillingProfileModel {
  final String id;
  final String label;

  /// Name printed on the receipt.
  final String holderName;

  /// Name of the bank account the transfers come from (may differ from the
  /// app user, e.g. a spouse's account). Used by the school to match payments.
  final String bankAccountHolder;
  final String? notes;
  final bool isDefault;

  // Legacy fattura fields, unused by MIGLA (read-only, never sent).
  final BillingProfileType type;
  final String? codiceFiscale;
  final String? partitaIva;
  final String? sdiCode;
  final String? pec;
  final BillingAddressModel address;

  BillingProfileModel({
    required this.id,
    required this.label,
    required this.holderName,
    this.bankAccountHolder = '',
    this.notes,
    this.isDefault = false,
    this.type = BillingProfileType.individual,
    this.codiceFiscale,
    this.partitaIva,
    this.sdiCode,
    this.pec,
    this.address = const BillingAddressModel(),
  });

  static BillingProfileModel? tryFromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) return null;
      return BillingProfileModel.fromJson(json);
    } catch (error) {
      Logger.error(error.toString());
      return null;
    }
  }

  factory BillingProfileModel.fromJson(Map<String, dynamic> json) {
    return BillingProfileModel(
      id: json['id'].toString(),
      label: json['label'] ?? '',
      holderName: json['holderName'] ?? '',
      bankAccountHolder: json['bankAccountHolder'] ?? '',
      notes: json['notes'],
      isDefault: json['isDefault'] == true,
      type: BillingProfileTypeX.fromJson(json['type']),
      codiceFiscale: json['codiceFiscale'],
      partitaIva: json['partitaIva']?.toString(),
      sdiCode: json['sdiCode'],
      pec: json['pec'],
      address: BillingAddressModel.fromJson(
          json['address'] is Map<String, dynamic> ? json['address'] : null),
    );
  }
}
