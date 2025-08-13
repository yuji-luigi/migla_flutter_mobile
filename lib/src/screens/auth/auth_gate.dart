import 'package:flutter/material.dart';
import 'package:migla_flutter/src/screens/auth/getstarted_screen.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/home/dashboard_home_screen.dart';
import 'package:migla_flutter/src/screens/splash_screen.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  final Widget child;
  const AuthGate({
    required this.child,
    super.key,
  });

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      MeViewModel meVm = $meViewModel(context, listen: false);
      StudentsViewModel studentsViewModel =
          $studentsViewModel(context, listen: false);
      await meVm.getMe();
      studentsViewModel.init();
      if (meVm.me != null) {
        studentsViewModel.getStudents(meVm.me!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeViewModel>(
      builder: (context, me, _) {
        if (me.isLoading) {
          return const SplashScreen(); // or a loading spinner
        }
        if (!me.hasMe) {
          return LoginScreen();
        }
        return widget.child;
      },
    );
  }
}
