const String getPaymentRecordByIdQuery = r'''
query PaymentRecord($id: Int!) {
  PaymentRecord(id: $id) {
    id
    paymentSchedule {
      notificationTitle
      notificationAlertMessage
      notificationBody
      paymentDue
      createdAt
    }
    tuitionFeeDescription
    tuitionFeeTotalAndSingle
    totalString
    studentCount
    materialFee
    materialFeeTotalAndSingle
    materialFeeDescription
    paid
    purchases {
      productAndQuantity {
        quantity
        product {
          name
          price
        }
      }
    }
  }
}
''';
