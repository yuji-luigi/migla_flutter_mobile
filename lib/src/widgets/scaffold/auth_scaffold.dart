import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/switch_language_flag_button.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final double spacing;
  const AuthScaffold({super.key, required this.child, this.spacing = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [SwitchLanguageFlagButton(), 24.width],
      ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthScaffoldColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  const AuthScaffoldColumn(
      {super.key, required this.children, this.spacing = 8});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
