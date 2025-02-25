import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Widget newScreen;
  final bool isNewTask;
  const LinkText(
    this.text, {
    super.key,
    required this.newScreen,
    this.isNewTask = true,
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
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
