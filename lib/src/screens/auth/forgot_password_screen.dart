import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';

/// Sends the password reset email. The backend always answers "sent" (it does
/// not reveal whether the address is registered); the email links to the
/// website's set-password page, which also clears `mustChangePassword`.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ApiClient _apiClient = ApiClientImpl();
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _isSubmitting = false;
  bool _sent = false;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    setState(() => _isSubmitting = true);
    try {
      await _apiClient.post(apiUrlForgotPassword, body: {
        'email': _email.text.trim(),
      });
      if (mounted) setState(() => _sent = true);
    } catch (_) {
      if (mounted) context.showErrorSnackbar(context.t.forgotPasswordFailed);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: AuthScaffoldColumn(
        children: [
          Text(
            context.t.forgotPasswordScreenHeader,
            style: textStyleHeadingMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (_sent)
            Text(context.t.forgotPasswordSent, textAlign: TextAlign.center)
          else ...[
            Text(context.t.forgotPasswordEmailInputLabel, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    InputRoundedWhite(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: context.t.labelEmail,
                      autofillHints: const [AutofillHints.email],
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return context.t.labelEmailRequired;
                        if (!_emailPattern.hasMatch(value)) return context.t.invalidEmail;
                        return null;
                      },
                    ),
                    Button(
                      key: ValueKey(_isSubmitting),
                      text: context.t.submit,
                      isLoading: _isSubmitting,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LinkText(context.t.back, newScreen: LoginScreen())],
          ),
        ],
      ),
    );
  }
}
