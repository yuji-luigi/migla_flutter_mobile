import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/billing_profile/billing_profile_model.dart';
import 'package:migla_flutter/src/models/api/payment_record/receipt_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/dashboard/billing_profile_screens/billing_profile_list_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/view_models/billing_profiles_view_model.dart';
import 'package:nb_utils/nb_utils.dart';

/// 領収書 / ricevuta card on the payment record detail screen.
///
/// The parent can only toggle the request; the school verifies the +2€ marca
/// da bollo on the bank statement (`bolloVerified`).
class ReceiptCard extends StatefulWidget {
  final int paymentRecordId;
  final ReceiptModel receipt;

  /// Called after the request was changed successfully on the backend.
  final VoidCallback? onChanged;

  const ReceiptCard({
    super.key,
    required this.paymentRecordId,
    required this.receipt,
    this.onChanged,
  });

  @override
  State<ReceiptCard> createState() => _ReceiptCardState();
}

class _ReceiptCardState extends State<ReceiptCard> {
  final ApiClient _apiClient = ApiClientImpl();
  late ReceiptModel _receipt;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _receipt = widget.receipt;
  }

  @override
  void didUpdateWidget(covariant ReceiptCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // New data from the server (e.g. a refetch) wins over the local state.
    if (!identical(oldWidget.receipt, widget.receipt)) {
      _receipt = widget.receipt.mergeProfileFrom(_receipt);
    }
  }

  Future<void> _post(
      {required bool requested, BillingProfileModel? profile}) async {
    setState(() => _isSubmitting = true);
    try {
      final res = await _apiClient.post(
        apiUrlPaymentRecordReceipt(widget.paymentRecordId),
        body: {
          'requested': requested,
          'billingProfile': profile != null ? idForApi(profile.id) : null,
        },
      );
      final data = jsonDecode(res.body);
      ReceiptModel updated = ReceiptModel.fromJson(
          data['receipt'] is Map<String, dynamic> ? data['receipt'] : null);
      if (profile != null && updated.billingProfile?.id == profile.id) {
        updated = ReceiptModel(
          requested: updated.requested,
          bolloVerified: updated.bolloVerified,
          confirmationCode: updated.confirmationCode,
          requestedAt: updated.requestedAt,
          billingProfile: ReceiptBillingProfileRef(
            id: profile.id,
            label: profile.label,
            holderName: profile.holderName,
            bankAccountHolder: profile.bankAccountHolder,
          ),
        );
      }
      if (!mounted) return;
      setState(() => _receipt = updated);
      context.showSnackbar(requested
          ? context.t.receiptRequestedSnackbar
          : context.t.receiptCancelledSnackbar);
      widget.onChanged?.call();
    } catch (error) {
      if (!mounted) return;
      String message =
          apiErrorMessage(error, fallback: context.t.error_somethingWentWrong);
      if (error is ApiException && error.statusCode == 409) {
        message = context.t.receiptCannotCancelVerified;
      }
      context.showErrorSnackbar(message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _request() async {
    final billingVm = $billingProfilesViewModel(context, listen: false);
    if (!billingVm.hasLoaded) {
      await billingVm.fetch();
      if (!mounted) return;
    }
    final result = await showDialog<_RequestChoice>(
      context: context,
      builder: (_) => _ReceiptRequestDialog(
        profiles: billingVm.profiles,
        initial: billingVm.defaultProfile,
      ),
    );
    if (result == null || !mounted) return;
    if (result.goToBillingInfo) {
      await const BillingProfileListScreen().launch(context);
      return;
    }
    await _post(requested: true, profile: result.profile);
  }

  Future<void> _cancel() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.t.receiptCancelConfirmTitle),
        content: Text(context.t.receiptCancelConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.t.back),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.t.receiptCancelRequest,
                style: TextStyle(color: colorError)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await _post(requested: false);
  }

  @override
  Widget build(BuildContext context) {
    final String localeCode = $settingsController(context).locale.languageCode;
    final ReceiptModel f = _receipt;
    final (String statusText, Color statusColor, IconData statusIcon) =
        f.bolloVerified
            ? (context.t.receiptStatusVerified, colorSuccess, Icons.verified)
            : f.requested
                ? (
                    context.t.receiptStatusRequested,
                    colorSecondaryDark,
                    Icons.hourglass_top
                  )
                : (
                    context.t.receiptStatusNotRequested,
                    colorTextDisabled,
                    Icons.receipt_long_outlined
                  );

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(context.t.receiptTitle,
                        style: textStyleHeadingSmall),
                  ),
                  Icon(statusIcon, size: 18, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: textStyleBodySmall.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(context.t.receiptExplanation, style: textStyleBodySmall),
              if (f.requested) ...[
                const SizedBox(height: 12),
                if (f.billingProfile != null)
                  _infoRow(
                    context.t.receiptAddressee,
                    [f.billingProfile!.label, f.billingProfile!.holderName]
                        .whereType<String>()
                        .where((e) => e.isNotEmpty)
                        .join(' / ')
                        .ifEmpty(context.t.receiptAddresseeRegistered),
                  )
                else
                  _infoRow(context.t.receiptAddressee,
                      context.t.receiptNoBillingProfile),
                if (f.requestedAt != null)
                  _infoRow(
                      context.t.receiptRequestedAt,
                      formatDateTime(f.requestedAt!.toLocal(),
                          localeCode: localeCode)),
                if (f.confirmationCode != null) ...[
                  const SizedBox(height: 8),
                  _confirmationCode(context, f.confirmationCode!),
                ],
              ],
              const SizedBox(height: 12),
              if (!f.requested)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: actionPrimaryColor,
                      foregroundColor: textColorWhite,
                    ),
                    onPressed: _isSubmitting ? null : _request,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.receipt_long_outlined),
                    label: Text(context.t.receiptRequestButton),
                  ),
                )
              else if (!f.bolloVerified)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _isSubmitting ? null : _cancel,
                    child: Text(
                      context.t.receiptCancelRequest,
                      style: TextStyle(color: colorError),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ',
              style: textStyleBodySmall.copyWith(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: textStyleBodySmall)),
        ],
      ),
    );
  }

  Widget _confirmationCode(BuildContext context, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorTertiary.withAlpha(120),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.receiptConfirmationCode,
              style: textStyleBodySmall.copyWith(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  code,
                  style: textStyleHeadingMedium.copyWith(letterSpacing: 1.5),
                ),
              ),
              IconButton(
                tooltip: context.t.copy,
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: code));
                  if (!context.mounted) return;
                  context.showSnackbar(context.t.copied);
                },
              ),
            ],
          ),
          Text(context.t.receiptConfirmationCodeHint,
              style: textStyleBodySmall),
        ],
      ),
    );
  }
}

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}

class _RequestChoice {
  final BillingProfileModel? profile;
  final bool goToBillingInfo;
  const _RequestChoice({this.profile, this.goToBillingInfo = false});
}

class _ReceiptRequestDialog extends StatefulWidget {
  final List<BillingProfileModel> profiles;
  final BillingProfileModel? initial;
  const _ReceiptRequestDialog({required this.profiles, this.initial});

  @override
  State<_ReceiptRequestDialog> createState() => _ReceiptRequestDialogState();
}

class _ReceiptRequestDialogState extends State<_ReceiptRequestDialog> {
  BillingProfileModel? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final profiles = widget.profiles;
    return AlertDialog(
      title: Text(context.t.receiptRequestDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.t.receiptRequestDialogBody,
                style: textStyleBodyMedium),
            const SizedBox(height: 12),
            if (profiles.isEmpty) ...[
              Text(context.t.receiptNoBillingProfileHint,
                  style: textStyleBodySmall),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context)
                    .pop(const _RequestChoice(goToBillingInfo: true)),
                icon: const Icon(Icons.add),
                label: Text(context.t.billingInfoAdd),
              ),
            ] else if (profiles.length == 1)
              Text(
                '${context.t.receiptAddressee}: ${profiles.first.label} / ${profiles.first.holderName}',
                style: textStyleBodySmall.copyWith(fontWeight: FontWeight.bold),
              )
            else ...[
              Text(context.t.receiptChooseBillingProfile,
                  style:
                      textStyleBodySmall.copyWith(fontWeight: FontWeight.bold)),
              RadioGroup<String>(
                groupValue: _selected?.id,
                onChanged: (id) => setState(
                    () => _selected = profiles.firstWhere((p) => p.id == id)),
                child: Column(
                  children: profiles
                      .map((p) => RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            value: p.id,
                            title: Text(p.label),
                            subtitle: Text(p.holderName),
                          ))
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_RequestChoice(
            profile: profiles.isEmpty
                ? null
                : profiles.length == 1
                    ? profiles.first
                    : _selected,
          )),
          child: Text(profiles.isEmpty
              ? context.t.receiptRequestWithoutProfile
              : context.t.receiptRequestButton),
        ),
      ],
    );
  }
}
