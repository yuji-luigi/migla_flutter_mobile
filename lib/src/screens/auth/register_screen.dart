import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/auth/register/form_email_password.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
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
        Text(context.t.welcomeDesc,
            style: textStyleHeadingSmall, textAlign: TextAlign.center),
        Spacer(),
        FormEmailPassword(),
        Spacer(),
        Button(
          text: context.t.register,
          onPressed: () {
            DashboardHomeScreen().launch(context, isNewTask: true);
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
      ],
    );
  }
}
