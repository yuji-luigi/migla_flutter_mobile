import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/auth/login/login_form.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final ApiClient _apiClient = ApiClient();
  Future<void> login(Map<String, dynamic> formData) async {
    Response res =
        await _apiClient.post('/users/login?role-name=parent', body: formData);
    print('login: ${res.body}');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: ChangeNotifierProvider(
        create: (context) => FormViewModel(
          onSubmit: login,
          initialValues: {
            'email': 'initial',
            'password': 'password',
          },
        ),
        child: LoginForm(),
      ),
    );
  }
}
