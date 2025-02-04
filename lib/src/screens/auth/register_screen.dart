import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/auth/register/form_email_password.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      children: [
        Spacer(),
        Center(child: Image.asset('assets/images/rainbow.png')),
        Text(context.t.welcomeToMigla, style: textStyleHeadingMedium),
        24.height,
        Text(context.t.welcomeDesc, style: textStyleHeadingSmall),
        Spacer(),
        FormEmailPassword(),
        Spacer(),
        Button(
          text: context.t.register,
          onPressed: () {},
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Sign in",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        )
      ],
    );
  }
}
