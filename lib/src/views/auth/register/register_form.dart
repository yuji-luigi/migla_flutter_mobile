import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/spacings.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/input_rounded_white_controlled.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    FormViewModel formViewModel = $formViewModel(context);
    return Column(
      spacing: spacingAuthForm,
      children: [
        InputRoundedWhiteControlled(
          name: 'name_ja',
          hintText: context.t.labelNameJapanese,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                (formViewModel.formData['name_it'] == null ||
                    formViewModel.formData['name_it'] == '')) {
              return context.t.japaneseOrAlphabetIsRequired;
            }
            return null;
          },
        ),
        InputRoundedWhiteControlled(
          name: 'surname_ja',
          hintText: context.t.labelSurnameJapanese,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                (formViewModel.formData['surname_it'] == null ||
                    formViewModel.formData['surname_it'] == '')) {
              return context.t.japaneseOrAlphabetIsRequired;
            }
            return null;
          },
        ),
        InputRoundedWhiteControlled(
          name: 'name_it',
          hintText: context.t.labelName,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                (formViewModel.formData['name_ja'] == null ||
                    formViewModel.formData['name_ja'] == '')) {
              return context.t.japaneseOrAlphabetIsRequired;
            }
            return null;
          },
        ),
        InputRoundedWhiteControlled(
          name: 'surname_it',
          hintText: context.t.labelSurname,
          validator: (value) {
            if ((value == null || value.isEmpty) &&
                (formViewModel.formData['surname_ja'] == null ||
                    formViewModel.formData['surname_ja'] == '')) {
              return context.t.japaneseOrAlphabetIsRequired;
            }
            return null;
          },
        ),
        InputRoundedWhiteControlled(
          name: 'email',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.t.labelEmailRequired;
            }
            return null;
          },
          hintText: context.t.labelEmail,
        ),
        InputRoundedWhiteControlled(
          name: 'password',
          hintText: context.t.labelPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.t.labelPasswordRequired;
            }
            return null;
          },
        ),
        InputRoundedWhiteControlled(
          name: 'confirm_password',
          hintText: context.t.labelConfirmPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.t.fieldIsRequired;
            }
            if (value != formViewModel.formData['password']) {
              return context.t.passwordsDoNotMatch;
            }
            return null;
          },
        ),
      ],
    );
  }
}
