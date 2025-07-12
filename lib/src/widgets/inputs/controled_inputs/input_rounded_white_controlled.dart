import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/enums/input/input_types.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class InputRoundedWhiteControlled extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final InputType inputType;
  final Widget? suffixIcon;
  final String name;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  const InputRoundedWhiteControlled({
    super.key,
    required this.hintText,
    required this.name,
    this.controller,
    this.inputType = InputType.text,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.autofillHints,
  });

  @override
  State<InputRoundedWhiteControlled> createState() =>
      _InputRoundedWhiteControlledState();
}

class _InputRoundedWhiteControlledState
    extends State<InputRoundedWhiteControlled> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Future.microtask(() {
      FormViewModel formViewModel = getFormViewModel(context);
      controller.text = formViewModel.formData[widget.name] ?? '';
      controller.addListener(() {
        formViewModel.setFormData(widget.name, controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputRoundedWhite(
      hintText: widget.hintText,
      keyboardType: widget.keyboardType,
      controller: controller,
      obscureText: widget.obscureText,
      suffixIcon: widget.suffixIcon,
      autofillHints: widget.autofillHints,
    );
  }
}
