import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_model.dart';
import 'package:migla_flutter/src/screens/dashboard/inquiry_screens/inquiry_form_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/inquiry_screens/inquiry_thread_screen.dart';
import 'package:migla_flutter/src/services/push_navigation_service.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/inquiries_view_model.dart';
import 'package:migla_flutter/src/views/inquiry/inquiry_labels.dart';
import 'package:nb_utils/nb_utils.dart';

/// お問い合わせ: the logged-in user's threads with the school.
class InquiryListScreen extends StatefulWidget {
  const InquiryListScreen({super.key});

  @override
  State<InquiryListScreen> createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends State<InquiryListScreen> {
  StreamSubscription<RemoteMessage>? _pushSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      $inquiriesViewModel(context, listen: false).fetchInquiries();
    });
    _pushSub = PushNavigationService.foregroundMessages.listen((message) {
      if (PushNavigationService.inquiryIdFrom(message.data) != null &&
          mounted) {
        $inquiriesViewModel(context, listen: false).fetchInquiries();
      }
    });
  }

  @override
  void dispose() {
    _pushSub?.cancel();
    super.dispose();
  }

  Future<void> _openNew() async {
    final String? newId = await const InquiryFormScreen().launch(context);
    if (!mounted) return;
    final vm = $inquiriesViewModel(context, listen: false);
    await vm.fetchInquiries();
    if (newId != null && mounted) {
      await InquiryThreadScreen(inquiryId: newId, inquiry: vm.findById(newId))
          .launch(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = $inquiriesViewModel(context);
    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.inquiries,
      showStudentName: false,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'inquiry-new',
        backgroundColor: actionPrimaryColor,
        foregroundColor: textColorWhite,
        onPressed: _openNew,
        icon: const Icon(Icons.edit_outlined),
        label: Text(context.t.inquiryNew),
      ),
      body: _body(context, vm),
    );
  }

  Widget _body(BuildContext context, InquiriesViewModel vm) {
    if (vm.isLoading && !vm.hasLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.errorMessage != null && vm.inquiries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.t.error_somethingWentWrong,
                style: textStyleBodyMedium),
            TextButton(
                onPressed: vm.fetchInquiries, child: Text(context.t.retry)),
          ],
        ),
      );
    }
    final String localeCode = $settingsController(context).locale.languageCode;
    return RefreshIndicator(
      onRefresh: vm.fetchInquiries,
      child: vm.inquiries.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(paddingXDashboardMd),
              children: [
                const SizedBox(height: 48),
                Icon(Icons.forum_outlined, size: 64, color: colorPrimaryDark),
                const SizedBox(height: 16),
                Text(context.t.inquiryEmptyTitle,
                    textAlign: TextAlign.center, style: textStyleHeadingSmall),
                const SizedBox(height: 12),
                Text(context.t.inquiryEmptyDesc,
                    textAlign: TextAlign.center, style: textStyleBodyMedium),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                  paddingXDashboardMd, 16, paddingXDashboardMd, 120),
              itemCount: vm.inquiries.length,
              itemBuilder: (context, index) {
                final inquiry = vm.inquiries[index];
                return _InquiryCard(
                  inquiry: inquiry,
                  localeCode: localeCode,
                  onTap: () => InquiryThreadScreen(
                    inquiryId: inquiry.id,
                    inquiry: inquiry,
                  ).launch(context),
                );
              },
            ),
    );
  }
}

class _InquiryCard extends StatelessWidget {
  final InquiryModel inquiry;
  final String localeCode;
  final VoidCallback onTap;
  const _InquiryCard({
    required this.inquiry,
    required this.localeCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: inquiry.unreadByUser ? colorError : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
        minLeadingWidth: 10,
        title: Text(
          inquiry.subject,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textStyleBodyMedium.copyWith(
            fontWeight:
                inquiry.unreadByUser ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              InquiryStatusChip(status: inquiry.status),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  inquiryCategoryLabel(context, inquiry.category),
                  style: textStyleBodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        trailing: Text(
          formatInquiryTime(inquiry.sortDate, localeCode),
          style: textStyleBodySmall.copyWith(color: colorTextDisabled),
        ),
      ),
    );
  }
}
