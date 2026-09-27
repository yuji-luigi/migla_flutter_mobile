import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/payment_record/payment_record_summary_model.dart';
import 'package:migla_flutter/src/screens/dashboard/payment_record_screens/payment_record_detail_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';

class PaymentRecordListCard extends StatelessWidget {
  const PaymentRecordListCard(
      {super.key, required this.title, required this.paymentRecord});
  final String title;
  final PaymentRecordSummaryModel paymentRecord;

  @override
  Widget build(BuildContext context) {
    bool paid = paymentRecord.paid;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentRecordDetailScreen(
              scheduleId: paymentRecord.paymentSchedule.id,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textStyleBodyMedium,
                ),
              ),
              if (paymentRecord.receipt.requested) ...[
                const SizedBox(width: 8),
                _ReceiptBadge(verified: paymentRecord.receipt.bolloVerified),
              ],
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.t.dueDate}: ${formatDateTime(paymentRecord.paymentSchedule.paymentDue, localeCode: $settingsController(context).locale.languageCode)}',
                style: textStyleBodySmall,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '${context.t.paidCondition}: '),
                    TextSpan(
                        text:
                            paid ? context.t.completed : context.t.notCompleted,
                        style: TextStyle(
                            color: paid ? colorSuccess : colorError,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                style: textStyleBodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptBadge extends StatelessWidget {
  final bool verified;
  const _ReceiptBadge({required this.verified});

  @override
  Widget build(BuildContext context) {
    final Color color = verified ? colorSuccess : colorSecondaryDark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(900),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            context.t.receiptBadge,
            style: textStyleCaptionMd.copyWith(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
