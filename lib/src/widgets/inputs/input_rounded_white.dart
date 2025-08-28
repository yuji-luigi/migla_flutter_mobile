import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/enums/input/input_types.dart';
import 'package:migla_flutter/src/models/enums/regex_list.dart';

class InputRoundedWhite extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  const InputRoundedWhite({
    super.key,
    required this.hintText,
    this.controller,
    this.inputType = InputType.text,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      validator: (value) {
        if (keyboardType == TextInputType.emailAddress) {
          // check if valid email accept also alias like text+alias@gmail.com
          if (!emailRegex.hasMatch(value!)) {
            return context.t.invalidEmail;
          }
        }
        return validator?.call(value);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            borderSide: BorderSide.none, // Set border color to transparent
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon),
    );
  }
}
