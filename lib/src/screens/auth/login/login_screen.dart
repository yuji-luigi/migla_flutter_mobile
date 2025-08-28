import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/auth/login/login_form.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: FutureBuilder<Map<String, String>?>(
          future: Storage.getLoginCredentials(),
          builder: (ctx, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return Stack(children: [
                CircularProgressIndicator(),
                ChangeNotifierProvider(
                    create: (context) => FormViewModel(
                          // onError: onError,
                          formKey: _formKey,
                          initialValues: {},
                        ),
                    child: LoginForm())
              ]);
            }
            final credential = snap.data;
            final initialValues = {
              'email': credential?.keys.first ?? '',
              'password': credential?.values.first ?? '',
              'rememberMe': credential != null,
            };

            return FormProvider(
              formKey: _formKey,
              initialValues: initialValues,
              child: LoginForm(),
            );
          }),
    );
  }
}
