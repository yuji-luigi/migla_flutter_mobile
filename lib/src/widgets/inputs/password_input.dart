import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/enums/input/input_types.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class PasswordInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final Widget? suffixIcon;
  const PasswordInput({
    super.key,
    required this.hintText,
    this.controller,
    this.inputType = InputType.text,
    this.suffixIcon,
  });
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return InputRoundedWhite(
      hintText: widget.hintText,
      controller: widget.controller,
      inputType: widget.inputType,
      suffixIcon: widget.suffixIcon ??
          IconButton(
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
    );
  }
}
