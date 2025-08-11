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

const String getPaymentRecordByScheduleIdAndPayerIdWithReadNotification = r'''
query GetMyPaymentRecordWithReadNotification(
  $scheduleId: JSON!, 
  $payerId: JSON!,
  $userId: Int,
  $notificationId: Int
) {
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
  
  # Create read notification if both userId and notificationId are provided
  createReadNotification(
    data: {
      user: $userId
      notification: $notificationId
    }
  ) @include(if: $userId) @include(if: $notificationId) {
    id
  }
}
''';
