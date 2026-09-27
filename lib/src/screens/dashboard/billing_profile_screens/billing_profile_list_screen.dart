import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/billing_profile/billing_profile_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/dashboard/billing_profile_screens/billing_profile_form_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/billing_profiles_view_model.dart';
import 'package:nb_utils/nb_utils.dart';

/// 領収書の宛名 / Dati per la ricevuta: the names used on the receipt and to
/// match bank transfers (e.g. from a spouse's account).
class BillingProfileListScreen extends StatefulWidget {
  const BillingProfileListScreen({super.key});

  @override
  State<BillingProfileListScreen> createState() =>
      _BillingProfileListScreenState();
}

class _BillingProfileListScreenState extends State<BillingProfileListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      $billingProfilesViewModel(context, listen: false).fetch();
    });
  }

  Future<void> _openForm([BillingProfileModel? profile]) async {
    await BillingProfileFormScreen(profile: profile).launch(context);
  }

  Future<void> _confirmDelete(BillingProfileModel profile) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.t.billingDeleteConfirmTitle),
        content: Text(context.t.billingDeleteConfirmBody(profile.label)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.t.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.t.commonDelete,
                style: TextStyle(color: colorError)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await $billingProfilesViewModel(context, listen: false)
          .delete(profile.id);
      if (!mounted) return;
      context.showSnackbar(context.t.billingDeleted);
    } catch (error) {
      if (!mounted) return;
      context.showErrorSnackbar(
          apiErrorMessage(error, fallback: context.t.error_somethingWentWrong));
    }
  }

  Future<void> _setDefault(BillingProfileModel profile) async {
    try {
      await $billingProfilesViewModel(context, listen: false)
          .setDefault(profile.id);
    } catch (error) {
      if (!mounted) return;
      context.showErrorSnackbar(
          apiErrorMessage(error, fallback: context.t.error_somethingWentWrong));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = $billingProfilesViewModel(context);
    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.billingInfo,
      showStudentName: false,
      appBarActions: const [],
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'billing-profile-add',
        backgroundColor: actionPrimaryColor,
        foregroundColor: textColorWhite,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: Text(context.t.billingInfoAdd),
      ),
      body: _body(context, vm),
    );
  }

  Widget _body(BuildContext context, BillingProfilesViewModel vm) {
    if (vm.isLoading && !vm.hasLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
    if (vm.errorMessage != null && vm.profiles.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.t.error_somethingWentWrong,
                style: textStyleBodyMedium),
            TextButton(onPressed: vm.fetch, child: Text(context.t.retry)),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: vm.fetch,
      child: vm.profiles.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(paddingXDashboardMd),
              children: [
                const SizedBox(height: 48),
                Icon(Icons.receipt_long_outlined,
                    size: 64, color: colorPrimaryDark),
                const SizedBox(height: 16),
                Text(
                  context.t.billingInfoEmptyTitle,
                  textAlign: TextAlign.center,
                  style: textStyleHeadingSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  context.t.billingInfoEmptyDesc,
                  textAlign: TextAlign.center,
                  style: textStyleBodyMedium,
                ),
              ],
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                  paddingXDashboardMd, 16, paddingXDashboardMd, 120),
              itemCount: vm.profiles.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(context.t.billingInfoEmptyDesc,
                        style: textStyleBodySmall),
                  );
                }
                final profile = vm.profiles[index - 1];
                return Dismissible(
                  key: ValueKey('billing-${profile.id}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: colorError,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    await _confirmDelete(profile);
                    // The list is refreshed by the view model.
                    return false;
                  },
                  child: _BillingProfileCard(
                    profile: profile,
                    onTap: () => _openForm(profile),
                    onDelete: () => _confirmDelete(profile),
                    onSetDefault: () => _setDefault(profile),
                  ),
                );
              },
            ),
    );
  }
}

enum _CardAction { edit, setDefault, delete }

class _BillingProfileCard extends StatelessWidget {
  final BillingProfileModel profile;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const _BillingProfileCard({
    required this.profile,
    required this.onTap,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        title: Row(
          children: [
            Flexible(
              child: Text(
                profile.label,
                style: textStyleHeadingSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (profile.isDefault) ...[
              const SizedBox(width: 8),
              _Badge(text: context.t.billingDefault, color: colorPrimaryDark),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(profile.holderName, style: textStyleBodyMedium),
            if (profile.bankAccountHolder.isNotEmpty)
              Text(
                '${context.t.billingBankAccountHolder}: ${profile.bankAccountHolder}',
                style: textStyleBodySmall,
              ),
          ],
        ),
        trailing: PopupMenuButton<_CardAction>(
          onSelected: (action) {
            switch (action) {
              case _CardAction.edit:
                onTap();
                break;
              case _CardAction.setDefault:
                onSetDefault();
                break;
              case _CardAction.delete:
                onDelete();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: _CardAction.edit,
              child: Text(context.t.commonEdit),
            ),
            if (!profile.isDefault)
              PopupMenuItem(
                value: _CardAction.setDefault,
                child: Text(context.t.billingSetAsDefault),
              ),
            PopupMenuItem(
              value: _CardAction.delete,
              child: Text(context.t.commonDelete,
                  style: TextStyle(color: colorError)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(900),
      ),
      child: Text(
        text,
        style: textStyleCaptionMd.copyWith(color: Colors.white),
      ),
    );
  }
}
