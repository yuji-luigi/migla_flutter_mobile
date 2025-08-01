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
        notificationScheduledAt
        createdAt
      }
      paid
    }
  }
}
''';
