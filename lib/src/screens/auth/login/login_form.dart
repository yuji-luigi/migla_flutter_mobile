import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/constants/image_constants/spacings.dart';
import 'package:migla_flutter/src/extensions/localization/exception_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/errors/validation_error.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/fcm_token_client.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/models/user_model.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/screens/auth/forgot_password_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/input_rounded_white_controlled.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/password_input_controlled.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:migla_flutter/src/widgets/switch/switch_base.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FcmTokenClientImpl _fcmTokenClient =
      FcmTokenClientImpl(apiClient: ApiClientImpl());
  final ApiClientImpl _apiClient = ApiClientImpl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Storage.removeUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    FormViewModel formViewModel = $formViewModel(context);
    AuthTokenProvider authTokenProvider = $authTokenProvider(context);
    MeViewModel meViewModel = $meViewModel(context);

    Future<List<ValidationError>> onError(Object error) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      if (error is Exception) {
        Map<String, dynamic> errorRes = jsonDecode(error.getMessage);
        Map<String, dynamic> targetError = errorRes['errors'][0];
        if (targetError['name'] == 'ValidationError') {
          if (targetError['data']['errors'] is List) {
            List<ValidationError> errors = targetError['data']['errors']
                .map((error) => ValidationError.fromJson(error))
                .whereType<ValidationError>()
                .toList();
            return errors;
          }
        }
      }
      return [
        ValidationError(path: 'email', message: 'Invalid email'),
      ];
    }

    Future<void> onSubmit(Map<String, dynamic> formData) async {
      try {
        if (formViewModel.formKey.currentState?.validate() == false) {
          return;
        }
        formViewModel.setIsSubmitting(true);
        Response res = await _apiClient.post('/users/login?role-name=parent',
            body: formData);
        Map<String, dynamic> body = jsonDecode(res.body);
        if (formData['rememberMe'] == true) {
          await Storage.saveCredentials(
              formData['email'], formData['password']);
        }
        await authTokenProvider.setToken(body['token']);
        UserModel? user = await meViewModel.getMe();
        if (user == null) {
          throw Exception(context.t.get_me_failed_after_login);
        }
        _fcmTokenClient.create(user.id);
        formViewModel.setIsSubmitting(false);
        DashboardHomeScreen().launch(context);
      } catch (error) {
        await onError(error);
      } finally {
        formViewModel.setIsSubmitting(false);
      }
    }

    return AuthScaffoldColumn(
      children: [
        Spacer(),
        Text(
          context.t.welcomeBack,
          style: textStyleHeadingMedium,
        ),
        8.height,
        Center(child: SvgPicture.asset('assets/images/auth/mom_son.svg')),
        24.height,
        AutofillGroup(
          child: Column(
            spacing: spacingAuthForm,
            children: [
              InputRoundedWhiteControlled(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                hintText: context.t.labelEmail,
                autofillHints: const [AutofillHints.username], // or .email
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return context.t.labelEmailRequired;
                //   }
                //   return null;
                // },
              ),
              PasswordInputControlled(
                name: 'password',
                keyboardType: TextInputType.visiblePassword,
                hintText: context.t.labelPassword,
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.t.labelPasswordRequired;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Spacer(),
        Button(
            key: ValueKey(formViewModel.isSubmitting),
            text: context.t.login,
            isLoading: formViewModel.isSubmitting,
            onPressed: () async {
              onSubmit(formViewModel.formData);
            }),
        Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(context.t.rememberMe),
            SwitchBase(
              value: formViewModel.formData['rememberMe'] ?? false,
              onChanged: (value) {
                formViewModel.setFormData('rememberMe', value);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinkText(
              context.t.forgotPassword,
              newScreen: ForgotPasswordScreen(),
              isNewTask: true,
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Storage.forceRemoveAll();
          },
          child: Text('dev reset storage(not context)'),
        ),
        Spacer(),
      ],
    );
  }
}
