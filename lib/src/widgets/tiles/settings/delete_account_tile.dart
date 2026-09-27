import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/screens/public/public_home_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/billing_profiles_view_model.dart';
import 'package:migla_flutter/src/view_models/inquiries_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:nb_utils/nb_utils.dart';

/// Settings tile to delete the account (App Store guideline 5.1.1(v)).
///
/// Accounts without school records are deleted immediately; for enrolled
/// families the backend forwards the request to the school office because
/// student and payment records must be kept.
class DeleteAccountTile extends StatefulWidget {
  const DeleteAccountTile({super.key});

  @override
  State<DeleteAccountTile> createState() => _DeleteAccountTileState();
}

class _DeleteAccountTileState extends State<DeleteAccountTile> {
  bool _isSubmitting = false;

  Future<void> _onTap() async {
    final String? reason = await showDialog<String>(
      context: context,
      builder: (_) => const _DeleteAccountDialog(),
    );
    if (reason == null || !mounted) return;
    await _submit(reason);
  }

  Future<void> _submit(String reason) async {
    final meVm = $meViewModel(context, listen: false);
    final gqlClient = GraphQLProvider.of(context).value;
    final studentsVm = $studentsViewModel(context, listen: false);
    final billingVm = $billingProfilesViewModel(context, listen: false);
    final inquiriesVm = $inquiriesViewModel(context, listen: false);
    final authTokenProvider = $authTokenProvider(context, listen: false);
    final String locale =
        $settingsController(context, listen: false).locale.languageCode;

    setState(() => _isSubmitting = true);
    try {
      final String status =
          await meVm.deleteAccount(reason: reason, locale: locale);
      if (!mounted) return;
      if (status == 'deleted') {
        // Same cleanup as logout (storage is already cleared by the VM).
        authTokenProvider.clearToken();
        gqlClient.cache.store.reset();
        studentsVm.clear();
        billingVm.clear();
        inquiriesVm.clear();
        // The root ScaffoldMessenger survives the navigation below.
        final messenger = ScaffoldMessenger.of(context);
        final String doneMessage = context.t.deleteAccountDone;
        const PublicHomeScreen().launch(context, isNewTask: true);
        messenger.showSnackBar(SnackBar(content: Text(doneMessage)));
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(context.t.deleteAccountRequestedTitle),
          content: Text(context.t.deleteAccountRequestedBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.t.commonOk),
            ),
          ],
        ),
      );
    } catch (error) {
      if (!mounted) return;
      String message = apiErrorMessage(error,
          fallback: context.t.error_somethingWentWrong);
      if (error is ApiException && error.statusCode == 429) {
        message = context.t.tooManyAttempts;
      }
      context.showErrorSnackbar(message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      onTap: _isSubmitting ? null : _onTap,
      title: Row(
        spacing: 8,
        children: [
          _isSubmitting
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Icon(Icons.person_remove_outlined, color: errorColor),
          Text(
            context.t.deleteAccount,
            style: textStyleBodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: errorColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Confirmation dialog; pops with the (possibly empty) reason, or null when
/// cancelled.
class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog();

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  final TextEditingController _reasonController = TextEditingController();
  bool _understood = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.t.deleteAccountConfirmTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.t.deleteAccountConfirmBody,
                style: textStyleBodyMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              minLines: 2,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: context.t.deleteAccountReason,
                border: const OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _understood,
              onChanged: (v) => setState(() => _understood = v ?? false),
              title: Text(context.t.deleteAccountUnderstand,
                  style: textStyleBodySmall),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.t.cancel),
        ),
        TextButton(
          onPressed: _understood
              ? () => Navigator.of(context).pop(_reasonController.text)
              : null,
          child: Text(
            context.t.deleteAccountConfirmButton,
            style: TextStyle(
                color: _understood ? colorError : colorTextDisabled,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
