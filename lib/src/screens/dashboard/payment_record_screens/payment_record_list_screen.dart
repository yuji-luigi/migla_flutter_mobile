import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/payment_record/graphql/payment_records_query.dart';
import 'package:migla_flutter/src/models/api/payment_record/payment_record_summary_model.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/views/payment_record_list/payment_record_list_card.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/graphql/graphql_list_view_general.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen>
    with RouteAwareRefetchMixin {
  List<PaymentRecordSummaryModel> _paymentRecords = [];
  @override
  Widget build(BuildContext context) {
    final meViewModel = $meViewModel(context);

    // Check if user is loaded
    if (!meViewModel.hasMe) {
      return RegularLayoutScaffold(
        padding: EdgeInsets.zero,
        bodyColor: colorTertiary,
        title: context.t.navPayment,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    DateTime now = DateTime.now();
    return RegularLayoutScaffold(
        padding: EdgeInsets.zero,
        bodyColor: colorTertiary,
        title: context.t.navPayment,
        showStudentName: false,
        body: GraphqlListViewGeneral<PaymentRecordSummaryModel>(
          options: QueryOptions(
            document: gql(getPaymentRecordsByPayerQuery),
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            variables: {
              'payerId': meViewModel.me!.id,
            },
            onComplete: (result) {
              final List<PaymentRecordSummaryModel> paymentRecords =
                  result?['PaymentRecords']['docs']
                          .map<PaymentRecordSummaryModel>((paymentRecord) =>
                              PaymentRecordSummaryModel.fromJson(paymentRecord))
                          .toList() ??
                      [];
              setState(() {
                _paymentRecords = paymentRecords;
              });
            },
          ),
          fromJson: PaymentRecordSummaryModel.fromJson,
          dataKey: 'PaymentRecords',
          items: _paymentRecords,
          itemCount: _paymentRecords.length,
          itemBuilder: (context, index, items) {
            return Container(
              padding: EdgeInsets.only(
                top: index == 0 ? 16 : 0,
                left: paddingXDashboardMd,
                right: paddingXDashboardMd,
              ),
              child: PaymentRecordListCard(
                title: items[index].paymentSchedule.notificationTitle,
                paymentRecord: items[index],
              ),
            );
          },
        ));
  }
}
