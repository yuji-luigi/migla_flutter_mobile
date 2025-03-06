import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/spacings.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class FormEmailPassword extends StatelessWidget {
  const FormEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacingAuthForm,
      children: [
        InputRoundedWhite(
          hintText: context.t.labelName,
        ),
        InputRoundedWhite(
          hintText: context.t.labelSurname,
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
