import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class AuthScaffold extends StatelessWidget {
  final List<Widget> children;
  const AuthScaffold({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(bgCircleTopLeft),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(bgCircleBottomRight),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
