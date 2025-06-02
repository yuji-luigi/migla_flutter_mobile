import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/auth/register_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: AuthScaffoldColumn(children: [
        Spacer(),
        Center(
          child: Image.asset(
            'assets/images/auth/man_checklist.png',
          ),
        ),
        24.height,
        Text(
          context.t.welcomeToMigla,
          style: textStyleHeadingMedium,
        ),
        8.height,
        Text(
          context.t.welcomeDesc,
          style: TextStyle(
            fontSize: fontSizeBodySmall,
          ),
        ),
        Spacer(),
        Button(
          onPressed: () {
            LoginScreen().launch(context);
          },
          text: context.t.getStarted,
        ),
        24.height,
      ]),
    );
  }
}
