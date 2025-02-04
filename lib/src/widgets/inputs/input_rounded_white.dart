import 'package:flutter/material.dart';

class InputRoundedWhite extends StatelessWidget {
  final String? hintText;
  const InputRoundedWhite({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(90)),
          borderSide: BorderSide.none, // Set border color to transparent
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
