import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

String inquiryCategoryLabel(BuildContext context, String category) {
  switch (category) {
    case 'admission':
      return context.t.inquiryCategoryAdmission;
    case 'payment':
      return context.t.inquiryCategoryPayment;
    case 'app':
      return context.t.inquiryCategoryApp;
    case 'other':
      return context.t.inquiryCategoryOther;
    case 'general':
    default:
      return context.t.inquiryCategoryGeneral;
  }
}

String inquiryStatusLabel(BuildContext context, InquiryStatus status) {
  switch (status) {
    case InquiryStatus.newStatus:
      return context.t.inquiryStatusNew;
    case InquiryStatus.open:
      return context.t.inquiryStatusOpen;
    case InquiryStatus.answered:
      return context.t.inquiryStatusAnswered;
    case InquiryStatus.closed:
      return context.t.inquiryStatusClosed;
  }
}

Color inquiryStatusColor(InquiryStatus status) {
  switch (status) {
    case InquiryStatus.newStatus:
      return colorPrimaryDark;
    case InquiryStatus.open:
      return colorSecondaryDark;
    case InquiryStatus.answered:
      return colorSuccess;
    case InquiryStatus.closed:
      return colorTextDisabled;
  }
}

class InquiryStatusChip extends StatelessWidget {
  final InquiryStatus status;
  const InquiryStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = inquiryStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(900),
      ),
      child: Text(
        inquiryStatusLabel(context, status),
        style: textStyleCaptionMd.copyWith(color: color, fontSize: 11),
      ),
    );
  }
}

/// Short date/time for list rows and bubbles: time for today, date otherwise.
String formatInquiryTime(DateTime? dateTime, String localeCode) {
  if (dateTime == null) return '';
  final local = dateTime.toLocal();
  final now = DateTime.now();
  final bool sameDay = local.year == now.year &&
      local.month == now.month &&
      local.day == now.day;
  if (sameDay) return DateFormat.Hm(localeCode).format(local);
  if (local.year == now.year) {
    return DateFormat.MMMd(localeCode).add_Hm().format(local);
  }
  return DateFormat.yMMMd(localeCode).format(local);
}
