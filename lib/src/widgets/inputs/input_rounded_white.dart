import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/enums/input/input_types.dart';

class InputRoundedWhite extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final Widget? suffixIcon;
  final bool obscureText;
  const InputRoundedWhite({
    super.key,
    required this.hintText,
    this.controller,
    this.inputType = InputType.text,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
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
