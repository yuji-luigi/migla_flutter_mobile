import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
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
                dynamic response = await ApiClientImpl()
                    .post(apiUrlRegister, body: formViewModel.formData);

                ///
                ///the response looks like this:
                ///{
                // loginResponse: {
                //   exp: 1784318499,
                //   token: 'x',
                //   user: {
                //     id: 582,
                //     name: 's',
                //     surname: 's',
                //     searchText: 's s s s ss ss',
                //     currentRoleNew: null,
                //     currentRole: [Object],
                //     roles: [Array],
                //     fcmToken: [Object],
                //     lastLoginAt: null,
                //     updatedAt: null,
                //     createdAt: '2026-07-15T20:01:39.112Z',
                //     deletedAt: null,
                //     email: 'u.ji.jp777+test.no4@gmail.com',
                //     sessions: [Array],
                //     collection: 'users',
                //     _strategy: 'local-jwt',
                //     fullname: 's s',
                //     displayName: 's s <u.ji.jp777+test.no4@gmail.com>'
                //   }
                // }

                inspect(response);
                // DashboardHomeScreen().launch(context, isNewTask: true);
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
