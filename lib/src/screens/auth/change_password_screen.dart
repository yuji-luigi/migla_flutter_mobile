import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/billing_profiles_view_model.dart';
import 'package:migla_flutter/src/view_models/inquiries_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

const int _minPasswordLength = 8;

/// Change the logged-in user's password.
///
/// [forced]: the account still has the temporary password the school set
/// (`mustChangePassword`). Shown right after login / app start with no way
/// back; the only other action is logging out. On success it continues to the
/// dashboard. Otherwise (from settings) it just pops.
class ChangePasswordScreen extends StatefulWidget {
  final bool forced;
  const ChangePasswordScreen({super.key, this.forced = false});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;
  bool _isSubmitting = false;

  /// Backend rejection shown under the matching field.
  String? _currentError;
  String? _newError;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.isEmpty) ? context.t.changePasswordRequired : null;

  Future<void> _submit() async {
    setState(() {
      _currentError = null;
      _newError = null;
    });
    if (_formKey.currentState?.validate() != true) return;

    final meVm = $meViewModel(context, listen: false);
    setState(() => _isSubmitting = true);
    try {
      await meVm.changePassword(
        currentPassword: _current.text,
        newPassword: _new.text,
      );
      if (!mounted) return;
      context.showSnackbar(context.t.changePasswordDone);
      if (widget.forced) {
        DashboardHomeScreen().launch(context, isNewTask: true);
      } else {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (!mounted) return;
      _showError(error);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(Object error) {
    String? code;
    if (error is ApiException) {
      final errors = error.json is Map ? error.json['errors'] : null;
      if (errors is List && errors.isNotEmpty && errors.first is Map) {
        code = errors.first['code']?.toString();
      }
    }
    switch (code) {
      case 'wrong_current':
        setState(() => _currentError = context.t.changePasswordWrongCurrent);
      case 'too_short':
        setState(() => _newError = context.t.changePasswordTooShort);
      case 'same_as_current':
        setState(() => _newError = context.t.changePasswordSameAsCurrent);
      default:
        context.showErrorSnackbar(apiErrorMessage(error));
    }
    _formKey.currentState?.validate();
  }

  Future<void> _logout() async {
    final meVm = $meViewModel(context, listen: false);
    final gqlClient = GraphQLProvider.of(context).value;
    final studentsVm = $studentsViewModel(context, listen: false);
    final billingVm = $billingProfilesViewModel(context, listen: false);
    final inquiriesVm = $inquiriesViewModel(context, listen: false);
    await meVm.logout();
    gqlClient.cache.store.reset();
    studentsVm.clear();
    billingVm.clear();
    inquiriesVm.clear();
    if (!mounted) return;
    LoginScreen().launch(context, isNewTask: true);
  }

  Widget _visibilityToggle() => IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
      );

  @override
  Widget build(BuildContext context) {
    // Forced: opened as a new task, so the app bar has no back arrow either.
    return PopScope(
      canPop: !widget.forced,
      child: AuthScaffold(
        child: AuthScaffoldColumn(
          children: [
            Text(
              context.t.changePasswordTitle,
              style: textStyleHeadingMedium,
              textAlign: TextAlign.center,
            ),
            if (widget.forced) ...[
              8.height,
              Text(
                context.t.changePasswordForcedMessage,
                textAlign: TextAlign.center,
              ),
            ],
            16.height,
            AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    InputRoundedWhite(
                      controller: _current,
                      hintText: context.t.changePasswordCurrent,
                      obscureText: _obscure,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                      suffixIcon: _visibilityToggle(),
                      validator: (v) => _required(v) ?? _currentError,
                    ),
                    InputRoundedWhite(
                      controller: _new,
                      hintText: context.t.changePasswordNew,
                      obscureText: _obscure,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (v) {
                        if (_required(v) != null) return _required(v);
                        if (v!.length < _minPasswordLength) {
                          return context.t.changePasswordTooShort;
                        }
                        if (v == _current.text) {
                          return context.t.changePasswordSameAsCurrent;
                        }
                        return _newError;
                      },
                    ),
                    InputRoundedWhite(
                      controller: _confirm,
                      hintText: context.t.changePasswordConfirm,
                      obscureText: _obscure,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (v) {
                        if (_required(v) != null) return _required(v);
                        if (v != _new.text) return context.t.changePasswordMismatch;
                        return null;
                      },
                    ),
                    Button(
                      key: ValueKey(_isSubmitting),
                      text: context.t.changePasswordSubmit,
                      isLoading: _isSubmitting,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.forced) ...[
              8.height,
              Center(
                child: TextButton(
                  onPressed: _isSubmitting ? null : _logout,
                  child: Text(context.t.logout),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
