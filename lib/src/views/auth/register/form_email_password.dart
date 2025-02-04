import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class FormEmailPassword extends StatelessWidget {
  const FormEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        InputRoundedWhite(
          hintText: context.t.labelNameSurname,
        ),
        InputRoundedWhite(
          hintText: context.t.labelEmail,
        ),
        InputRoundedWhite(
          hintText: context.t.labelPassword,
        ),
        InputRoundedWhite(
          hintText: context.t.labelConfirmPassword,
        ),
      ],
    );
  }
}
