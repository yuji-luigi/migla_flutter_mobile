// const String getPaymentRecordByIdQuery = r'''
// query PaymentRecord($id: Int!) {
//   PaymentRecord(id: $id) {
//     id
//     paymentSchedule {
//       notificationTitle
//       notificationAlertMessage
//       notificationBody
//       paymentDue
//       createdAt
//     }
//     tuitionFeeDescription
//     tuitionFeeTotalAndSingle
//     totalString
//     studentCount
//     materialFee
//     materialFeeTotalAndSingle
//     materialFeeDescription
//     paid
//     purchases {;
//       productAndQuantity {
//         quantity
//         product {
//           name
//           price
//           priceString
//         }
//       }
//     }
//   }
// }
// ''';

const String getPaymentRecordByScheduleIdAndPayerIdQuery = r'''
query GetMyPaymentRecord($scheduleId: JSON!, $payerId: JSON!) {
  PaymentRecords(where:{
    payer:{equals: $payerId}
    paymentSchedule: {equals: $scheduleId}
  }) {
    docs {
       id
    paymentSchedule {
      notificationTitle
      notificationAlertMessage
      notificationBody
      paymentDue
      createdAt
    }
    tuitionFee
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
}
''';
