import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/views/auth/register/register_form.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  Future<void> _onSubmit(
      BuildContext context, FormViewModel formViewModel) async {
    if (formViewModel.formKey.currentState?.validate() == false) {
      return;
    }
    final AuthTokenProvider authTokenProvider =
        $authTokenProvider(context, listen: false);
    final MeViewModel meViewModel = $meViewModel(context, listen: false);

    final Map<String, dynamic> body = {};
    body.addAll(formViewModel.formData);
    body['newsletter'] = formViewModel.formData['newsletter'] == true;
    body['locale'] =
        $settingsController(context, listen: false).locale.languageCode;

    formViewModel.setIsSubmitting(true);
    try {
      final Response response =
          await ApiClientImpl().post(apiUrlRegister, body: body);
      final Map<String, dynamic> resData = jsonDecode(response.body);
      await authTokenProvider.setToken(resData['data']['token']);
      await meViewModel.getMe();
      if (!context.mounted) return;
      if (body['newsletter'] == true) {
        context.showSnackbar(context.t.newsletterConfirmSent);
      }
      DashboardHomeScreen().launch(context, isNewTask: true);
    } catch (error) {
      Logger.error('register error: $error');
      if (!context.mounted) return;
      String message = apiErrorMessage(error,
          fallback: context.t.error_somethingWentWrong);
      if (error is ApiException && error.statusCode == 429) {
        message = context.t.tooManyAttempts;
      }
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(context.t.registerFailed),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(context.t.commonOk),
            ),
          ],
        ),
      );
    } finally {
      formViewModel.setIsSubmitting(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: FormProvider(
        formKey: _formKey,
        initialValues: {
          'name_it': '',
          'name_ja': '',
          'surname_it': '',
          'surname_ja': '',
          'email': '',
          'password': '',
          'confirm_password': '',
          'newsletter': false,
        },
        child: Consumer<FormViewModel>(
          builder: (context, formViewModel, child) =>
              AuthScaffoldColumn(children: [
            Spacer(),
            Center(child: Image.asset('assets/images/rainbow.png')),
            Text(context.t.welcomeToMigla, style: textStyleHeadingMedium),
            24.height,
            Text(context.t.welcomeDesc,
                style: textStyleHeadingSmall, textAlign: TextAlign.center),
            Spacer(),
            RegisterForm(),
            Spacer(),
            Button(
              key: ValueKey(formViewModel.isSubmitting),
              text: context.t.register,
              isLoading: formViewModel.isSubmitting,
              onPressed: () => _onSubmit(context, formViewModel),
            ),
            16.height,
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.t.alreadyHaveAccount),
                LinkText(
                  context.t.login,
                  newScreen: LoginScreen(),
                  isNewTask: true,
                ),
              ],
            ),
            24.height,
          ]),
        ),
      ),
    );
  }
}
