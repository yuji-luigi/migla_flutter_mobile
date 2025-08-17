import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/extensions/localization/exception_extension.dart';
import 'package:migla_flutter/src/models/api/errors/validation_error.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:migla_flutter/src/screens/auth/login/login_form.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    AuthTokenProvider authTokenProvider = $authTokenProvider(context);
    MeViewModel meViewModel = $meViewModel(context);
    if (meViewModel.hasMe) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          DashboardHomeScreen().launch(context, isNewTask: true);
        }
      });
    }
    Future<void> login(Map<String, dynamic> formData) async {
      Response res = await _apiClient.post('/users/login?role-name=parent',
          body: formData);
      // print('login: ${res.body}');
      Map<String, dynamic> body = jsonDecode(res.body);
      if (formData['rememberMe'] == true) {
        await Storage.saveCredentials(formData['email'], formData['password']);
      }
      await authTokenProvider.setToken(body['token']);
      await meViewModel.getMe();
      // DashboardHomeScreen().launch(context, isNewTask: true);
    }

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

    return AuthScaffold(
      child: FutureBuilder<Map<String, String>?>(
          future: Storage.getLoginCredentials(),
          builder: (ctx, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return Stack(children: [
                CircularProgressIndicator(),
                ChangeNotifierProvider(
                    create: (context) => FormViewModel(
                        onSubmit: login, onError: onError, initialValues: {}),
                    child: LoginForm())
              ]);
            }
            final credential = snap.data;
            final initialValues = {
              'email': credential?.keys.first ?? '',
              'password': credential?.values.first ?? '',
              'rememberMe': credential != null,
            };

            return ChangeNotifierProvider(
              create: (context) => FormViewModel(
                onSubmit: login,
                onError: onError,
                initialValues: initialValues,
              ),
              child: LoginForm(),
            );
          }),
    );
  }
}
