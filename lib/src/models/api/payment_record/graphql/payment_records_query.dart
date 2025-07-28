const String getPaymentRecordsByPayerQuery = r'''
query PaymentRecordsByPayer($payerId: JSON) {
  PaymentRecords(where: {
    payer: {equals: $payerId}
  }) {
    docs {
      id
      paymentSchedule {
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
