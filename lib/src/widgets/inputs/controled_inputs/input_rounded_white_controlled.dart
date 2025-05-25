import 'package:flutter/material.dart';
import 'package:migla_flutter/src/view_models/form_view_model.dart';
import 'package:migla_flutter/src/widgets/inputs/input_rounded_white.dart';

class InputRoundedWhiteControlled extends StatefulWidget {
  final String name;
  final String? hintText;
  const InputRoundedWhiteControlled({
    super.key,
    required this.name,
    this.hintText,
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
    return InputRoundedWhite(hintText: widget.hintText, controller: controller);
  }
}
