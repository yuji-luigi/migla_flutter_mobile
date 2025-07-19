import 'package:flutter/material.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(child: Center(child: CircularProgressIndicator()));
  }
}
