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

            return ChangeNotifierProvider(
              create: (context) => FormViewModel(
                initialValues: initialValues,
              ),
              child: LoginForm(),
            );
          }),
    );
  }
}
