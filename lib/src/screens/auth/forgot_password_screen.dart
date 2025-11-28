import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ApiClient _apiClient = ApiClientImpl();
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return AuthScaffold(
      child: AuthScaffoldColumn(
        children: [
          Text(
            context.t.forgotPasswordEmailInputLabel,
            style: textStyleHeadingMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  InputRoundedWhite(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: context.t.labelEmail,
                    autofillHints: const [AutofillHints.username], // or .email
                  ),
                  Button(
                    text: context.t.submit,
                    onPressed: () async {
                      await _apiClient.post(apiUrlForgotPassword, body: {
                        'email': emailController.text,
                      });
                      context.showSnackbar(context.t.has_been_sent);
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LinkText(context.t.back, newScreen: LoginScreen())],
          )
        ],
      ),
    );
  }
}
