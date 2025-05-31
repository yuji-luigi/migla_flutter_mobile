import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/enums/input/input_types.dart';
import 'package:migla_flutter/src/widgets/inputs/controled_inputs/input_rounded_white_controlled.dart';

class PasswordInputControlled extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final Widget? suffixIcon;
  final String name;
  const PasswordInputControlled({
    super.key,
    required this.hintText,
    required this.name,
    this.controller,
    this.inputType = InputType.text,
    this.suffixIcon,
  });
  @override
  State<PasswordInputControlled> createState() =>
      _PasswordInputControlledState();
}

class _PasswordInputControlledState extends State<PasswordInputControlled> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return InputRoundedWhiteControlled(
      name: widget.name,
      hintText: widget.hintText,
      controller: widget.controller,
      inputType: widget.inputType,
      obscureText: isObscure,
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
