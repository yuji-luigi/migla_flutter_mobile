const String getPaymentRecordsByPayerQuery = r'''
query PaymentRecordsByPayer($payerId: JSON) {
  PaymentRecords(where: {
    payer: {equals: $payerId}
  }) {
    docs {
      id
      paymentSchedule {
        id
        notificationTitle
        paymentDue
        createdAt
      }
      paid
      receipt {
        requested
        bolloVerified
        confirmationCode
        requestedAt
        billingProfile {
          id
          label
          holderName
          bankAccountHolder
        }
      }
    }
  }
}
''';
