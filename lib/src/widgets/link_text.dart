import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Widget newScreen;
  final bool isNewTask;
  final TextAlign? textAlign;
  const LinkText(
    this.text, {
    super.key,
    required this.newScreen,
    this.isNewTask = true,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        newScreen.launch(
          context,
          isNewTask: isNewTask,
        );
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
