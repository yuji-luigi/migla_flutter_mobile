import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/input_rounded_white_controlled.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              child: Column(children: [
                InputRoundedWhiteControlled(
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                  hintText: context.t.labelEmail,
                  autofillHints: const [AutofillHints.username], // or .email
                ),
              ]),
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
