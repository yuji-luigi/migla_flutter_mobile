import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/widgets/buttons/button.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final MeViewModel _meVm;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();

    // 1) Grab your MeViewModel from Provider (it already started its init() in its constructor)
    _meVm = context.read<MeViewModel>();

    // 2) If it already has “me” (e.g. if the HTTP call resolved very quickly),
    //    then jump directly to your “home” or “dashboard” route:
    if (_meVm.hasMe) {
      _goToHome();
      return;
    }

    // 3) Otherwise, attach a listener so that the moment me becomes non‐null, we navigate.
    _listener = () {
      if (_meVm.hasMe) {
        // prevent further listener calls once we’ve navigated
        _meVm.removeListener(_listener);
        _goToHome();
      }
    };

    _meVm.addListener(_listener);
  }

  void _goToHome() {
    // Use addPostFrameCallback to avoid doing Navigator.push during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardHomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    // Clean up the listener if we never navigated
    if (!_meVm.hasMe) {
      _meVm.removeListener(_listener);
    }
    super.dispose();
  }

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
