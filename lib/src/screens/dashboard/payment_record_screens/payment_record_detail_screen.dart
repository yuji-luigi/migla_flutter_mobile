import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/payment_record/graphql/payment_record_detail_query.dart';
import 'package:migla_flutter/src/models/api/payment_record/payment_record_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';

class PaymentRecordDetailScreen extends StatefulWidget {
  final int id;

  const PaymentRecordDetailScreen({super.key, required this.id});

  @override
  State<PaymentRecordDetailScreen> createState() =>
      _PaymentRecordDetailScreenState();
}

class _PaymentRecordDetailScreenState extends State<PaymentRecordDetailScreen>
    with RouteAwareRefetchMixin {
  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.paymentDetails,
      body: Query(
        options: QueryOptions(
          document: gql(getPaymentRecordByIdQuery),
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          variables: {
            'id': widget.id,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          // Store the refetch function for later use
          setRefetchFunction(refetch);

          if (result.hasException) {
            return Center(
              child: Text(
                result.exception?.graphqlErrors.toString() ?? 'Error occurred',
                style: textStyleBodyMedium,
              ),
            );
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final paymentRecord =
              PaymentRecordModel.tryFromJson(result.data?['PaymentRecord']);

          if (paymentRecord == null) {
            return Center(
              child: Text(
                context.t.noPaymentRecordFound,
                style: textStyleBodyMedium,
              ),
            );
          }

          return SingleChildScrollView(
            // padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (paymentRecord.paymentSchedule != null)
                  _buildScheduleCard(context, paymentRecord.paymentSchedule!),
                // Payment Status Card
                _buildStatusCard(context, paymentRecord),

                // Payment Details
                _buildPaymentDetailsCard(context, paymentRecord),

                // Purchases List
                if (paymentRecord.purchases.isNotEmpty)
                  _buildPurchasesCard(context, paymentRecord.purchases),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard(
      BuildContext context, PaymentRecordModel paymentRecord) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  paymentRecord.paid ? Icons.check_circle : Icons.pending,
                  color: paymentRecord.paid ? colorSuccess : colorError,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  paymentRecord.paid
                      ? context.t.paymentCompleted
                      : context.t.paymentPending,
                  style: textStyleHeadingSmall.copyWith(
                    color: paymentRecord.paid ? colorSuccess : colorError,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ...[
              const SizedBox(height: 8),
              Text(
                '${context.t.totalAmount}: ${paymentRecord.totalString}',
                style: textStyleBodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(
      BuildContext context, PaymentScheduleDetailModel schedule) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schedule.notificationTitle,
              style: textStyleHeadingSmall,
            ),
            SizedBox(
              width: double.infinity,
              child: Text.rich(
                TextSpan(
                  children: [
                    // 2. Body (normal style)
                    if (schedule.notificationBody != null) ...[
                      TextSpan(
                        text: schedule.notificationBody!,
                        style: textStyleBodyMedium,
                      ),
                      const TextSpan(text: '\n\n'),
                    ],

                    // 3. Alert message (red bold)
                    if (schedule.notificationAlertMessage != null) ...[
                      TextSpan(
                        text: schedule.notificationAlertMessage!,
                        style: textStyleBodyMedium.copyWith(
                          color: colorError,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: '\n\n'),
                    ],

                    // 4. Due date (bold)
                    TextSpan(
                      text: '${context.t.dueDate}: ',
                      style: textStyleBodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: formatDateTime(schedule.paymentDue),
                      style: textStyleBodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard(
      BuildContext context, PaymentRecordModel paymentRecord) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.paymentDetails,
              style: textStyleHeadingSmall,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
                context.t.studentCount, paymentRecord.studentCount.toString()),
            _buildInfoRow(context.t.tuitionFee,
                '${paymentRecord.tuitionFeeTotalAndSingle} (${paymentRecord.tuitionFeeDescription})'),
            _buildInfoRow(context.t.materialFee,
                '${paymentRecord.materialFeeTotalAndSingle} (${paymentRecord.materialFeeDescription})'),
            _buildInfoRow(context.t.materialFeeDescription,
                paymentRecord.materialFeeDescription),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchasesCard(
      BuildContext context, List<PurchaseModel> purchases) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.t.purchases,
              style: textStyleHeadingSmall,
            ),
            const SizedBox(height: 12),
            ...purchases
                .map((purchase) => _buildPurchaseItem(context, purchase)),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseItem(BuildContext context, PurchaseModel purchase) {
    final product = purchase.productAndQuantity.product;
    final quantity = purchase.productAndQuantity.quantity;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              product.name,
              style: textStyleBodyMedium,
            ),
          ),
          Expanded(
            child: Text(
              '${context.t.quantity}: $quantity',
              style: textStyleBodySmall,
            ),
          ),
          Expanded(
            child: Text(
              '¥${product.price.toStringAsFixed(2)}',
              style: textStyleBodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: textStyleBodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: textStyleBodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
