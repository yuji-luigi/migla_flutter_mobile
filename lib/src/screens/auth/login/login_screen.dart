import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/strage.dart';
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
    MeViewModel meViewModel = $meViewModel(context);
    Future<void> login(Map<String, dynamic> formData) async {
      try {
        Response res = await _apiClient.post('/users/login?role-name=parent',
            body: formData);
        // print('login: ${res.body}');
        Map<String, dynamic> body = jsonDecode(res.body);
        await Storage.saveToken(body['token']);
        meViewModel.setToken(body['token']);
        DashboardHomeScreen().launch(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return AuthScaffold(
      child: ChangeNotifierProvider(
        create: (context) => FormViewModel(
          onSubmit: login,
          initialValues: {
            'email': 'u.ji.jp777+parent.a@gmail.com',
            'password': 'user\$\$\$',
          },
        ),
        child: LoginForm(),
      ),
    );
  }
}
