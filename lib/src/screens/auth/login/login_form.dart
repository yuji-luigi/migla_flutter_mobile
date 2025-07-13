import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/spacings.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/forgot_password_screen.dart';
import 'package:migla_flutter/src/screens/auth/register_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/input_rounded_white_controlled.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/password_input_controlled.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    FormViewModel formViewModel = $formViewModel(context);
    return AuthScaffoldColumn(
      children: [
        Spacer(),
        Text(
          context.t.welcomeBack,
          style: textStyleHeadingMedium,
        ),
        8.height,
        Center(child: SvgPicture.asset('assets/images/auth/mom_son.svg')),
        24.height,
        AutofillGroup(
          child: Column(
            spacing: spacingAuthForm,
            children: [
              InputRoundedWhiteControlled(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                hintText: context.t.labelEmail,
                autofillHints: const [AutofillHints.username], // or .email
              ),
              PasswordInputControlled(
                name: 'password',
                keyboardType: TextInputType.visiblePassword,
                hintText: context.t.labelPassword,
                autofillHints: const [AutofillHints.password],
              ),
            ],
          ),
        ),
        Spacer(),
        Button(
            key: ValueKey(formViewModel.isSubmitting),
            text: context.t.login,
            isLoading: formViewModel.isSubmitting,
            onPressed: () async {
              await formViewModel.submitForm();
            }),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LinkText(
              context.t.forgotPassword,
              newScreen: ForgotPasswordScreen(),
              isNewTask: true,
            ),
          ],
        ),
        Spacer(),
        // 16.height,
        // Row(
        //   spacing: 4,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(context.t.noAccount),
        //     LinkText(
        //       context.t.register,
        //       newScreen: RegisterScreen(),
        //       isNewTask: true,
        //     ),
        //   ],
        // )
      ],
    );
  }
}
