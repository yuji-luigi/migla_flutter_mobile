import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/payment_record/graphql/payment_record_detail_query.dart';
import 'package:migla_flutter/src/models/api/payment_record/payment_record_model.dart';
import 'package:migla_flutter/src/models/api/notification/notification_query.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/providers/my_graphql_provider.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';

class PaymentRecordDetailScreen extends StatefulWidget {
  final int scheduleId;

  const PaymentRecordDetailScreen({
    super.key,
    required this.scheduleId,
  });

  @override
  State<PaymentRecordDetailScreen> createState() =>
      _PaymentRecordDetailScreenState();
}

class _PaymentRecordDetailScreenState extends State<PaymentRecordDetailScreen>
    with RouteAwareRefetchMixin {
  final ApiClient _apiClient = ApiClientImpl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markViewedAndRefreshNotifications();
  }

  Future<void> _markViewedAndRefreshNotifications() async {
    try {
      await _apiClient.post(apiUrlNotificationByCollectionAndRecordId, body: {
        'collection': 'payment-schedules',
        'recordId': widget.scheduleId,
      });
    } catch (e) {
      Logger.error(e.toString());
    }
    if (!mounted) return;
    final GraphQLClient gqlClient = getGqlClient(context);
    final String localeCode =
        $settingsController(context, listen: false).locale.languageCode;
    try {
      await gqlClient.query(
        QueryOptions(
          document: gql(notificationListQuery),
          variables: {'locale': localeCode},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );
    } catch (e) {
      Logger.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final MeViewModel meVM = $meViewModel(context, listen: false);
    if (meVM.me == null || meVM.me?.id == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.paymentDetails,
      showStudentName: false,
      body: Query(
        options: QueryOptions(
          document: gql(getPaymentRecordByScheduleIdAndPayerIdQuery),
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          cacheRereadPolicy: CacheRereadPolicy
              .ignoreAll, // NOTE: ← crucial: disables the problematic re-read/merge I don't know why I need set this.
          variables: {
            'payerId': meVM.me!.id,
            'scheduleId': widget.scheduleId,
          },
        ),
        builder: (result, {fetchMore, refetch}) {
          // Store the refetch function for later use
          // setRefetchFunction(refetch);

          if (result.hasException) {
            Logger.error(result.exception.toString());
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

          if (result.data?['PaymentRecords']['docs'].isEmpty) {
            return Center(
              child: Text(
                context.t.noPaymentRecordFound,
                style: textStyleBodyMedium,
              ),
            );
          }
          final paymentRecord = PaymentRecordModel.tryFromJson(
              result.data?['PaymentRecords']['docs'][0]);
          if (paymentRecord == null) {
            return Center(
              child: Text(
                context.t.noPaymentRecordFound,
                style: textStyleBodyMedium,
              ),
            );
          }
          return SelectionArea(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (paymentRecord.paymentSchedule != null)
                  _buildScheduleCard(context, paymentRecord),
                  // Payment Status Card
                  // _buildStatusCard(context, paymentRecord),

                  // Payment Details
                  // _buildPaymentDetailsCard(context, paymentRecord),

                  // Purchases List
                  // if (paymentRecord.purchases.isNotEmpty)
                  //   _buildPurchasesCard(context, paymentRecord.purchases),
                  const SizedBox(height: 100),
                ],
              ),
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
      BuildContext context, PaymentRecordModel paymentRecord) {
    // return SizedBox(
    //   width: double.infinity,
    //   child: Card(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         children: [Text('j')],
    //       ),
    //     ),
    //   ),
    // );
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                paymentRecord.paymentSchedule.notificationTitle,
                style: textStyleHeadingSmall,
              ),
              SizedBox(height: 18),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: paymentRecord.paymentSchedule.notificationBody,
                      style: textStyleBodyMedium,
                    ),
                    const TextSpan(text: '\n\n'),
                  ],
                ),
              ),
              _buildPaymentDetailsCard(context, paymentRecord),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    // 3. Alert message (red bold)
                    if (paymentRecord
                            .paymentSchedule.notificationAlertMessage !=
                        null) ...[
                      TextSpan(
                        text: paymentRecord
                            .paymentSchedule.notificationAlertMessage!,
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
                      text: formatDateTime(
                          paymentRecord.paymentSchedule.paymentDue,
                          localeCode:
                              $settingsController(context).locale.languageCode),
                      style: textStyleBodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard(
    BuildContext context,
    PaymentRecordModel paymentRecord,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.paymentDetails,
          style: textStyleHeadingSmall,
        ),
        const SizedBox(height: 12),
        _buildPriceRow(
            context: context,
            quantity: paymentRecord.studentCount,
            price: paymentRecord.tuitionFee,
            name: context.t.tuitionFee,
            description: paymentRecord.tuitionFeeDescription),
        _buildPriceRow(
            context: context,
            quantity: paymentRecord.studentCount,
            price: paymentRecord.materialFee,
            name: context.t.materialFee,
            description: paymentRecord.materialFeeDescription),
        const SizedBox(height: 12),
        if (paymentRecord.purchases.isNotEmpty) ...[
          Text(
            context.t.purchases,
            style: textStyleHeadingSmall,
          ),
          const SizedBox(height: 12),
          ...paymentRecord.purchases.map((purchase) => _buildPriceRow(
                context: context,
                price: purchase.productAndQuantity.product.price,
                name: purchase.productAndQuantity.product.name,
                quantity: purchase.productAndQuantity.quantity,
              )),
        ],
        Divider(),
        Row(
          children: [
            Spacer(),
            Text(
              '${context.t.totalAmount}: ${paymentRecord.totalString}',
              style: textStyleBodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildPurchasesCard(
  //     BuildContext context, List<PurchaseModel> purchases) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             context.t.purchases,
  //             style: textStyleHeadingSmall,
  //           ),
  //           const SizedBox(height: 12),
  //           ...purchases
  //               .map((purchase) => _buildPurchaseItem(context, purchase)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildPurchaseItem(BuildContext context, PurchaseModel purchase) {
  //   final product = purchase.productAndQuantity.product;
  //   final quantity = purchase.productAndQuantity.quantity;
  //   final String totalString =
  //       '€${(purchase.productAndQuantity.quantity * product.price).toStringAsFixed(2)}';
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             '${product.name} (€${product.price.toStringAsFixed(2)})',
  //             style: textStyleBodyMedium,
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             '${context.t.quantity}: $quantity',
  //             style: textStyleBodySmall,
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             totalString,
  //             style: textStyleBodyMedium.copyWith(
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPriceRow({
    required BuildContext context,
    required double price,
    required int quantity,
    required String name,
    String? description,
  }) {
    final String totalString = '€${(quantity * price).toStringAsFixed(2)}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name (€${price.toStringAsFixed(2)})',
                  style:
                      textStyleBodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                if (description != null && description.isNotEmpty)
                  Text(
                    description,
                    style: textStyleBodySmall,
                  ),
              ],
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
              totalString,
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
