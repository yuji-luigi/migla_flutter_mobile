import 'package:flutter/material.dart';
import 'package:migla_flutter/src/screens/auth/login_screen.dart';
import 'package:migla_flutter/src/widgets/link_text.dart';
import 'package:migla_flutter/src/widgets/scaffold/auth_scaffold.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      children: [
        Text("context.t.forgotPasswordscreenheader"),
        LinkText("back", newScreen: LoginScreen())
      ],
    );
  }
}
