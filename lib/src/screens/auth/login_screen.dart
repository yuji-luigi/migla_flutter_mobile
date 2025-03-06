import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/spacings.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/forgot_password_screen.dart';
import 'package:migla_flutter/src/screens/auth/register_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      spacing: 8,
      children: [
        Spacer(),
        Text(
          context.t.welcomeBack,
          style: textStyleHeadingMedium,
        ),
        8.height,
        Center(child: SvgPicture.asset('assets/images/auth/mom_son.svg')),
        24.height,
        Column(
          spacing: spacingAuthForm,
          children: [
            InputRoundedWhite(
              hintText: context.t.labelEmail,
            ),
            InputRoundedWhite(
              hintText: context.t.labelPassword,
            ),
          ],
        ),
        Spacer(),
        LinkText(
          context.t.forgotPassword,
          newScreen: ForgotPasswordScreen(),
          isNewTask: true,
        ),
        Spacer(),
        Button(
          text: context.t.login,
          onPressed: () {
            DashboardHomeScreen().launch(context, isNewTask: true);
          },
        ),
        16.height,
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.t.noAccount),
            LinkText(
              context.t.register,
              newScreen: RegisterScreen(),
              isNewTask: true,
            ),
          ],
        )
      ],
    );
  }
}
