import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    handleSeenOnboarding();
  }

  void handleSeenOnboarding() async {
    bool seen = await Storage.getSeenOnboarding();
    if (!seen) {
      Storage.setSeenOnboarding(true);
      return;
    }
    LoginScreen().launch(context, isNewTask: true);
  }

  void _goToHome() {
    // Use addPostFrameCallback to avoid doing Navigator.push during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardHomeScreen()),
      );
    });
  }

  // @override
  // void dispose() {
  //   // Clean up the listener if we never navigated
  //   if (!_meVm.hasMe) {
  //     _meVm.removeListener(_listener);
  //   }
  //   super.dispose();
  // }

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
