import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/views/auth/register/register_form.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

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
              text: context.t.register,
              onPressed: () async {
                if (formViewModel.formKey.currentState?.validate() == false) {
                  return;
                }

                Map<String, dynamic> body = {};
                body.addAll(formViewModel.formData);
                body['locale'] = $settingsController(context, listen: false)
                    .locale
                    .languageCode;
                Response response = await ApiClientImpl()
                    .post(apiUrlRegister, body: formViewModel.formData);

                if (response.statusCode < 300 && response.statusCode >= 200) {
                  final Map<String, dynamic> resData =
                      jsonDecode(response.body);
                  AuthTokenProvider authTokenProvider = $authTokenProvider(
                    context,
                    listen: false,
                  );
                  authTokenProvider.setToken(resData['data']['token']);

                  DashboardHomeScreen().launch(context, isNewTask: true);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text('error'), content: Text(response.body)));
                }
              },
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
