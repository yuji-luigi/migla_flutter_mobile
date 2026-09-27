import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/billing_profile/billing_profile_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/billing_profiles_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';

/// Create / edit form for a receipt addressee (領収書の宛名).
///
/// MIGLA only issues receipts (non-profit), so the fattura fields the backend
/// still has (type, codice fiscale, partita IVA, SDI, PEC, address) are not
/// shown nor sent.
class BillingProfileFormScreen extends StatefulWidget {
  final BillingProfileModel? profile;
  const BillingProfileFormScreen({super.key, this.profile});

  @override
  State<BillingProfileFormScreen> createState() =>
      _BillingProfileFormScreenState();
}

class _BillingProfileFormScreenState extends State<BillingProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isDefault;
  bool _isSubmitting = false;

  /// Field errors returned by the backend, keyed by Payload field path.
  Map<String, String> _serverErrors = {};

  late final Map<String, TextEditingController> _c;

  bool get _isEdit => widget.profile != null;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _isDefault = p?.isDefault ?? false;
    _c = {
      'label': TextEditingController(text: p?.label ?? ''),
      'holderName': TextEditingController(text: p?.holderName ?? ''),
      'bankAccountHolder':
          TextEditingController(text: p?.bankAccountHolder ?? ''),
      'notes': TextEditingController(text: p?.notes ?? ''),
    };
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  String _v(String key) => _c[key]!.text.trim();

  Map<String, dynamic> _buildBody() {
    return {
      'label': _v('label'),
      'holderName': _v('holderName'),
      'bankAccountHolder': _v('bankAccountHolder'),
      'notes': _v('notes'),
      'isDefault': _isDefault,
    };
  }

  Future<void> _submit() async {
    setState(() => _serverErrors = {});
    if (_formKey.currentState?.validate() != true) return;
    setState(() => _isSubmitting = true);
    try {
      await $billingProfilesViewModel(context, listen: false)
          .save(_buildBody(), id: widget.profile?.id);
      if (!mounted) return;
      context.showSnackbar(context.t.billingSaved);
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      if (error is ApiException && error.fieldErrors.isNotEmpty) {
        setState(() => _serverErrors = error.fieldErrors);
        _formKey.currentState?.validate();
      }
      context.showErrorSnackbar(
          apiErrorMessage(error, fallback: context.t.error_somethingWentWrong));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  InputDecoration _decoration(String key, String label,
      {String? hint, String? helper}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helper,
      helperMaxLines: 4,
      filled: true,
      fillColor: colorWhite,
      errorText: _serverErrors[key],
      errorMaxLines: 3,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _field(
    String key,
    String label, {
    String? hint,
    String? helper,
    bool required = false,
    TextInputType? keyboardType,
    int maxLines = 1,
    TextCapitalization capitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: _c[key],
        keyboardType: keyboardType,
        textCapitalization: capitalization,
        maxLines: maxLines,
        minLines: 1,
        decoration: _decoration(key, required ? '$label *' : label,
            hint: hint, helper: helper),
        onChanged: (_) {
          if (_serverErrors.containsKey(key)) {
            setState(() => _serverErrors.remove(key));
          }
        },
        validator: (raw) {
          final value = (raw ?? '').trim();
          if (required && value.isEmpty) return context.t.fieldIsRequired;
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      title: _isEdit ? context.t.billingInfoEdit : context.t.billingInfoAdd,
      showStudentName: false,
      bodyColor: colorTertiary,
      appBarActions: const [],
      padding: EdgeInsets.zero,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              paddingXDashboardMd, 16, paddingXDashboardMd, 48),
          children: [
            Text(context.t.billingInfoEmptyDesc, style: textStyleBodySmall),
            const SizedBox(height: 16),
            _field('label', context.t.billingLabel,
                hint: context.t.billingLabelHint, required: true),
            _field(
              'holderName',
              context.t.billingHolderName,
              required: true,
              capitalization: TextCapitalization.words,
            ),
            _field(
              'bankAccountHolder',
              context.t.billingBankAccountHolder,
              helper: context.t.billingBankAccountHolderHelper,
              required: true,
              capitalization: TextCapitalization.words,
            ),
            _field(
              'notes',
              context.t.billingNotes,
              hint: context.t.billingNotesHint,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _isDefault,
              activeThumbColor: colorSecondary,
              title:
                  Text(context.t.billingIsDefault, style: textStyleBodyMedium),
              onChanged: (v) => setState(() => _isDefault = v),
            ),
            const SizedBox(height: 16),
            Button(
              text: context.t.commonSave,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
