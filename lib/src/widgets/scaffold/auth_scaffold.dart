import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class AuthScaffold extends StatelessWidget {
  final List<Widget> children;
  const AuthScaffold({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
