import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_model.dart';
import 'package:migla_flutter/src/models/enums/regex_list.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/inquiries_view_model.dart';
import 'package:migla_flutter/src/views/inquiry/inquiry_labels.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// New inquiry form. In [guest] mode (not logged in) it also asks for name,
/// email and privacy consent; replies then arrive by email.
///
/// Pops with the new inquiry id when logged in (so the caller can open the
/// thread), or `null`.
class InquiryFormScreen extends StatefulWidget {
  final bool guest;
  const InquiryFormScreen({super.key, this.guest = false});

  @override
  State<InquiryFormScreen> createState() => _InquiryFormScreenState();
}

class _InquiryFormScreenState extends State<InquiryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _category = inquiryCategories.first;
  bool _privacyConsent = false;
  bool _showConsentError = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint}) => InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: colorWhite,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      );

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? context.t.fieldIsRequired : null;

  Future<void> _submit() async {
    final bool valid = _formKey.currentState?.validate() == true;
    if (widget.guest && !_privacyConsent) {
      setState(() => _showConsentError = true);
    }
    if (!valid || (widget.guest && !_privacyConsent)) return;

    setState(() => _isSubmitting = true);
    try {
      final String locale =
          $settingsController(context, listen: false).locale.languageCode;
      final String? id =
          await $inquiriesViewModel(context, listen: false).submit(
        subject: _subjectController.text.trim(),
        message: _messageController.text.trim(),
        category: _category,
        locale: locale,
        name: widget.guest ? _nameController.text.trim() : null,
        email: widget.guest ? _emailController.text.trim() : null,
        privacyConsent: widget.guest ? true : null,
      );
      if (!mounted) return;
      if (widget.guest) {
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(context.t.inquirySentTitle),
            content: Text(context.t.inquirySentGuest),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(context.t.commonOk),
              ),
            ],
          ),
        );
        if (!mounted) return;
        Navigator.of(context).pop();
      } else {
        context.showSnackbar(context.t.inquirySent);
        Navigator.of(context).pop(id);
      }
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
    return RegularLayoutScaffold(
      title: context.t.inquiryNew,
      showStudentName: false,
      bodyColor: colorTertiary,
      padding: EdgeInsets.zero,
      appBarActions: const [],
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              paddingXDashboardMd, 16, paddingXDashboardMd, 48),
          children: [
            if (widget.guest) ...[
              _guestHint(context),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                decoration: _decoration('${context.t.inquiryName} *'),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                decoration: _decoration('${context.t.labelEmail} *'),
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return context.t.labelEmailRequired;
                  if (!emailRegex.hasMatch(value)) {
                    return context.t.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: _decoration(context.t.inquiryCategory),
              items: inquiryCategories
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(inquiryCategoryLabel(context, c)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _category = v ?? _category),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              maxLength: 200,
              decoration: _decoration('${context.t.inquirySubject} *'),
              validator: _required,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: _messageController,
              minLines: 6,
              maxLines: 12,
              maxLength: 5000,
              keyboardType: TextInputType.multiline,
              decoration: _decoration('${context.t.inquiryMessage} *',
                  hint: context.t.inquiryMessageHint),
              validator: _required,
            ),
            if (widget.guest) _consentCheckbox(context),
            const SizedBox(height: 16),
            Button(
              text: context.t.submit,
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _guestHint(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorWhite.withAlpha(180),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.inquiryGuestHint, style: textStyleBodySmall),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => LoginScreen().launch(context),
              child: Text(context.t.login),
            ),
          ),
        ],
      ),
    );
  }

  Widget _consentCheckbox(BuildContext context) {
    final linkStyle = textStyleBodySmall.copyWith(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: _privacyConsent,
              onChanged: (v) => setState(() {
                _privacyConsent = v ?? false;
                if (_privacyConsent) _showConsentError = false;
              }),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: textStyleBodySmall,
                  children: [
                    TextSpan(text: context.t.inquiryPrivacyConsentPrefix),
                    TextSpan(
                      text: context.t.privacyPolicy,
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(privacyPolicyUrl),
                              mode: LaunchMode.externalApplication,
                            ),
                    ),
                    TextSpan(text: context.t.inquiryPrivacyConsentSuffix),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (_showConsentError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(context.t.inquiryPrivacyConsentRequired,
                style: textStyleBodySmall.copyWith(color: colorError)),
          ),
      ],
    );
  }
}
