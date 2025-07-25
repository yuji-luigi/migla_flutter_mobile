import 'package:flutter/material.dart';
import 'package:migla_flutter/src/screens/auth/getstarted_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/screens/splash_screen.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MeViewModel>(
      builder: (context, me, _) {
        if (me.isLoading) {
          return const SplashScreen(); // or a loading spinner
        }

        return const GetStartedScreen();
      },
    );
  }
}
